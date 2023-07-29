import 'package:flutter_clean_architecture_newsapp/core/resources/data_state.dart';
import 'package:flutter_clean_architecture_newsapp/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/repositories/article_repository.dart';

class GetDailyNewsUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  GetDailyNewsUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) =>
      _articleRepository.getDailyNews();
}
