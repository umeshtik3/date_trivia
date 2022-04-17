import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/failures.dart';

class InputConverter {
  InputConverter();

  Either<Failure, String>? validateInputDateString(String inputDate) {
    String resultDate = '';
    var splittedDate = inputDate.split('/');
    bool isValidate = true;

    for (int i = 0; i <= 12; i++) {
      if (int.parse(splittedDate[0]) == i) {
        resultDate = '' + splittedDate[0];
      } else {
        isValidate = false;
      }
    }

    for (int j = 0; j <= 31; j++) {
      if (int.parse(splittedDate[1]) == j) {
        resultDate = resultDate + "/" + splittedDate[1];
      } else {
        isValidate = false;
      }
    }

    return isValidate ? Right(resultDate) : Left(InvalidInputFailure());
  }
}

class InputFailure extends Failure {}
