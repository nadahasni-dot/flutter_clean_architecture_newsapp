// ignore_for_file: depend_on_referenced_packages

import 'package:floor/floor.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/data_sources/local/DAO/article_dao.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/models/article_model.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDAO;
}
