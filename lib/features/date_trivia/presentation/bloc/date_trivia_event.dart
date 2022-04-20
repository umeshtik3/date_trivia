part of 'date_trivia_bloc.dart';

abstract class DateTriviaEvent extends Equatable {
  const DateTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaFromConcrete extends DateTriviaEvent {
  final String? dateString;

  const GetTriviaFromConcrete(this.dateString):super();

  @override
  List<Object> get props => [];
}

class GetTriviaFromRandom extends DateTriviaEvent {}
