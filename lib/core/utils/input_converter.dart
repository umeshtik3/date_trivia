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
        isValidate = true;
        break;
      } else {
        isValidate = false;
      }
    }

    if (isValidate) {
      for (int j = 0; j <= 31; j++) {
        if (int.parse(splittedDate[1]) == j) {
          resultDate = resultDate + "/" + splittedDate[1];
          isValidate = true;
          break;
        } else {
          isValidate = false;
        }
      }
    }
   

    return isValidate ? Right(resultDate) : Left(InvalidInputFailure());
  }

  Either<Failure, String> getTodaysDate() {
    String inputDate = _prepareInputDate();

    return Right(inputDate);
  }

  String _prepareInputDate() {
    var todaysDateTime = DateTime.now();
    var todaysDay = todaysDateTime.day.toString();
    var todaysMonth = todaysDateTime.month.toString();
    String inputDate = todaysMonth + "/" + todaysDay;
    return inputDate;
  }
}

class InputFailure extends Failure {}
