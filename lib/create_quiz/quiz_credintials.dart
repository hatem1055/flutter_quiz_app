import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_creator.dart';
import 'package:flutter/services.dart';

class QuizCredintials extends StatelessWidget {
  static const route = '/quiz_credintials';
  @override
  Widget build(BuildContext context) {
    final credentials = ModalRoute.of(context).settings.arguments as Map;
    final quiz = Provider.of<QuizCreator>(context, listen: false);

    Widget myText(String text,String textToCopy) {
      return ListTile(
        title: Text(text),
        trailing: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: textToCopy));
            },
            icon: Icon(Icons.copy)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('${quiz.quizName}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myText('Code : ${credentials["code"]}',credentials["code"]),
          myText('Password : ${credentials["password"]}',credentials["password"]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/');
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColor)),
                  child: Text('Go to the home page'))
            ],
          )
        ],
      ),
    );
  }
}
