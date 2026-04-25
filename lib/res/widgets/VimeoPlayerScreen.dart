import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VimeoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final double? height;

  const VimeoPlayerScreen({super.key, required this.videoUrl, this.height});

  @override
  State<VimeoPlayerScreen> createState() => _VimeoPlayerScreenState();
}

class _VimeoPlayerScreenState extends State<VimeoPlayerScreen> {
  late WebViewController controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    try {
      String videoId = _extractVimeoId(widget.videoUrl);
      
      if (videoId.isEmpty) {
        setState(() {
          _errorMessage = "Invalid Vimeo URL";
          _isLoading = false;
        });
        return;
      }

      // Proper Vimeo embed URL with all necessary parameters
      final embedUrl = "https://player.vimeo.com/video/$videoId";
      
      print("🎬 Vimeo Video ID: $videoId");
      print("🎬 Embed URL: $embedUrl");

      // Complete HTML with proper headers and meta tags
      final embedHtml = """
        <!DOCTYPE html>
        <html>
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
            <meta http-equiv="Content-Security-Policy" content="default-src * 'unsafe-inline' 'unsafe-eval' data: blob:; script-src * 'unsafe-inline' 'unsafe-eval'; style-src * 'unsafe-inline';">
            <style>
              * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
              }
              
              body, html {
                margin: 0;
                padding: 0;
                background: #000000;
                width: 100%;
                height: 100%;
                overflow: hidden;
              }
              
              .video-wrapper {
                position: relative;
                width: 100%;
                height: 100%;
                background: #000;
              }
              
              .video-wrapper iframe {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border: none;
              }
            </style>
          </head>
          <body>
            <div class="video-wrapper">
              <iframe 
                src="$embedUrl?autoplay=0&autopause=0&background=0&byline=0&color=00ADEF&controls=1&dnt=1&loop=0&portrait=0&title=0&transparent=0"
                frameborder="0"
                allow="autoplay; fullscreen; picture-in-picture; encrypted-media"
                allowfullscreen
                webkitallowfullscreen
                mozallowfullscreen>
              </iframe>
            </div>
          </body>
        </html>
      """;

      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.black)
        ..setUserAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              print("🌐 Page started: $url");
              setState(() => _isLoading = true);
            },
            onPageFinished: (String url) {
              print("✅ Page finished: $url");
              setState(() => _isLoading = false);
            },
            onNavigationRequest: (NavigationRequest request) {
              print("🔗 Navigation requested: ${request.url}");
              
              // Allow Vimeo domains and prevent redirects
              if (request.url.contains('vimeo.com') || 
                  request.url.contains('player.vimeo.com')) {
                return NavigationDecision.navigate;
              }
              
              // Block external redirects
              if (!request.url.startsWith('data:') && 
                  !request.url.contains('vimeo.com')) {
                return NavigationDecision.prevent;
              }
              
              return NavigationDecision.navigate;
            },
            onWebResourceError: (error) {
              print("❌ WebView Error: ${error.description}");
              setState(() {
                _errorMessage = error.description;
                _isLoading = false;
              });
            },
          ),
        )
        ..loadHtmlString(embedHtml, baseUrl: "https://player.vimeo.com");
        
    } catch (e) {
      print("❌ Error initializing Vimeo player: $e");
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  String _extractVimeoId(String url) {
    final patterns = [
      RegExp(r'vimeo\.com\/(\d+)'),
      RegExp(r'player\.vimeo\.com\/video\/(\d+)'),
      RegExp(r'vimeo\.com\/(\d+)\?'),
      RegExp(r'(?:https?:\/\/)?(?:www\.)?vimeo\.com\/(\d+)'),
    ];

    for (var pattern in patterns) {
      final match = pattern.firstMatch(url);
      if (match != null && match.group(1) != null) {
        return match.group(1)!;
      }
    }
    
    return '';
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Container(
        height: widget.height ?? 200,
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text(
                'Failed to load video',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: widget.height ?? 200,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: WebViewWidget(controller: controller),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}