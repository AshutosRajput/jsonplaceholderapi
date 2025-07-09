
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technicaltest/config/routes/routes.dart';
import 'package:technicaltest/repository/articles_imple.dart';
import 'network/dio_client.dart';
import 'providers/article_provider.dart';
import 'screens/article_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleProvider(
        repository: ArticleRepositoryImpl(DioClient()), // Injecting the implementation
      ),

      child: MaterialApp(
        title: 'Articles App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
       initialRoute: AppRoutes.home,
       onGenerateRoute: AppRoutes.generateRoute,

      ),
    );
  }
}
