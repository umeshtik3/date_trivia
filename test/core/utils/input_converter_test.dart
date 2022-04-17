import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/failures.dart';
import 'package:date_trivia/core/utils/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter? inputConverter;
  setUp(
    () {
      inputConverter = InputConverter();
    },
  );

  test(
    'should return date string when string is passed ',
    () {
      const inputString = '4/2';
      final result = inputConverter?.validateInputDateString(inputString);
      expect(result, const Right(inputString));
    },
  );

  test('should return failure when invalid month is passed', () {
    const inputString = '31/1';
    final result = inputConverter?.validateInputDateString(inputString);
      expect(result, Left(InvalidInputFailure()));
  });

 test('should return failure when invalid date is passed', () {
    const inputString = '3/45';
    final result = inputConverter?.validateInputDateString(inputString);
      expect(result, Left(InvalidInputFailure()));
  });
  
}
