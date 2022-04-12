import 'package:equatable/equatable.dart';

class DateTrivia extends Equatable {
  final String? text;

  const DateTrivia({required this.text,});

  @override
  List<Object?> get props => [text];
}
