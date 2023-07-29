import 'package:flutter_clean_architecture_newsapp/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/repositories/article_repository.dart';

class RemoveArticleUseCase extends UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  RemoveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.removeArticle(params!);
  }
}
