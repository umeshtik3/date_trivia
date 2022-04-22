import 'package:date_trivia/features/date_trivia/presentation/pages/number_trivia_page.dart';
import 'package:date_trivia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/date_trivia/presentation/bloc/date_trivia_bloc.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primaryColor: Colors.green.shade800, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green.shade600),
      ),
      home: BlocProvider(
        create: (context) => sl<DateTriviaBloc>()..add(GetTriviaFromTodaysDate()),
        child: const DateTriviaPage(),
      ),
    );
  }
}