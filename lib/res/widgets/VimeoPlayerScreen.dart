import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VimeoPlayerScreen extends StatefulWidget {
  final String videoUrl; // Accepts normal Vimeo URL

  const VimeoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VimeoPlayerScreen> createState() => _VimeoPlayerScreenState();
}

class _VimeoPlayerScreenState extends State<VimeoPlayerScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    // Convert URL if user passes normal Vimeo URL
    final playerUrl = widget.videoUrl.contains("player.vimeo.com")
        ? widget.videoUrl
        : widget.videoUrl.replaceAll("vimeo.com/", "player.vimeo.com/video/");

    // Create HTML embed
    final embedHtml =
        """
      <!DOCTYPE html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
        </head>
        <body style="margin:0; background-color:black;">
          <iframe 
            src="$playerUrl"
            width="100%" height="100%" 
            frameborder="0"
            allow="autoplay; fullscreen; picture-in-picture"
            allowfullscreen>
          </iframe>
        </body>
      </html>
    """;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
        "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            debugPrint("WebView Error: ${error.description}");
          },
        ),
      )
      ..loadHtmlString(embedHtml, baseUrl: "https://player.vimeo.com")
      ..loadRequest(
        Uri.parse(playerUrl),
        headers: {
          "Referer": "https://player.vimeo.com",
          "Origin": "https://player.vimeo.com",
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewWidget(controller: controller));
  }
}
