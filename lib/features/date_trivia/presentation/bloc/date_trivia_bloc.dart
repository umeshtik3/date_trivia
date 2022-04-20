import 'package:bloc/bloc.dart';
import 'package:date_trivia/core/error/failures.dart';
import 'package:date_trivia/core/utils/input_converter.dart';
import 'package:date_trivia/features/date_trivia/domain/usecases/get_concrete_date_trivia.dart';
import 'package:date_trivia/features/date_trivia/domain/usecases/get_random_date_trivia.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/date_trivia.dart';

part 'date_trivia_event.dart';
part 'date_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Input is not valid';

class DateTriviaBloc extends Bloc<DateTriviaEvent, DateTriviaState> {
  final GetConcreteDateTrivia? getConcreteDateTrivia;
  final GetRandomDateTrivia? getRandomDateTrivia;
  final InputConverter? inputConverter;

  DateTriviaState get initialState => Empty();

  DateTriviaBloc({this.getConcreteDateTrivia, this.getRandomDateTrivia, this.inputConverter}) : super(Empty()) {
    on<GetTriviaFromConcrete>((event, emit) async {
      final inputEither =  inputConverter?.validateInputDateString(event.dateString!);
      await inputEither?.fold((failure) {
        emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
      }, (integer) async {
        emit(Loading());
        final failureOrTrivia = await getConcreteDateTrivia!(Params(date: integer));
        failureOrTrivia!.fold((failure) {
          emit(Error(message: _mapFailureToMessage(failure)));
        }, (trivia) {
          emit(Loaded(trivia: trivia));
        });
      });
    });
    on<GetTriviaFromRandom>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomDateTrivia!(NoParams());
      failureOrTrivia!.fold((failure) {
        emit(Error(message: _mapFailureToMessage(failure)));
      }, (trivia) {
        emit(Loaded(trivia: trivia));
      });
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailures:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailures:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
