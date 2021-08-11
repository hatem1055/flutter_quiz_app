import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_creator.dart';
import 'options_tile.dart';
import 'quiz_credintials.dart';

class AddQuestion extends StatefulWidget {
  static const route = '/add_question';

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final form = GlobalKey<FormState>();

  String questionString = '';

  final question = Question();

  @override
  void initState() {
    question.addOption(Option('option #1', false, DateTime.now().toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizCreator>(context, listen: false);
    bool questionValidation() {
      if (question.validateQuestion() != false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(question.validateQuestion()),
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
    void saveQuestion(){
      question.setQuestionValue(questionString);
      quiz.saveQuestion(question);
    }
    void saveForm() {
      final isValid = form.currentState.validate();
      if (questionValidation()) {
        if (!isValid) {
          return;
        }
        form.currentState.save();
        saveQuestion();
        Navigator.of(context).popAndPushNamed(AddQuestion.route);
      }
    }

    InputDecoration singleLineInputStyle(label) => InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        );
    return Scaffold(
        appBar: AppBar(
            title: Text(
                '${quiz.quizInfo['name']} #${quiz.questionCount + 1}'),
            backgroundColor: Theme.of(context).primaryColor),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
                key: form,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: SizedBox(
                        child: TextFormField(
                            decoration: singleLineInputStyle('Question'),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please provide a vlue';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              questionString = val;
                            }),
                      ),
                    ),
                  ],
                )),
            ChangeNotifierProvider.value(
                value: question, child: OptionsTileList()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    height: 40,
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          saveForm();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor)),
                        child: Text('Add another Question'))),
                if (quiz.questionCount >= 1)
                  Container(
                      height: 40,
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            if(questionValidation()){
                              saveQuestion();
                              Map credintials = quiz.submitQuiz();
                              Navigator.popAndPushNamed(context, QuizCredintials.route,arguments: credintials);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue)),
                          child: Text('Submit quiz'))),
              ],
            )
          ],
        ));
  }
}
