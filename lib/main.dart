import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'entry_screen.dart';
import 'create_quiz/quiz_info.dart';
import 'providers/quiz_creator.dart';
import 'providers/the_quiz_provider.dart';
import 'create_quiz/add_question.dart';
import 'create_quiz/quiz_credintials.dart';
import './see_stats/go_to_quiz_stats.dart';
import './see_stats/stats_screen.dart';
import 'take_quiz/go_to_name.dart';
import './take_quiz/the_quiz.dart';
import './take_quiz/result.dart';
import './take_quiz/go_to_quiz.dart';
import './providers/credintials_data.dart';
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
        ChangeNotifierProvider(create: (_) => TheQuizProvider()),
        ChangeNotifierProvider(create: (_) => CredintialsAndData())
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Color.fromRGBO(103, 58, 183, 1)),
        title: 'Quizzy',
        initialRoute: '/',
        routes: {
          '/': (ctx) => EntryScreen(),
          QuizInfo.route: (ctx) => QuizInfo(),
          AddQuestion.route: (ctx) => AddQuestion(),
          QuizCredintials.route : (ctx) => QuizCredintials(),
          GoToQuizStats.route : (ctx) => GoToQuizStats(),
          QuizStatsScreen.route : (ctx) => QuizStatsScreen(),
          GoToName.route : (ctx) => GoToName(),
          GoToQuiz.route : (ctx) => GoToQuiz(),
          TheQuiz.route : (ctx) => TheQuiz(),
          ResultPage.route : (ctx) => ResultPage(),
        },
      ),
    );
  }
}
