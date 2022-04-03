import 'package:date_trivia/features/date_trivia/domain/entities/date_trivia.dart';

class DateTriviaModel extends DateTrivia {
  const DateTriviaModel({required String? text, required int? year})
      : super(text: text, year: year);

  factory DateTriviaModel.fromJson(Map<String, dynamic> map) {
    return DateTriviaModel(text: map['text'], year: map['year']);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'year': year};
  }
}
