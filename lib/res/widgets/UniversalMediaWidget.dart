import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UniversalMediaWidget extends StatefulWidget {
  final String mediaUri; // may be relative or absolute
  final String mediaUrl; // full resolved URL
  final double height;

  const UniversalMediaWidget({
    Key? key,
    required this.mediaUri,
    required this.mediaUrl,
    this.height = 220,
  }) : super(key: key);

  @override
  State<UniversalMediaWidget> createState() => _UniversalMediaWidgetState();
}

class _UniversalMediaWidgetState extends State<UniversalMediaWidget> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _videoInitFailed = false;

  bool get _isVimeo =>
      widget.mediaUrl.contains('vimeo.com') ||
      widget.mediaUri.contains('vimeo.com') ||
      widget.mediaUrl.contains('player.vimeo.com');

  bool get _isHttpFile =>
      widget.mediaUrl.startsWith('http') &&
      (widget.mediaUrl.endsWith('.mp4') ||
          widget.mediaUrl.contains('.m3u8') ||
          widget.mediaUrl.contains('.webm'));

  @override
  void initState() {
    super.initState();
    if (_isHttpFile) {
      _initVideo(widget.mediaUrl);
    }
  }

  Future<void> _initVideo(String url) async {
    try {
      _videoController = VideoPlayerController.network(url);
      await _videoController!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: false,
        looping: false,
      );
      if (mounted) setState(() {});
    } catch (e) {
      _videoInitFailed = true;
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 If a video is initialized → play with Chewie
    if (_chewieController != null &&
        _videoController != null &&
        _videoController!.value.isInitialized) {
      return SizedBox(
        height: widget.height,
        child: Chewie(controller: _chewieController!),
      );
    }

    // 🔹 If video failed OR Vimeo detected → load in WebView iframe
    if (_videoInitFailed || _isVimeo) {
      final embedHtml =
          '''
        <!doctype html>
        <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
              body,html { margin:0;padding:0;background:#000; }
              iframe { position:fixed; top:0; left:0; width:100%; height:100%; }
            </style>
          </head>
          <body>
            <iframe src="${widget.mediaUrl}"
              frameborder="0"
              allow="autoplay; fullscreen; picture-in-picture"
              allowfullscreen>
            </iframe>
          </body>
        </html>
      ''';

      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadHtmlString(embedHtml);

      return SizedBox(
        height: widget.height,
        child: WebViewWidget(controller: controller),
      );
    }

    // 🔹 If http video link but not yet initialized → show loader
    if (_isHttpFile) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    // 🔹 Fallback → no media found
    return SizedBox(
      height: widget.height,
      child: const Center(child: Text('No media found')),
    );
  }
}
