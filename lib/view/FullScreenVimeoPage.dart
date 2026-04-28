import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aifitness/res/widgets/VimeoPlayerScreen.dart';

class FullScreenVimeoPage extends StatefulWidget {
  final String videoUrl;

  const FullScreenVimeoPage({super.key, required this.videoUrl});

  @override
  State<FullScreenVimeoPage> createState() => _FullScreenVimeoPageState();
}

class _FullScreenVimeoPageState extends State<FullScreenVimeoPage> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VimeoPlayerScreen(
        videoUrl: widget.videoUrl,
        height: MediaQuery.of(context).size.height,
        enableFullscreen: false, // Prevent infinite loop
      ),
    );
  }
}