import 'package:equatable/equatable.dart';

class DateTrivia extends Equatable {
  final String? text;
  final int? year;

  const DateTrivia({required this.text, required this.year});

  @override
  List<Object?> get props => [text,year];
}
