import 'package:flutter/material.dart';
import 'entry_screen.dart';
import 'create_quiz/quiz_info.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color.fromRGBO(103, 58, 183, 1)
        ),
        title: 'Quizzy',
        initialRoute: '/',
        routes: {'/': (ctx) => EntryScreen(),
        QuizInfo.route : (ctx) => QuizInfo()
        },
    );
  }
}