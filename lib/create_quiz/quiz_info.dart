import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz.dart';
import 'quiz_info_form.dart';

class QuizInfo extends StatelessWidget {
  static const route = '/quiz_info';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Quiz Info'),
            backgroundColor: Theme.of(context).primaryColor),
        body:QuizInfoForm());
  }
}
