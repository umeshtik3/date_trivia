import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/failures.dart';
import 'package:date_trivia/features/date_trivia/domain/entities/date_trivia.dart';

abstract class DateTriviaRepository {
  Future<Either<Failure, DateTrivia>> getConcreteDateTrivia(String? date);
  Future<Either<Failure, DateTrivia>> getRandomDateTrivia();
}
