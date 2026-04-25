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
      
      // Ensure first category is selected by default
      if (categories.isNotEmpty && selectedCategoryId == 0) {
        selectedCategoryId = categories.first.id;
      }
    } catch (e) {
      error = e.toString();
      print("getCategories Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
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

      print("Loading news for category: $categoryId");
      final news = await repository.fetchNews(userId, categoryId, deviceId);
      
      if (loadMore) {
        newsList.addAll(news);
      } else {
        newsList = news;
      }
      
      print("News loaded successfully: ${newsList.length} items for category: $categoryId");
      
      // Print each video link for debugging
      for (var i = 0; i < newsList.length; i++) {
        print("Video ${i+1}: ${newsList[i].vimeoLink}");
      }
      
    } catch (e) {
      errorMessage = e.toString();
      print("loadNews Error: $e");
    } finally {
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