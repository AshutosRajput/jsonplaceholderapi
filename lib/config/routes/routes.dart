
import 'package:flutter/material.dart';
import '../../models/article.dart';
import '../../screens/article_detail_screen.dart';
import '../../screens/article_list_screen.dart';


class AppRoutes {
  static const String home = '/';
  static const String detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const ArticleListScreen());
      case detail:
        final article = settings.arguments as Article;
        return MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
