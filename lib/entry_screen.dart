import 'package:flutter/material.dart';
import 'create_quiz/quiz_info.dart';
import './see_stats/go_to_quiz_stats.dart';
class EntryScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget modeButton(String text, IconData icon,String rout) {
      const cornerRadius = Radius.circular(10.0);
      return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(rout);
        },
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Colors.purple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(
                topLeft: cornerRadius,
                topRight: cornerRadius,
                bottomLeft: cornerRadius,
                bottomRight: cornerRadius,
              )),
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon, color: Colors.white),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Quizzy'),
          backgroundColor: Theme.of(context).primaryColor),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          modeButton('Take a quiz', Icons.quiz,''),
          modeButton('Create a quiz', Icons.school,QuizInfo.route),
          modeButton('see quiz stats', Icons.stacked_bar_chart,GoToQuizStats.route)
        ],
      ),
    );
  }
}
