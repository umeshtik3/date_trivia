import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/date_trivia.dart';
import '../repositories/date_trivia_repository.dart';

class GetRandomDateTrivia extends UseCase<DateTrivia, NoParams> {
  final DateTriviaRepository repository;

  GetRandomDateTrivia(this.repository);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Either<Failure, DateTrivia>?> call(NoParams noParams) async {
    return await repository.getRandomDateTrivia();
  }

  @override
  List<Object?> get props => [];
}
