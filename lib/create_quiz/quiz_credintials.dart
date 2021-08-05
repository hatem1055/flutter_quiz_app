import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz.dart';
class QuizCredintials extends StatelessWidget {
  static const route = '/quiz_credintials';
  @override
  Widget build(BuildContext context) {
    final credentials = ModalRoute.of(context).settings.arguments as Map;
    final quiz = Provider.of<QuizCreator>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('${quiz.quizName}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code : ${credentials["code"]}'),
          Text('Password : ${credentials["password"]}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColor)),
                  child: Text('See quiz Stats'))
            ],
          )
        ],
      ),
    );
  }
}
