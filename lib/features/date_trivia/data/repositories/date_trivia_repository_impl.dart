import 'package:date_trivia/core/error/exceptions.dart';

import '../../../../core/platform/network_info.dart';
import '../../domain/entities/date_trivia.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/date_trivia_repository.dart';
import '../data_sources/date_trivia_local_data_source.dart';
import '../data_sources/date_trivia_remote_data_source.dart';

class DateTriviaRepositoryImpl implements DateTriviaRepository {
  final DateTriviaRemoteDataSource remoteDataSource;
  final DateTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DateTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, DateTrivia>>? getConcreteDateTrivia(
      String? date) async {
    bool? isConnected = await networkInfo.isConnected;
    if (isConnected!) {
      try {
        final dateTrivia = await remoteDataSource.getConcreteDateTrivia(date);
        localDataSource.cachedDateTrivia(dateTrivia!);
        return Right(dateTrivia);
      } on ServerException {
        return Left(ServerFailures());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastDateTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailures());
      }
    }
  }

  @override
  Future<Either<Failure, DateTrivia>>? getRandomDateTrivia() async {
    bool? isConnected = await networkInfo.isConnected;
    if (isConnected!) {
      try {
        final remoteTrivia = await remoteDataSource.getRandomDateTrivia();
        localDataSource.cachedDateTrivia(remoteTrivia!);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailures());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastDateTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailures());
      }
    }
  }
}
