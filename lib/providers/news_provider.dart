import 'package:flutter/foundation.dart';
import '../models/article.dart';
import '../services/api_service.dart';

enum NewsStatus { initial, loading, success, error }

class NewsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  NewsStatus _status = NewsStatus.initial;
  List<Article> _articles = [];
  final Set<int> _favoriteIds = {};
  String _searchQuery = '';
  String? _errorMessage;

  NewsStatus get status => _status;
  List<Article> get articles => _articles;
  String get searchQuery => _searchQuery;
  String? get errorMessage => _errorMessage;
  int get favoriteCount => _favoriteIds.length;

  List<Article> get filteredArticles {
    if (_searchQuery.trim().isEmpty) {
      return _articles;
    }
    final query = _searchQuery.toLowerCase();
    return _articles.where((article) {
      return article.title.toLowerCase().contains(query);
    }).toList();
  }

  List<Article> get favoriteArticles {
    return _articles.where((article) => _favoriteIds.contains(article.id)).toList();
  }

  bool isFavorite(int articleId) {
    return _favoriteIds.contains(articleId);
  }

  void toggleFavorite(int articleId) {
    if (_favoriteIds.contains(articleId)) {
      _favoriteIds.remove(articleId);
    } else {
      _favoriteIds.add(articleId);
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> fetchArticles() async {
    _status = NewsStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await _apiService.fetchArticles();
      _status = NewsStatus.success;
    } catch (e) {
      _status = NewsStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    notifyListeners();
  }
}
