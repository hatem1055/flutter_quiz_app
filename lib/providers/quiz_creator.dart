import 'package:flutter/material.dart';

class Option {
  String option;
  bool isRight;
  String id;
  Option(this.option, this.isRight, this.id);
}

class Question with ChangeNotifier {
  String question;
  List<Option> options = [];
  String rightOptionId;

  void addOption(Option option) {
    this.options.add(option);
    notifyListeners();
  }

  void changeRightAnswere(id) {
    this.rightOptionId = id;
    notifyListeners();
  }

  void setOptionValue(id, value) {
    Option option = options.firstWhere((element) => element.id == id);
    option.option = value;
  }

  void deleteOption(id) {
    this.options.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void setQuestionValue(val) {
    this.question = val;
  }

  get optionsLength {
    return this.options.length;
  }

  validateQuestion() {
    if (this.optionsLength < 2) {
      return 'please add at least two options';
    }
    Option rightOption = this
        .options
        .firstWhere((element) => element.id == rightOptionId, orElse: () => null);
    if (rightOption == null) {
      return 'please specify the right answere';
    }
    rightOption.isRight = true;
    return false;
  }
}

class QuizCreator with ChangeNotifier {
  String quizName;
  String quizDesc;
  List<Question> questions = [];

  void saveQuizInfo(Map<String, String> quizInfo) {
    print('from provider funtion \n $quizInfo');
    this.quizDesc = quizInfo['desc'];
    this.quizName = quizInfo['name'];
    print({'name': this.quizName, 'quizDesc': this.quizDesc});
  }

  Map get quizInfo {
    return {'name': this.quizName, 'desc': this.quizDesc};
  }

  int get questionCount {
    return this.questions.length;
  }

  void saveQuestion(Question question){
    this.questions.add(question);
  }

  Map submitQuiz(){
    print(questions.map((e) => e.question));
    return {
      'code':'fsjagf218y1',
      'password':'asfjbsafasfsa',
    };
  }

  void clearQuizData(){
    this.questions = [];
  }
}
