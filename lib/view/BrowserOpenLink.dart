import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserOpenLink extends StatefulWidget {
  const BrowserOpenLink({super.key});

  @override
  State<BrowserOpenLink> createState() => _BrowserOpenLinkState();
}

class _BrowserOpenLinkState extends State<BrowserOpenLink> {

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // Fullscreen mode
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("Loading: $url");
          },
          onPageFinished: (url) {
            debugPrint("Finished: $url");
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://fitamplify.com/product.php'),
      );
  }

  @override
  void dispose() {

    // Restore system UI when leaving page
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}