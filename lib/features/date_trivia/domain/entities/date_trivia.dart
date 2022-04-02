import 'package:equatable/equatable.dart';

class DateTrivia extends Equatable {
  final String? text;
  final String? date;

  DateTrivia({required this.text, required this.date}):super([text,date]);
}
