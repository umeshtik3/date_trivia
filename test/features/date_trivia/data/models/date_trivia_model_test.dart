import 'dart:convert';

import 'package:date_trivia/features/date_trivia/data/models/date_trivia_model.dart';
import 'package:date_trivia/features/date_trivia/domain/entities/date_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixure/fixure_reader.dart';

void main() {
  const tDateTriviaModel = DateTriviaModel( text: 'Test text');

  test('should be a sub class of date trivia entity', () async {
    expect(tDateTriviaModel, isA<DateTrivia>());
  });

  group('from json', () {
    test('should retrun valid model when the JSON string as date is passed',
        () async* {
      final Map<String, dynamic> map = json.decode(fixure('trivia.json'));

      final result = DateTriviaModel.fromJson(map);
      expect(result, tDateTriviaModel);
    });
  });

  group('to json', () {
    test('should return map with proper data', () async* {
      final result = tDateTriviaModel.toJson();

      final expectedMap = {'text':'Test Text','year':1900};

      expect(result, expectedMap);
    });
  });
}
