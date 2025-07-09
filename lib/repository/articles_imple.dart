import '../models/article.dart';
import '../network/dio_client.dart';
import 'articles_repo.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final DioClient dioClient;

  ArticleRepositoryImpl(this.dioClient);

  @override
  @override
  Future<List<Article>> fetchArticles() async {
    final response = await dioClient.get('/posts');
    final List data = response.data;
    return data.map((json) => Article.fromJson(json)).toList();
  }
}