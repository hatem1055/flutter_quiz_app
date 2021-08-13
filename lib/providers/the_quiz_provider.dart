import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../vars.dart';
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
  String id;
  String desc;
  List<Question> questions = [];
  List<String> choosenOptionsIds = [];
  int questionIndex = 0;
  void setNameAndId(name,id) {
    this.name = name;
    this.id = id;
    notifyListeners();
  }

  void setQuizData(Map data) {
    for (var question in data['questions']) {
      final questionWillBeAdded = Question(question['question']);
      for (var option in question['options']) {
        questionWillBeAdded.addOption(option['option'], option['_id']);
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

  Future<Map> submitQuiz(String quizTakerName)async{
    String reqBody = json.encode({
      'quiz_id': this.id,
      'name': quizTakerName,
      'options_ids':this.choosenOptionsIds
    });
    final http.Response res = await http.post('${Vars.url}/create_result',body: reqBody,headers: Vars.headers);
    Map output = json.decode(res.body);
    output['quiz_name'] = this.name;
    return output;
  }
}
