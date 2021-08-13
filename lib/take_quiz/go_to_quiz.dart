import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/go_to_widget.dart';
import '../providers/the_quiz_provider.dart';
import '../providers/credintials_data.dart';
import 'the_quiz.dart';


class GoToQuiz extends StatelessWidget {
  static const route = '/go_to_quiz';

  @override
  Widget build(BuildContext context) {
    final theQuiz = Provider.of<TheQuizProvider>(context, listen: false);
    final credintialsAndData = Provider.of<CredintialsAndData>(context, listen: false);
    theQuiz.clearQuizData();
    setData(){
        final quizData = credintialsAndData.quizData;
        credintialsAndData.setQuizTakerName();
        theQuiz.setNameAndId(quizData['name'],quizData['_id']);
        theQuiz.setQuizData(quizData);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Quizzy'),
        ),
        body: GoToWidget(
          buttonText: 'Go to the quiz',
          checkValidity: (){
            return true;
          },
          errorMessage: 'Please give us your name',
          goToRoute: TheQuiz.route,
          placeholder: 'your name',
          setData: setData,
        ));
  }
}
