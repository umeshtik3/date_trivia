import 'package:date_trivia/features/date_trivia/presentation/bloc/date_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  late String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          // keyboardType: const TextInputType.numberWithOptions(signed: true),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a Date MM/DD',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            addConcrete();
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: Text('Search'),
                onPressed: addConcrete,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade500,
                ),
                child: const Text('Get random trivia'),
                onPressed: addRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void addConcrete() {
    controller.clear();
    context.read<DateTriviaBloc>().add(GetTriviaFromConcrete(inputStr));
  }

  void addRandom() {
    controller.clear();
    context.read<DateTriviaBloc>().add(GetTriviaFromRandom());
  }
}
