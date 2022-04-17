import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class ServerFailures extends Failure {}

class CacheFailures extends Failure {}

class InvalidInputFailure extends Failure{}
