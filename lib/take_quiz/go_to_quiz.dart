import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/go_to_widget.dart';
import '../providers/the_quiz_provider.dart';
import 'the_quiz.dart';

final dummyData = {
  'quizName': 'dummy quiz',
  'questions': [
    {
      'question': 'question 1',
      'options': [
        {'option': 'option 1', 'id': DateTime.now().toString()},
        {'option': 'option 2', 'id': DateTime.now().toString()},
        {'option': 'option 3', 'id': DateTime.now().toString()},
        {'option': 'option 4', 'id': DateTime.now().toString()}
      ]
    },
    {
      'question': 'question 2',
      'options': [
        {'option': 'option 1', 'id': DateTime.now().toString()},
        {'option': 'option 2', 'id': DateTime.now().toString()},
        {'option': 'option 3', 'id': DateTime.now().toString()},
        {'option': 'option 4', 'id': DateTime.now().toString()}
      ]
    },
    {
      'question': 'question 3',
      'options': [
        {'option': 'option 1', 'id': DateTime.now().toString()},
        {'option': 'option 2', 'id': DateTime.now().toString()},
        {'option': 'option 3', 'id': DateTime.now().toString()},
        {'option': 'option 4', 'id': DateTime.now().toString()}
      ]
    }
  ]
};

class GoToQuiz extends StatelessWidget {
  static const route = '/go_to_quiz';

  @override
  Widget build(BuildContext context) {
    final theQuiz = Provider.of<TheQuizProvider>(context, listen: false);
    theQuiz.clearQuizData();
    setData(){
        theQuiz.setName(dummyData['quizName']);
        theQuiz.setQuizData(dummyData);
    }
    isThereIsQuiz() {
      print('isThere');
      if (true) {
        return 'testID';
      }
      // ignore: dead_code
      return false;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Quizzy'),
        ),
        body: GoToWidget(
          buttonText: 'Go to the quiz',
          checkValidity: isThereIsQuiz,
          errorMessage: 'sorry there is no quiz with these code',
          goToRoute: TheQuiz.route,
          placeholder: 'quiz code',
          setData: setData,
        ));
  }
}
