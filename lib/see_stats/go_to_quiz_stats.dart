import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stats_screen.dart';
import '../widgets/go_to_widget.dart';
import '../providers/credintials_data.dart';
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
    final credintialsAndData = Provider.of<CredintialsAndData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Quizzy'),
      ),
      body: GoToWidget(
          buttonText: 'See Stats',
          checkValidity: credintialsAndData.getQuizStat,
          errorMessage: 'sorry there is no quiz with these password',
          goToRoute:QuizStatsScreen.route,
          placeholder: 'password',
          setData: (){},
        )
      );
    
  }
}
