// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_newsapp/core/resources/data_state.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/get_daily_news_usecase.dart';

part 'remote_article_event.dart';
part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetDailyNewsUseCase _getDailyNewsUseCase;

  RemoteArticleBloc(this._getDailyNewsUseCase)
      : super(const RemoteArticleInitial()) {
    on<GetArticles>(onGetArticles);
  }

  FutureOr<void> onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    emit(const RemoteArticleLoading());

    final dataState = await _getDailyNewsUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticleDone(dataState.data!));
    }

    if (dataState is DataFailed && dataState.data!.isNotEmpty) {
      emit(RemoteArticleError(dataState.error!));
    }
  }

  @override
  void onChange(Change<RemoteArticleState> change) {
    super.onChange(change);

    log(change.currentState.articles.toString());
    log(change.nextState.articles.toString());
  }
}
