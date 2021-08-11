import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/the_quiz_provider.dart';
import '../widgets/my_card.dart';
import 'options.dart';
import './result.dart';

class TheQuiz extends StatelessWidget {
  static const route = '/the_quiz';

  @override
  Widget build(BuildContext context) {
    final theQuiz = Provider.of<TheQuizProvider>(context);
    bool questionValidation() {
      if (theQuiz.currentQuestion.validateQuestion() != false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(theQuiz.currentQuestion.validateQuestion()),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ));
        return false;
      }
      return true;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('${theQuiz.name} #${theQuiz.questionIndex + 1}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              myCard(
                  child: Text(theQuiz.currentQuestion.question),
                  context: context,
                  margin: 10,
                  padding: 17),
              ChangeNotifierProvider.value(
                  value: theQuiz.currentQuestion, child: Options()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!(theQuiz.isLastQuestion))
                    Container(
                        height: 40,
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              if (questionValidation()) {
                                theQuiz.saveAnswere();
                                theQuiz.nextQuestion();
                                Navigator.popAndPushNamed(context, route);
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Theme.of(context).primaryColor)),
                            child: Text('Next Question'))),
                  if (theQuiz.isLastQuestion)
                    Container(
                        height: 40,
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              if (questionValidation()) {
                                theQuiz.saveAnswere();
                                Map result = theQuiz.submitQuiz();
                                Navigator.popAndPushNamed(
                                    context, ResultPage.route,
                                    arguments: result);
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.blue)),
                            child: Text('Submit quiz'))),
                ],
              )
            ],
          ),
        ));
  }
}
