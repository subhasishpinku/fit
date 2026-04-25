import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  bool _isReleased = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    _isReleased = true;
    super.dispose();
  }

  void _initializePlayer() async {
    try {
      String videoId = _extractVimeoId(widget.videoUrl);
      
      if (videoId.isEmpty) {
        if (!_isReleased) {
          setState(() {
            _errorMessage = "Invalid Vimeo URL";
            _isLoading = false;
          });
        }
        return;
      }

      final embedUrl = "https://player.vimeo.com/video/$videoId";
      
      debugPrint("🎬 Vimeo Video ID: $videoId");
      debugPrint("🎬 Embed URL: $embedUrl");

      // Enhanced HTML with better error handling
      final embedHtml = """
        <!DOCTYPE html>
        <html>
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
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
              
              .error-message {
                color: white;
                text-align: center;
                padding: 20px;
                font-family: sans-serif;
              }
            </style>
          </head>
          <body>
            <div class="video-wrapper">
              <iframe 
                src="$embedUrl?autoplay=0&autopause=0&background=0&byline=0&color=00ADEF&controls=1&dnt=1&loop=0&portrait=0&title=0&transparent=0&api=1&player_id=vimeo-player"
                frameborder="0"
                allow="autoplay; fullscreen; picture-in-picture; encrypted-media; accelerometer; gyroscope"
                allowfullscreen
                webkitallowfullscreen
                mozallowfullscreen>
              </iframe>
            </div>
            <script>
              window.onerror = function(msg, url, line, col, error) {
                console.log('Error: ' + msg);
                return false;
              };
              
              // Log when iframe loads
              document.querySelector('iframe').addEventListener('load', function() {
                console.log('Vimeo iframe loaded');
              });
            </script>
          </body>
        </html>
      """;

      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.black)
        ..setUserAgent("Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36")
        ..enableZoom(false)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              debugPrint("🌐 Page started: $url");
              if (!_isReleased) {
                setState(() => _isLoading = true);
              }
            },
            onPageFinished: (String url) {
              debugPrint("✅ Page finished: $url");
              if (!_isReleased) {
                setState(() => _isLoading = false);
              }
            },
            onNavigationRequest: (NavigationRequest request) {
              debugPrint("🔗 Navigation requested: ${request.url}");
              
              if (request.url.contains('vimeo.com') || 
                  request.url.contains('player.vimeo.com')) {
                return NavigationDecision.navigate;
              }
              
              if (!request.url.startsWith('data:') && 
                  !request.url.contains('vimeo.com')) {
                return NavigationDecision.prevent;
              }
              
              return NavigationDecision.navigate;
            },
            onWebResourceError: (error) {
              debugPrint("❌ WebView Error: ${error.description}");
              if (!_isReleased) {
                setState(() {
                  _errorMessage = error.description;
                  _isLoading = false;
                });
              }
            },
          ),
        );
      
      // Load HTML with proper base URL
      await controller.loadHtmlString(embedHtml, baseUrl: "https://player.vimeo.com");
      
    } catch (e) {
      debugPrint("❌ Error initializing Vimeo player: $e");
      if (!_isReleased) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
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
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _errorMessage = null;
                    _isLoading = true;
                  });
                  _initializePlayer();
                },
                child: const Text('Retry'),
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