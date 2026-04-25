import 'package:aifitness/res/widgets/signin_second_appbarss.dart';
import 'package:aifitness/models/news_categories_model.dart';
import 'package:aifitness/models/news_model.dart';
import 'package:aifitness/viewModel/fit_network_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FitNetwork extends StatefulWidget {
  const FitNetwork({super.key});

  @override
  State<FitNetwork> createState() => _FitNetworkState();
}

class _FitNetworkState extends State<FitNetwork> {
  int userId = 0;
  String? deviceId = "";

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("user_id") ?? 0;
    deviceId = prefs.getString("device_id");

    print("User ID: $userId");
    print("Device ID: $deviceId");

    if (deviceId == null) return;

    // Kick off fetching categories + initial news
    Future.microtask(() {
      final vm = context.read<FitNetworkViewModel>();
      vm.getCategories().then((_) {
        // After categories load, load news for first category
        if (vm.categories.isNotEmpty) {
          final firstCategoryId = vm.categories.first.id;
          vm.setSelectedCategory(firstCategoryId);
          vm.loadNews(
            userId: userId,
            categoryId: firstCategoryId,
            deviceId: deviceId,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const SigninSecondAppBarss(),
        body: Consumer<FitNetworkViewModel>(
          builder: (context, vm, child) {
            // Show loading only on initial load
            if (vm.isLoading && vm.categories.isEmpty && vm.newsList.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Loading content..."),
                  ],
                ),
              );
            }

            // Show error with retry button
            if (vm.error != null || vm.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      vm.error ?? vm.errorMessage ?? "Something went wrong",
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        vm.clearError();
                        vm.getCategories();
                        vm.loadNews(
                          userId: userId,
                          categoryId: vm.selectedCategoryId,
                          deviceId: deviceId,
                        );
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Horizontal Category Bar
                if (vm.categories.isNotEmpty)
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: vm.categories.length,
                      itemBuilder: (_, index) {
                        final category = vm.categories[index];
                        final isSelected = vm.selectedCategoryId == category.id;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: GestureDetector(
                            onTap: () {
                              print("Category tapped: ${category.title} (ID: ${category.id})");
                              vm.setSelectedCategory(category.id);
                              vm.loadNews(
                                userId: userId,
                                categoryId: category.id,
                                deviceId: deviceId,
                              ).then((_) {
                                print("News loaded, count: ${vm.newsList.length}");
                                if (vm.newsList.isNotEmpty) {
                                  print("First video link: ${vm.newsList.first.vimeoLink}");
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.lightBlue.shade50
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  width: isSelected ? 1.5 : 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  category.title,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 8),

                // News List
                Expanded(
                  child: vm.isLoading
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text("Loading videos..."),
                            ],
                          ),
                        )
                      : vm.newsList.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.video_library_outlined,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No videos available",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      vm.loadNews(
                                        userId: userId,
                                        categoryId: vm.selectedCategoryId,
                                        deviceId: deviceId,
                                      );
                                    },
                                    child: const Text("Retry"),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                await vm.loadNews(
                                  userId: userId,
                                  categoryId: vm.selectedCategoryId,
                                  deviceId: deviceId,
                                );
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                itemCount: vm.newsList.length,
                                itemBuilder: (_, index) {
                                  final news = vm.newsList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    child: buildNewsCard(context, news, vm.selectedCategoryId),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildNewsCard(BuildContext context, NewsItem news, int selectedCategoryId) {
    // Safely get video ID
    String? videoId;
    try {
      videoId = YoutubePlayer.convertUrlToId(news.vimeoLink);
      print("Video ID for ${news.title}: $videoId");
    } catch (e) {
      print("Error converting URL: ${news.vimeoLink}");
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (logo + time)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Logo with error handling
                ClipRRect(
                  borderRadius: BorderRadius.circular(21),
                  child: Image.asset(
                    "assets/images/logo2.png",
                    width: 80,
                    height: 60,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to colored container if image not found
                      return Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: const Icon(
                          Icons.fitness_center,
                          color: Colors.blue,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.categoryTitle.isNotEmpty
                            ? news.categoryTitle
                            : "FitAmplify",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        news.createdAtFormatted,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, size: 20),
                  onPressed: () {
                    // Add share or report options
                    _showOptionsMenu(context, news);
                  },
                ),
              ],
            ),
          ),

          // Title
          if (news.title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                news.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
            ),

          const SizedBox(height: 12),

          // YouTube Player with unique key and loading state
          if (news.vimeoLink.isNotEmpty && videoId != null)
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _YouTubePlayerWithLoading(
                  key: ValueKey('video_${news.id}_$selectedCategoryId'),
                  videoId: videoId,
                ),
              ),
            ),
          
          if (videoId == null && news.vimeoLink.isNotEmpty)
            Container(
              height: 200,
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.grey.shade100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle_outline, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text(
                      "Video unavailable",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context, NewsItem news) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text("Share"),
                onTap: () {
                  Navigator.pop(context);
                  // Add share functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.report_problem),
                title: const Text("Report"),
                onTap: () {
                  Navigator.pop(context);
                  // Add report functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Separate widget for YouTube player with loading state
class _YouTubePlayerWithLoading extends StatefulWidget {
  final String videoId;
  
  const _YouTubePlayerWithLoading({
    super.key,
    required this.videoId,
  });

  @override
  State<_YouTubePlayerWithLoading> createState() => _YouTubePlayerWithLoadingState();
}

class _YouTubePlayerWithLoadingState extends State<_YouTubePlayerWithLoading> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void didUpdateWidget(_YouTubePlayerWithLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      _controller.load(widget.videoId);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blue,
          onReady: () {
            setState(() {
              _isPlayerReady = true;
            });
            print('YouTube Player is ready for video: ${widget.videoId}');
          },
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                playedColor: Colors.blue,
                handleColor: Colors.blueAccent,
              ),
            ),
            RemainingDuration(),
          ],
        ),
        if (!_isPlayerReady)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}