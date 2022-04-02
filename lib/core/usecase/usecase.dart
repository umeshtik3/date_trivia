import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> extends Equatable {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {}
