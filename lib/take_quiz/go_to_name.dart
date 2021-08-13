import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/go_to_widget.dart';
import '../providers/the_quiz_provider.dart';
import '../providers/credintials_data.dart';
import 'go_to_quiz.dart';

class GoToName extends StatelessWidget {
  static const route = '/go_to_name';

  @override
  Widget build(BuildContext context) {
    final theQuiz = Provider.of<TheQuizProvider>(context, listen: false);
    final credintialsAndData = Provider.of<CredintialsAndData>(context);

    theQuiz.clearQuizData();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Quizzy'),
        ),
        body: GoToWidget(
            buttonText: 'Next',
            checkValidity: credintialsAndData.getQuizData,
            errorMessage: 'sorry there is no quiz with these code',
            goToRoute: GoToQuiz.route,
            placeholder: 'quiz code',
            setData: () {}));
  }
}
