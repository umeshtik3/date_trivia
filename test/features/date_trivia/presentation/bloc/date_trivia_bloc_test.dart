import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/failures.dart';
import 'package:date_trivia/core/utils/input_converter.dart';
import 'package:date_trivia/features/date_trivia/domain/usecases/get_concrete_date_trivia.dart';
import 'package:date_trivia/features/date_trivia/domain/usecases/get_random_date_trivia.dart';
import 'package:date_trivia/features/date_trivia/presentation/bloc/date_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'date_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteDateTrivia])
@GenerateMocks([GetRandomDateTrivia])
@GenerateMocks([InputConverter])

void main() {
  DateTriviaBloc? bloc;
  MockGetConcreteDateTrivia? mockGetConcreteDateTrivia;
  MockGetRandomDateTrivia? mockGetRandomDateTrivia;
  MockInputConverter? mockInputConverter;

  setUp(
    () {
      mockGetConcreteDateTrivia = MockGetConcreteDateTrivia();
      mockGetRandomDateTrivia = MockGetRandomDateTrivia();
      mockInputConverter = MockInputConverter();
      bloc = DateTriviaBloc(
          getConcreteDateTrivia: mockGetConcreteDateTrivia, getRandomDateTrivia: mockGetRandomDateTrivia, inputConverter: mockInputConverter);
    },
  );

  test(
    'initialState should be empty',
    () {
      expect(bloc?.initialState, equals(Empty()));
    },
  );

  group(
    'GetConcreteNumberTrivia Event',
    () {
      const tDate = '4/1';

      test(
        'should call input converter and validate a date in string',
        () async {
          when(mockInputConverter?.validateInputDateString(any)).thenReturn(const Right(tDate));
          bloc?.add(const GetTriviaFromConcrete(tDate));
          await untilCalled(mockInputConverter?.validateInputDateString(any));
          verify(mockInputConverter?.validateInputDateString(tDate));
        },
      );

      test('should emit [Error] when the input is invalid', () async* {
        when(mockInputConverter?.validateInputDateString(any)).thenReturn(Left(InvalidInputFailure()));
        final expected = [Empty(), const Error(message: INVALID_INPUT_FAILURE_MESSAGE)];

        expect(bloc?.state, emitsInOrder(expected));
        bloc?.add(const GetTriviaFromConcrete(tDate));
      });
    },
  );
}
