import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'entry_screen.dart';
import 'create_quiz/quiz_info.dart';
import 'create_quiz/providers/quiz.dart';
import 'create_quiz/add_question.dart';
import 'create_quiz/quiz_credintials.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizCreator()),
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Color.fromRGBO(103, 58, 183, 1)),
        title: 'Quizzy',
        initialRoute: '/',
        routes: {
          '/': (ctx) => EntryScreen(),
          QuizInfo.route: (ctx) => QuizInfo(),
          AddQuestion.route: (ctx) => AddQuestion(),
          QuizCredintials.route : (ctx) => QuizCredintials()
        },
      ),
    );
  }
}
