import '../models/date_trivia_model.dart';

abstract class DateTriviaRemoteDataSource {
   /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DateTriviaModel>? getConcreteDateTrivia(String? date);

   /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes. 
  Future<DateTriviaModel>? getRandomDateTrivia();
}
