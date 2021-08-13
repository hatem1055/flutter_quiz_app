import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../vars.dart';
class CredintialsAndData with ChangeNotifier{
  String goToTextField;
  Map quizData;
  String quizTakerName;

  void setGoToTextField(newGoToTextField){
    this.goToTextField = newGoToTextField;
  }
  void setQuizTakerName(){
    this.quizTakerName = this.goToTextField;
  }
  getQuizStat() async {
    final reqBody = jsonEncode({
      'quiz_password':this.goToTextField
    });
    final http.Response res = await http.post("${Vars.url}/get_quiz_stats",headers: Vars.headers,body: reqBody);
    final result = jsonDecode(res.body)['result'];
    if(result != false){
      this.quizData = {
        'quiz_name':result['quiz_name']
      };
      return result['results'];
    }
    return result;
  }
  getQuizData() async {
    final reqBody = jsonEncode({
      'quiz_code':this.goToTextField
    });
    final http.Response res = await http.post("${Vars.url}/get_quiz",headers: Vars.headers,body: reqBody);
    final result = jsonDecode(res.body)['result'];
    if(result != false){
      this.quizData = result;
    }
    return result;
  }
}