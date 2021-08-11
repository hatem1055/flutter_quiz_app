import 'package:flutter/material.dart';

class Option {
  String option;
  String id;
  Option(this.option, this.id);
}

class Question extends ChangeNotifier {
  String question;
  List<Option> options = [];
  String choosenOptionId;
  Question(this.question);
  void addOption(option, id) {
    options.add(Option(option, id));
  }

  void changeChoosenOption(id) {
    this.choosenOptionId = id;
    notifyListeners();
  }

  validateQuestion() {
    Option choosenOption = this
        .options
        .firstWhere((element) => element.id == choosenOptionId, orElse: () => null);
    if (choosenOption == null) {
      return 'please choose ansewre';
    }
    return false;
  }
}

class TheQuizProvider extends ChangeNotifier {
  String name;
  String desc;
  List<Question> questions = [];
  List<String> choosenOptionsIds = [];
  int questionIndex = 0;
  void setName(name) {
    this.name = name;
    notifyListeners();
  }

  void setQuizData(Map data) {
    for (var question in data['questions']) {
      final questionWillBeAdded = Question(question['question']);
      for (var option in question['options']) {
        questionWillBeAdded.addOption(option['option'], option['id']);
      }
      this.questions.add(questionWillBeAdded);
    }
    print(this.questions);
  }

  void clearQuizData(){
    this.questions = [];
    this.name = '';
    this.choosenOptionsIds = [];
    this.questionIndex = 0;
  }
  void saveAnswere(){
    this.choosenOptionsIds.add(this.currentQuestion.choosenOptionId);
  }
  void nextQuestion(){
    this.questionIndex += 1;
    notifyListeners();
  }
  Question get currentQuestion{
    return this.questions[this.questionIndex];
  }

  bool get isLastQuestion{
    return this.questionIndex == this.questions.length - 1;
  }

  Map submitQuiz(){
    print(choosenOptionsIds);
    return {
      'total_questons':3,
      'right_questions':2,
      'percentege':(3/2) * 100,
      'quiz_name':this.name
    };
  }
}
