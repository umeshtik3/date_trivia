import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/date_trivia.dart';

abstract class DateTriviaRepository {
  Future<Either<Failure, DateTrivia>>? getConcreteDateTrivia(String? date);
  Future<Either<Failure, DateTrivia>>? getRandomDateTrivia();
}
