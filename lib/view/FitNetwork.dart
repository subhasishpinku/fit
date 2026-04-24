// // lib/screens/fit_network_screen.dart
// import 'package:aifitness/res/widgets/signin_second_appbarss.dart';
// import 'package:aifitness/models/news_categories_model.dart';
// import 'package:aifitness/models/news_model.dart';
// import 'package:aifitness/repository/news_category_repository.dart';
// import 'package:aifitness/repository/news_repository.dart';
// import 'package:aifitness/res/widgets/youtube_player_screen.dart';
// import 'package:aifitness/viewModel/fit_network_viewModel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// /// Full FitNetwork screen — single-file example (ViewModel + Model included)
// /// NOTE: Replace repository calls with your real implementations.
// /// Make sure provider is registered above this screen:
// /// ChangeNotifierProvider(create: (_) => FitNetworkViewModel(), child: FitNetwork())

// class FitNetwork extends StatefulWidget {
//   const FitNetwork({super.key});

//   @override
//   State<FitNetwork> createState() => _FitNetworkState();
// }

// class _FitNetworkState extends State<FitNetwork> {
//   int userId = 0;
//   String? deviceId = "";
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     load();
//   }

//   Future<void> load() async {
//     final prefs = await SharedPreferences.getInstance();
//     userId = prefs.getInt("user_id") ?? 0;
//     deviceId = prefs.getString("device_id");

//     if (deviceId == null) return;

//     // Kick off fetching categories + initial news
//     Future.microtask(() {
//       final vm = context.read<FitNetworkViewModel>();
//       vm.getCategories();
//       vm.loadNews(userId: userId, categoryId: 0, deviceId: deviceId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor: Colors.white, // <-- ADD THIS

//         appBar: const SigninSecondAppBarss(),
//         body: Consumer<FitNetworkViewModel>(
//           builder: (context, vm, child) {
//             if (vm.isLoading && vm.categories.isEmpty && vm.newsList.isEmpty) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (vm.error != null) {
//               return Center(
//                 child: Text(
//                   vm.error!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               );
//             }

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // -------------------
//                 //  HORIZONTAL CATEGORY BAR
//                 // -------------------
//                 SizedBox(
//                   height: 60,
//                   child: vm.categories.isEmpty
//                       ? const SizedBox.shrink()
//                       : ListView.builder(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 8,
//                           ),
//                           scrollDirection: Axis.horizontal,
//                           itemCount: vm.categories.length,
//                           itemBuilder: (_, index) {
//                             final category = vm.categories[index];
//                             final isSelected =
//                                 vm.selectedCategoryId == category.id;

//                             return Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 6,
//                               ),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   vm.setSelectedCategory(category.id);
//                                   vm.loadNews(
//                                     userId: userId,
//                                     categoryId: category.id,
//                                     deviceId: deviceId,
//                                   );
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                     vertical: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? Colors.lightBlue.shade50
//                                         : Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                       color: isSelected
//                                           ? Colors.blue
//                                           : Colors.grey.shade300,
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       category.title,
//                                       style: TextStyle(
//                                         color: isSelected
//                                             ? Colors.blue
//                                             : Colors.black87,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 ),

//                 const SizedBox(height: 8),

//                 // -------------------
//                 //  NEWS LIST
//                 // -------------------
//                 Expanded(
//                   child: vm.newsList.isEmpty
//                       ? const Center(child: Text("No news available"))
//                       : ListView.builder(
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           itemCount: vm.newsList.length,
//                           itemBuilder: (_, index) {
//                             final news = vm.newsList[index];
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 8,
//                               ),
//                               child: buildNewsCard(context, news),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildNewsCard(BuildContext context, NewsItem news) {
//     final thumb = generateThumbnail(news.vimeoLink);

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.06),
//             blurRadius: 6,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header (logo + time)
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 // Replace with your logo or network avatar
//                 ClipOval(
//                   child: Container(
//                     height: 42,
//                     width: 42,
//                     child: Center(
//                       child: Image.asset(
//                         "assets/images/logo2.png", // <-- your image path
//                         width: 42,
//                         height: 42,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         news.categoryTitle.isNotEmpty
//                             ? news.categoryTitle
//                             : "FitAmplify",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         news.createdAtFormatted,
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.more_horiz),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),

//           // Title
//           if (news.title.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Text(
//                 news.title,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),

