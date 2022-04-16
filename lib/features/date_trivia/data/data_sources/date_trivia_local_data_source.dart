import 'dart:convert';

import 'package:date_trivia/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/date_trivia_model.dart';

abstract class DateTriviaLocalDataSource {
  Future<DateTriviaModel>? getLastDateTrivia();
  Future<void>? cachedDateTrivia(DateTriviaModel triviaToCache);
}

// ignore: constant_identifier_names
const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class DateTriviaLocalDataSourceImpl implements DateTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  DateTriviaLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<void>? cachedDateTrivia(DateTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(triviaToCache.toJson()),
    );
  }

  @override
  Future<DateTriviaModel>? getLastDateTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    // Future which is immediately completed
    if (jsonString != null) {
      return Future.value(DateTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
