import 'dart:convert';

import 'package:date_trivia/core/error/exceptions.dart';
import 'package:date_trivia/features/date_trivia/data/data_sources/date_trivia_remote_data_source.dart';
import 'package:date_trivia/features/date_trivia/data/models/date_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixure/fixure_reader.dart';
import 'date_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  DateTriviaRemoteDataSourceImpl? dateTriviaRemoteDataSourceImpl;
  MockClient? mockClient;
  final tDateTriviaModel = DateTriviaModel.fromJson(json.decode(fixure('trivia.json')));

  setUp(() {
    mockClient = MockClient();
    dateTriviaRemoteDataSourceImpl = DateTriviaRemoteDataSourceImpl(mockClient!);
  });

  void setUpMockClientSuccess200() {
    when(mockClient?.get(any, headers: anyNamed('headers'))).thenAnswer((realInvocation) async => http.Response(fixure('trivia.json'), 200));
  }

  void setUpMockClientFailure404() {
    when(mockClient?.get(any, headers: anyNamed('headers'))).thenAnswer((realInvocation) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteDateTrivia', () {
    const tDAte = '4/2';
    test(
      'should perform GET request on a URL',
      () {
        setUpMockClientSuccess200();
        dateTriviaRemoteDataSourceImpl?.getConcreteDateTrivia(tDAte);
        verify(mockClient?.get(Uri.parse('http://numbersapi.com/$tDAte/date'), headers: {'Content-Type': 'application/json'}));
      },
    );

    test(
      'should return Date Trivia when status code is 200 (success)',
      () async {
        setUpMockClientSuccess200();
        final result = await dateTriviaRemoteDataSourceImpl?.getConcreteDateTrivia(tDAte);
        expect(result, equals(tDateTriviaModel));
      },
    );

    test('should throw a ServerException when the response code is 404 or other', () async {
      setUpMockClientFailure404();
      final call = dateTriviaRemoteDataSourceImpl!.getConcreteDateTrivia;
      expect(() => call(tDAte), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomDateTrivia', () {
    test(
         'should perform GET request on a URL with random endpoint',
      () {
        setUpMockClientSuccess200();
        dateTriviaRemoteDataSourceImpl?.getRandomDateTrivia();
        verify(mockClient?.get(Uri.parse('http://numbersapi.com/#random/date'), headers: {'Content-Type': 'application/json'}));
      },
    );

    test(
      'should return Date Trivia when status code is 200 (success)',
      () async {
        setUpMockClientSuccess200();
        final result = await dateTriviaRemoteDataSourceImpl?.getRandomDateTrivia();
        expect(result, equals(tDateTriviaModel));
      },
    );

      test(
    'should throw a ServerException when the response code is 404 or other',
    () async {
      // arrange
      setUpMockClientFailure404();
      // act
      final call = dateTriviaRemoteDataSourceImpl!.getRandomDateTrivia;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    },
  );
  });
}
