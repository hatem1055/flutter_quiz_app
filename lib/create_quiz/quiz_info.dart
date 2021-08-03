import 'package:flutter/material.dart';

class QuizInfo extends StatefulWidget {
  static const route = '/quiz_info';

  @override
  State<QuizInfo> createState() => _QuizInfoState();
}

class _QuizInfoState extends State<QuizInfo> {
  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    Map quizInfo = {};

    void saveForm() {
      final isValid = form.currentState.validate();
      if (!isValid) {
        return;
      }
      form.currentState.save();
      print(quizInfo);
    }

    InputDecoration singleLineInputStyle(label) => InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color:Colors.grey
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        );
    return Scaffold(
        appBar: AppBar(
            title: Text('Quiz Info'),
            backgroundColor: Theme.of(context).primaryColor),
        body: Column(
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
                          onSaved: (val) {
                            quizInfo['quiz_name'] = val;
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
                          onSaved: (val) {
                            quizInfo['quiz_desc'] = val;
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
        ));
  }
}