//           const SizedBox(height: 8),
//           // Direct YouTube Player (auto loads without click)
//           if (news.vimeoLink.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: YoutubePlayer(
//                 controller: YoutubePlayerController(
//                   initialVideoId:
//                       YoutubePlayer.convertUrlToId(news.vimeoLink) ?? "",
//                   flags: const YoutubePlayerFlags(
//                     autoPlay: false, // change to true if you want auto-play
//                     mute: false,
//                   ),
//                 ),
//                 showVideoProgressIndicator: true,
//               ),
//             ),

//           // Thumbnail with play overlay
//           // GestureDetector(
//           //   onTap: () => _openUrl(news.vimeoLink),
//           //   child: ClipRRect(
//           //     borderRadius: const BorderRadius.only(
//           //       bottomLeft: Radius.circular(12),
//           //       bottomRight: Radius.circular(12),
//           //     ),
//           //     child: Stack(
//           //       alignment: Alignment.center,
//           //       children: [
//           //         // Thumbnail image
//           //         SizedBox(
//           //           height: 220,
//           //           width: double.infinity,
//           //           child: thumb != null
//           //               ? Image.network(
//           //                   thumb,
//           //                   fit: BoxFit.cover,
//           //                   errorBuilder: (c, e, s) {
//           //                     return _thumbnailFallback();
//           //                   },
//           //                 )
//           //               : _thumbnailFallback(),
//           //         ),

//           //         // Play overlay
//           //         Container(
//           //           decoration: BoxDecoration(
//           //             color: Colors.black45,
//           //             shape: BoxShape.circle,
//           //           ),
//           //           padding: const EdgeInsets.all(8),
//           //           child: const Icon(
//           //             Icons.play_arrow,
//           //             size: 40,
//           //             color: Colors.white,
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _thumbnailFallback() {
//     return Container(
//       height: 220,
//       color: Colors.grey[300],
//       child: const Center(
//         child: Icon(Icons.play_arrow, size: 64, color: Colors.white70),
//       ),
//     );
//   }

//   Future<void> _openUrl(String? url) async {
//     if (url == null || url.isEmpty) return;

//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => YoutubePlayerScreen(url: url)),
//     );
//   }

//   /// Attempts to generate a thumbnail url for common YouTube/shorts/youtu.be links.
//   /// returns `null` when no thumbnail strategy found (caller uses fallback).
//   String? generateThumbnail(String url) {
//     if (url.isEmpty) return null;

//     final lower = url.toLowerCase();

//     // 1) youtu.be/{id}
//     if (lower.contains('youtu.be/')) {
//       try {
//         final id = url
//             .split('youtu.be/')
//             .last
//             .split('?')
//             .first
//             .split('&')
//             .first;
//         return 'https://img.youtube.com/vi/$id/0.jpg';
//       } catch (_) {
//         return null;
//       }
//     }

//     // 2) youtube.com/watch?v={id}
//     if (lower.contains('youtube.com/watch')) {
//       final uri = Uri.tryParse(url);
//       final v = uri?.queryParameters['v'];
//       if (v != null && v.isNotEmpty) {
//         return 'https://img.youtube.com/vi/$v/0.jpg';
//       }
//     }

//     // 3) youtube.com/shorts/{id}
//     if (lower.contains('/shorts/')) {
//       try {
//         final id = url.split('/shorts/').last.split('?').first.split('&').first;
//         return 'https://img.youtube.com/vi/$id/0.jpg';
//       } catch (_) {
//         return null;
//       }
//     }

//     // 4) regular youtube domain with other patterns (try to find v=)
//     if (lower.contains('youtube.com')) {
//       final uri = Uri.tryParse(url);
//       final v = uri?.queryParameters['v'];
//       if (v != null && v.isNotEmpty) {
//         return 'https://img.youtube.com/vi/$v/0.jpg';
//       }
//     }

//     // 5) Vimeo: you may want to call Vimeo API for real thumbnails.
//     if (lower.contains('vimeo.com')) {
//       // You need to fetch Vimeo API to get real thumbnail. return null to use placeholder.
//       return null;
//     }

//     return null;
//   }
// }
// lib/screens/fit_network_screen.dart
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
                              vm.setSelectedCategory(category.id);
                              vm.loadNews(
                                userId: userId,
                                categoryId: category.id,
                                deviceId: deviceId,
                              );
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
                  child: vm.newsList.isEmpty
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
                              if (vm.isLoading == false)
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
                                child: buildNewsCard(context, news),
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

  Widget buildNewsCard(BuildContext context, NewsItem news) {
    // Safely get video ID
    String? videoId;
    try {
      videoId = YoutubePlayer.convertUrlToId(news.vimeoLink);
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

          // YouTube Player
          if (news.vimeoLink.isNotEmpty && videoId != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                      controlsVisibleAtStart: true,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blue,
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