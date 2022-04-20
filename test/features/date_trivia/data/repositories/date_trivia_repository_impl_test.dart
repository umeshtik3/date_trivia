import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/exceptions.dart';
import 'package:date_trivia/core/error/failures.dart';
import 'package:date_trivia/core/network/network_info.dart';
import 'package:date_trivia/features/date_trivia/data/data_sources/date_trivia_local_data_source.dart';
import 'package:date_trivia/features/date_trivia/data/data_sources/date_trivia_remote_data_source.dart';
import 'package:date_trivia/features/date_trivia/data/models/date_trivia_model.dart';
import 'package:date_trivia/features/date_trivia/data/repositories/date_trivia_repository_impl.dart';
import 'package:date_trivia/features/date_trivia/domain/entities/date_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'date_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo])
@GenerateMocks([], customMocks: [
  MockSpec<DateTriviaRemoteDataSource>(
      as: #MockDateTriviaRemoteDataSourceForTest,
      returnNullOnMissingStub: true),
])
@GenerateMocks([
  DateTriviaLocalDataSource
], customMocks: [
  MockSpec<DateTriviaLocalDataSource>(
      as: #MockDateTriviaLocalDataSourceForTest, returnNullOnMissingStub: true),
])
void main() {
  MockDateTriviaRemoteDataSourceForTest mockDateTriviaRemoteDataSource =
      MockDateTriviaRemoteDataSourceForTest();
  MockDateTriviaLocalDataSource? mockDateTriviaLocalDataSource;
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  DateTriviaRepositoryImpl? dateTriviaRepositoryImpl;

  setUp(() {
    // mockDateTriviaRemoteDataSource = MockDateTriviaRemoteDataSource();
    mockDateTriviaLocalDataSource = MockDateTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    dateTriviaRepositoryImpl = DateTriviaRepositoryImpl(
        remoteDataSource: mockDateTriviaRemoteDataSource,
        localDataSource: mockDateTriviaLocalDataSource!,
        networkInfo: mockNetworkInfo);
  });

  void runOnlineTests(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runOfflineTests(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteDateTrivia', () {
    const tDate = '4/1';
    const tDateTriviaModel = DateTriviaModel(text: 'Test text');
    const DateTrivia tDateTrivia = tDateTriviaModel;

    runOnlineTests(() {
      test('should check if the device is online or not', () async* {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        await dateTriviaRepositoryImpl?.getConcreteDateTrivia(tDate);

        verify(mockNetworkInfo.isConnected);
      });

      group('device is online ', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        test(
            'should retrun remote data when to call remote data source is successful',
            () async {
          when(mockDateTriviaRemoteDataSource.getConcreteDateTrivia(any))
              .thenAnswer((_) async => tDateTriviaModel);

          final result =
              await dateTriviaRepositoryImpl?.getConcreteDateTrivia(tDate);

          verify(mockDateTriviaRemoteDataSource.getConcreteDateTrivia(tDate));
          expect(result, equals(const Right(tDateTrivia)));
        });

        test(
            'should cache data locally when to call remote data source is successful',
            () async {
          when(mockDateTriviaRemoteDataSource.getConcreteDateTrivia(any))
              .thenAnswer((_) async => tDateTriviaModel);

          await dateTriviaRepositoryImpl?.getConcreteDateTrivia(tDate);

          verify(mockDateTriviaRemoteDataSource.getConcreteDateTrivia(tDate));
          verify(mockDateTriviaLocalDataSource
              ?.cachedDateTrivia(tDateTriviaModel));
        });

        test(
            'should retrun server failure when to call remote data source is unsuccessful',
            () async {
          when(mockDateTriviaRemoteDataSource.getConcreteDateTrivia(any))
              .thenThrow(ServerException());

          final result =
              await dateTriviaRepositoryImpl?.getConcreteDateTrivia(tDate);

          verify(mockDateTriviaRemoteDataSource.getConcreteDateTrivia(tDate));
          verifyZeroInteractions(mockDateTriviaLocalDataSource);
          expect(result, equals(Left(ServerFailures())));
        });
      });
    });

    runOfflineTests(() {
 
        test(
          'should return last locally cached data when the cached data is present',
          () async {
            // arrange
            when(mockDateTriviaLocalDataSource?.getLastDateTrivia())
                .thenAnswer((_) async => tDateTriviaModel);
            // act
            final result =
                await dateTriviaRepositoryImpl?.getConcreteDateTrivia(tDate);
            // assert
            // verifyZeroInteractions(mockDateTriviaRemoteDataSource);
            verify(mockDateTriviaLocalDataSource?.getLastDateTrivia());
            expect(result, equals(const Right(tDateTrivia)));
          },
        );
      
    });
  });

  group('getRandomDateTrivia', () {
    const tDateTriviaModel = DateTriviaModel(text: 'Test text');
    const DateTrivia tDateTrivia = tDateTriviaModel;

      test('should check if the device is online', ()async* {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
       await dateTriviaRepositoryImpl!.getRandomDateTrivia();
        // assert
        verify(mockNetworkInfo.isConnected);
      });

    runOnlineTests(() {
       test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockDateTriviaRemoteDataSource.getRandomDateTrivia())
            .thenAnswer((_) async => tDateTriviaModel);
        // act
        final result = await dateTriviaRepositoryImpl?.getRandomDateTrivia();
        // assert
        verify(mockDateTriviaRemoteDataSource.getRandomDateTrivia());
        expect(result, equals(const Right(tDateTrivia)));
      },
    );

     test(
      'should cache the data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockDateTriviaRemoteDataSource.getRandomDateTrivia())
            .thenAnswer((_) async => tDateTriviaModel);
        // act
        await dateTriviaRepositoryImpl?.getRandomDateTrivia();
        // assert
        verify(mockDateTriviaRemoteDataSource.getRandomDateTrivia());
        verify(mockDateTriviaLocalDataSource?.cachedDateTrivia(tDateTriviaModel));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockDateTriviaRemoteDataSource.getRandomDateTrivia())
            .thenThrow(ServerException());
        // act
        final result = await dateTriviaRepositoryImpl?.getRandomDateTrivia();
        // assert
        verify(mockDateTriviaRemoteDataSource.getRandomDateTrivia());
        verifyZeroInteractions(mockDateTriviaLocalDataSource);
        expect(result, equals(Left(ServerFailures())));
      },
    );
    });
  });
}
