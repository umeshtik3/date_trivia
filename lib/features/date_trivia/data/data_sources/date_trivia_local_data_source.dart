import '../models/date_trivia_model.dart';

abstract class DateTriviaLocalDataSource {
  Future<DateTriviaModel> getLastDateTrivia();
  Future<void> cachedDateTrivia(DateTriviaModel triviaToCache);
}
