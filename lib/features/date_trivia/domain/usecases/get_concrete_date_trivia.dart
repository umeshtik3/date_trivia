import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/date_trivia.dart';
import '../repositories/date_trivia_repository.dart';
import 'package:equatable/equatable.dart';

class GetConcreteDateTrivia extends UseCase<DateTrivia, Params> {
  final DateTriviaRepository repository;

  GetConcreteDateTrivia(this.repository);

  @override
  Future<Either<Failure, DateTrivia>?> call(Params params) async {
    return await repository.getConcreteDateTrivia(params.date);
  }

  @override
  List<Object?> get props => [];
}

class Params extends Equatable {
  final String? date;

  const Params({required this.date}) : super();

  @override
  List<Object?> get props => [date];
}
