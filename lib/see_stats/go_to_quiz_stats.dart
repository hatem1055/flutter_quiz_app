import 'package:flutter/material.dart';
import 'stats_screen.dart';
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
    TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Quizzy'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: password,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'password',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  height: 40,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
                        if (isThereIsQuiz() != false) {
                          Navigator.popAndPushNamed(context, QuizStatsScreen.route,arguments: isThereIsQuiz());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'sorry there is no quiz with these password'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                          ));
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context).primaryColor)),
                      child: Text('See Stats'))),
            ],
          )
        ],
      ),
    );
  }
}
