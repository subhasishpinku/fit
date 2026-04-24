// import 'package:aifitness/models/news_categories_model.dart';
// import 'package:aifitness/models/news_model.dart';
// import 'package:aifitness/repository/news_category_repository.dart';
// import 'package:aifitness/repository/news_repository.dart';
// import 'package:flutter/material.dart';

// class FitNetworkViewModel extends ChangeNotifier {
//   final _repo = NewsCategoryRepository();
//   final repository = NewsRepository();
//   int selectedCategoryId = 0;

//   bool isLoading = false;
//   String? error;
//   List<NewsCategory> categories = [];
//   List<NewsItem> newsList = [];
//   String? errorMessage;
//   Future<void> getCategories() async {
//     isLoading = true;
//     error = null;
//     notifyListeners();

//     try {
//       final response = await _repo.fetchCategories();
//       categories = response.data;
//     } catch (e) {
//       error = e.toString();
//       print("getCategories $e");
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   Future<void> loadNews({required int userId, required int categoryId, String? deviceId}) async {
//     try {
//       isLoading = true;
//       notifyListeners();

//       newsList = await repository.fetchNews(userId,categoryId,deviceId);
//       print("newsList ${newsList.toString()}");
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       errorMessage = e.toString();
//       print("newsList $e");
//       isLoading = false;
//       notifyListeners();
//     }
//   }


// void setSelectedCategory(int id) {
//   selectedCategoryId = id;
//   notifyListeners();
// }
// }
import 'package:aifitness/models/news_categories_model.dart';
import 'package:aifitness/models/news_model.dart';
import 'package:aifitness/repository/news_category_repository.dart';
import 'package:aifitness/repository/news_repository.dart';
import 'package:flutter/material.dart';

class FitNetworkViewModel extends ChangeNotifier {
  final _repo = NewsCategoryRepository();
  final repository = NewsRepository();
  int selectedCategoryId = 0;

  bool isLoading = false;
  bool isLoadingMore = false;
  String? error;
  List<NewsCategory> categories = [];
  List<NewsItem> newsList = [];
  String? errorMessage;
  
  int currentPage = 1;
  bool hasMorePages = true;

  Future<void> getCategories() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await _repo.fetchCategories();
      categories = response.data;
      print("Categories loaded: ${categories.length}");
      
      // Ensure "All" category is selected by default
      if (categories.isNotEmpty && selectedCategoryId == 0) {
        selectedCategoryId = categories.first.id;
      }
    } catch (e) {
      error = e.toString();
      print("getCategories Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadNews({
    required int userId, 
    required int categoryId, 
    String? deviceId,
    bool loadMore = false,
  }) async {
    try {
      if (loadMore) {
        isLoadingMore = true;
      } else {
        isLoading = true;
        currentPage = 1;
        hasMorePages = true;
      }
      notifyListeners();

      final news = await repository.fetchNews(userId, categoryId, deviceId);
      
      if (loadMore) {
        newsList.addAll(news);
      } else {
        newsList = news;
      }
      
      print("News loaded: ${newsList.length} items for category: $categoryId");
      
      if (loadMore) {
        isLoadingMore = false;
      } else {
        isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      print("loadNews Error: $e");
      
      if (loadMore) {
        isLoadingMore = false;
      } else {
        isLoading = false;
      }
      notifyListeners();
    }
  }

  void setSelectedCategory(int id) {
    selectedCategoryId = id;
    notifyListeners();
  }
  
  void clearError() {
    error = null;
    errorMessage = null;
    notifyListeners();
  }
}