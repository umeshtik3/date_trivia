// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/failures.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> extends Equatable {
  Future<Either<Failure, Type>?> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
