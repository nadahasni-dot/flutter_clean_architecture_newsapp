// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/get_bookmarked_news_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/remove_article_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/save_article_usecase.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetBookmarkedNewsUseCase _getBookmarkedNewsUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc(
    this._getBookmarkedNewsUseCase,
    this._removeArticleUseCase,
    this._saveArticleUseCase,
  ) : super(const LocalArticleInitial()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<RemoveArticle>(onRemoveArticle);
  }

  FutureOr<void> onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    emit(const LocalArticleLoading());

    final articles = await _getBookmarkedNewsUseCase();

    emit(LocalArticleDone(articles));
  }

  FutureOr<void> onSaveArticle(
      SaveArticle event, Emitter<LocalArticleState> emit) async {
    await _saveArticleUseCase(params: event.article);

    final articles = await _getBookmarkedNewsUseCase();
    emit(LocalArticleDone(articles));
  }

  FutureOr<void> onRemoveArticle(
      RemoveArticle event, Emitter<LocalArticleState> emit) async {
    await _removeArticleUseCase(params: event.article);

    final articles = await _getBookmarkedNewsUseCase();
    emit(LocalArticleDone(articles));
  }
}
