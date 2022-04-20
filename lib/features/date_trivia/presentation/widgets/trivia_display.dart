import '../../domain/entities/date_trivia.dart';
import 'package:flutter/material.dart';

class TriviaDisplay extends StatelessWidget {
  final DateTrivia dateTrivia;
  const TriviaDisplay({Key? key, required this.dateTrivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(dateTrivia.text.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  dateTrivia.text!,
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
