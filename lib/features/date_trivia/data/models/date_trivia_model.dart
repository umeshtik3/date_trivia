import '../../domain/entities/date_trivia.dart';

class DateTriviaModel extends DateTrivia {
  const DateTriviaModel({
    required String? text,
  }) : super(text: text);

  factory DateTriviaModel.fromJson(Map<String, dynamic> map) {
    return DateTriviaModel(text: map['text']);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
