import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz.dart';
import 'add_question.dart';
class QuizInfoForm extends StatefulWidget {
  @override
  State<QuizInfoForm> createState() => _QuizInfoFormState();
}

class _QuizInfoFormState extends State<QuizInfoForm> {
  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    Map<String,String> quizInfo = {};

    void saveForm() {
      final isValid = form.currentState.validate();
      if (!isValid) {
        return;
      }
      final quiz = Provider.of<QuizCreator>(context,listen: false);
      quiz.saveQuizInfo(quizInfo);
      form.currentState.save();
      print(quiz.quizInfo);
      Navigator.of(context).popAndPushNamed(AddQuestion.route);
    }

    InputDecoration singleLineInputStyle(label) => InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
            key: form,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                      decoration: singleLineInputStyle('Quiz name'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please provide a vlue';
                        }
                        return null;
                      },
                      onChanged:(val) {
                        quizInfo['name'] = val;
                      }),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: singleLineInputStyle('Quiz Description'),
                      textInputAction: TextInputAction.send,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please provide a vlue';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        quizInfo['desc'] = val;
                      }),
                )
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      saveForm();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).primaryColor)),
                    child: Text('Next')))
          ],
        )
      ],
    );
  }
}
