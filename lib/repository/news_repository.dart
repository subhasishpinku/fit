// import 'package:aifitness/data/network/api_service.dart';

// import '../models/news_model.dart';

// class NewsRepository {
//   final ApiService _apiService = ApiService();

//   Future<List<NewsItem>> fetchNews(
//     int userId,
//     int categoryId,
//     String? deviceId,
//   ) async {
//     try {
//       // Use the reusable postRequest()
//       final response = await _apiService.postRequest(
//         "get-news-list-community-ai?page=1",
//         {"user_id": userId, "category_id": categoryId, "device_id": deviceId},
//       );
// final params = {
//   "user_id": userId,
//   "category_id": categoryId,
//   "device_id": deviceId,
// };

// print("get-news-list-community-ai $params");      final jsonData = response.data;

//       // Extract inside: data → data → []
//       List items = jsonData["data"]["data"];

//       return items.map((item) => NewsItem.fromJson(item)).toList();
//     } catch (e) {
//       throw Exception("News Fetch Error: $e");
//     }
//   }
// }
import 'package:aifitness/data/network/api_service.dart';
import '../models/news_model.dart';

class NewsRepository {
  final ApiService _apiService = ApiService();

  Future<List<NewsItem>> fetchNews(
    int userId,
    int categoryId,
    String? deviceId,
  ) async {
    try {
      final params = {
        "user_id": userId,
        "category_id": categoryId,
        "device_id": deviceId ?? "",
      };

      print("Fetching News - Params: $params");

      // Use the reusable postRequest()
      final response = await _apiService.postRequest(
        "get-news-list-community-ai?page=1",
        params,
      );

      print("News Response Status: ${response.statusCode}");
      print("News Response Data: ${response.data}");

      final jsonData = response.data;

      // Check if response is successful
      if (jsonData["success"] != true) {
        throw Exception(jsonData["message"] ?? "Failed to fetch news");
      }

      // Extract inside: data → data → []
      List items = jsonData["data"]["data"];

      if (items.isEmpty) {
        print("No news items found for category: $categoryId");
        return [];
      }

      print("Found ${items.length} items for category: $categoryId");
      
      // Log each item's vimeo link
      for (var item in items) {
        print("Item - Title: ${item['title']}, Vimeo Link: ${item['vimeo_link']}");
      }

      return items.map((item) => NewsItem.fromJson(item)).toList();
    } catch (e) {
      print("News Fetch Error: $e");
      throw Exception("News Fetch Error: $e");
    }
  }
}