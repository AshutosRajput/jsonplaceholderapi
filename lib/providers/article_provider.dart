import 'package:flutter/material.dart';
import '../models/article.dart';
import '../repository/articles_repo.dart'; // this should point to abstract class

class ArticleProvider extends ChangeNotifier {
  final ArticleRepository repository;

  ArticleProvider({required this.repository}) {
    fetchArticles();
  }

  List<Article> _articles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await repository.fetchArticles();
    } catch (e) {
      debugPrint('Error fetching articles: \$e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



}
