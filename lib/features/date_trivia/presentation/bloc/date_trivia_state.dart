part of 'date_trivia_bloc.dart';

abstract class DateTriviaState extends Equatable {
  const DateTriviaState();
  
  @override
  List<Object> get props => [];
}

class DateTriviaInitial extends DateTriviaState {}

class Empty extends DateTriviaState {}

class Loading extends DateTriviaState {}

class Loaded extends DateTriviaState {
  final DateTrivia trivia;

  const Loaded({required this.trivia});
}

class Error extends DateTriviaState {
  final String message;

  const Error({required this.message});
  
  @override
  List<Object> get props => [message];

}