import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/failures.dart';
import 'package:date_trivia/core/usecase/usecase.dart';
import 'package:date_trivia/features/date_trivia/domain/entities/date_trivia.dart';
import 'package:date_trivia/features/date_trivia/domain/repositories/date_trivia_repository.dart';

class GetRandomDateTrivia extends UseCase<DateTrivia, NoParams> {
  final DateTriviaRepository repository;

  GetRandomDateTrivia(this.repository);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Either<Failure, DateTrivia>> call(NoParams noParams) async {
    return await repository.getRandomDateTrivia();
  }

  @override
  List<Object?> get props => [];
}
