import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';
import '../repository/articles_repo.dart';

class ArticleProvider extends ChangeNotifier {
  final ArticleRepository repository;

  ArticleProvider({required this.repository}) {
    fetchArticles();
    loadFavorites();
  }

  List<Article> _articles = [];
  bool _isLoading = false;
  Set<int> _favoriteArticleIds = {};

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  Set<int> get favoriteArticleIds => _favoriteArticleIds;

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await repository.fetchArticles();
    } catch (e) {
      debugPrint('Error fetching articles: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(int id) => _favoriteArticleIds.contains(id);

  void toggleFavorite(int id) {
    if (_favoriteArticleIds.contains(id)) {
      _favoriteArticleIds.remove(id);
    } else {
      _favoriteArticleIds.add(id);
    }
    saveFavorites();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites') ?? [];
    _favoriteArticleIds = favList.map((e) => int.tryParse(e) ?? -1).where((id) => id != -1).toSet();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteArticleIds.map((e) => e.toString()).toList());
  }

  Future<void> refreshData() async {
    await fetchArticles();
  }
}
