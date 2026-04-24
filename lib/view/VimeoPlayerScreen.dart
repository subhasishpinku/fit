import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VimeoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VimeoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VimeoPlayerScreen> createState() => _VimeoPlayerScreenState();
}

class _VimeoPlayerScreenState extends State<VimeoPlayerScreen> {
  late final WebViewController _controller;

  String _extractVideoId(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.pathSegments.last;
    } catch (e) {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();

    final videoId = _extractVideoId(widget.videoUrl);

    final html = '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
      <style>
        body { margin:0; background:black; }
        iframe { position:absolute; top:0; left:0; width:100%; height:100%; }
      </style>
    </head>
    <body>
      <iframe 
        src="https://player.vimeo.com/video/$videoId?autoplay=0&muted=0" 
        frameborder="0" 
        allow="autoplay; fullscreen; picture-in-picture"
        allowfullscreen>
      </iframe>
    </body>
    </html>
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: WebViewWidget(controller: _controller),
    );
  }
}