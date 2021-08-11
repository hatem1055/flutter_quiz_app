import 'package:flutter/material.dart';
import 'stats_screen.dart';
import '../widgets/go_to_widget.dart';
class GoToQuizStats extends StatelessWidget {
  static const route = '/go_to_quiz_stats';
  isThereIsQuiz() {
    if(true){
      return 'testID';
    }
    // ignore: dead_code
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Quizzy'),
      ),
      body: GoToWidget(
          buttonText: 'See Stats',
          checkValidity: isThereIsQuiz,
          errorMessage: 'sorry there is no quiz with these password',
          goToRoute:QuizStatsScreen.route,
          placeholder: 'password',
          setData: (){},
        )
      );
    
  }
}
