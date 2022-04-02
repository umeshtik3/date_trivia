import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/failures.dart';
import 'package:date_trivia/core/usecase/usecase.dart';
import 'package:date_trivia/features/date_trivia/domain/entities/date_trivia.dart';
import 'package:date_trivia/features/date_trivia/domain/repositories/date_trivia_repository.dart';
import 'package:equatable/equatable.dart';

class GetConcreteDateTrivia extends UseCase<DateTrivia, Params> {
  final DateTriviaRepository repository;

  GetConcreteDateTrivia(this.repository);

  @override
  Future<Either<Failure, DateTrivia>> call(Params params) async {
    return await repository.getConcreteDateTrivia(params.date);
  }
}

class Params extends Equatable {
  final String date;

  Params({required this.date}) : super([date]);
}
