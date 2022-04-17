import 'dart:convert';

import 'package:date_trivia/core/error/exceptions.dart';

import '../models/date_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class DateTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DateTriviaModel>? getConcreteDateTrivia(String? date);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DateTriviaModel>? getRandomDateTrivia();
}

class DateTriviaRemoteDataSourceImpl implements DateTriviaRemoteDataSource {
  final http.Client client;
  DateTriviaRemoteDataSourceImpl(this.client);
  @override
  Future<DateTriviaModel>? getConcreteDateTrivia(String? date) async {
    return _getDateTriviaFromUrl('http://numbersapi.com/$date/date');
  }

  @override
  Future<DateTriviaModel>? getRandomDateTrivia() async {
    return _getDateTriviaFromUrl('http://numbersapi.com/#random/date');
  }

  Future<DateTriviaModel> _getDateTriviaFromUrl(String url) async {
    final result = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (result.statusCode == 200) {
      return DateTriviaModel.fromJson(json.decode(result.body));
    } else {
      throw ServerException();
    }
  }
}
