import 'dart:convert';

import 'package:date_trivia/core/error/exceptions.dart';
import 'package:date_trivia/features/date_trivia/data/data_sources/date_trivia_local_data_source.dart';
import 'package:date_trivia/features/date_trivia/data/models/date_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixure/fixure_reader.dart';
import 'date_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([
  SharedPreferences
])
void main() {
  DateTriviaLocalDataSourceImpl? dateTriviaLocalDataSource;
  MockSharedPreferences? mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dateTriviaLocalDataSource = DateTriviaLocalDataSourceImpl(mockSharedPreferences!);
  });

  group(
    'getLastDateTrivia',
    () {
      final tDateTriviaModel = DateTriviaModel.fromJson(json.decode(fixure('trivia_cached.json')));
      test(
        'should return DateTrivia from SharedPreferences when there is one cache',
        () async {
          when(mockSharedPreferences?.getString(any)).thenReturn(fixure('trivia_cached.json'));

          final result = await dateTriviaLocalDataSource?.getLastDateTrivia();

          verify(mockSharedPreferences?.getString('CACHED_NUMBER_TRIVIA'));
          expect(result, equals(tDateTriviaModel));
        },
      );
      test('should throw a CacheException when there is not a cached value', () async{
        // arrange
        when(mockSharedPreferences!.getString(any)).thenReturn(null);
        // act
        // Not calling the method here, just storing it inside a call variable
        final call = dateTriviaLocalDataSource?.getLastDateTrivia;
        // assert
        // Calling the method happens from a higher-order function passed.
        // This is needed to test if calling a method throws an exception.
        expect(() => call!(), throwsA(const TypeMatcher<CacheException>()));
      });
    },
  );

  group('cacheDateTrivia', () {
    const tDateTriviaModel = DateTriviaModel(text: 'test trivia');

    test('should call SharedPreferences to cache the data', () {
      when(mockSharedPreferences?.setString(any, any))
          .thenAnswer((_) async => true);
      dateTriviaLocalDataSource?.cachedDateTrivia(tDateTriviaModel);
      final expectedJsonString = json.encode(tDateTriviaModel.toJson());
      verify(mockSharedPreferences?.setString(
        CACHED_NUMBER_TRIVIA,
        expectedJsonString,
      ));
    });
  });
}
