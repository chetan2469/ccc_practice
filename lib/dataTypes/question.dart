import 'dart:core';

class Question {
  final int id;
  String question, language;
  String op1, op2, op3, op4, ans;

  Question(
      {this.id,
      this.question,
      this.op1,
      this.op2,
      this.op3,
      this.op4,
      this.ans,
      this.language});

  int getId() {
    return id;
  }

  void setQuestion(String question) {
    this.question = question;
  }

  void setOp1(String op1) {
    this.op1 = op1;
  }

  void setOp2(String op2) {
    this.op2 = op2;
  }

  void setOp3(String op3) {
    this.op3 = op3;
  }

  void setOp4(String op4) {
    this.op4 = op4;
  }

  void setAns(String ans) {
    this.ans = ans;
  }

  void setLanguage(String ans) {
    this.language = language;
  }

  String getQuestion() {
    return question;
  }

  String getLanguage() {
    return language;
  }

  String getOp1() {
    return op1;
  }

  String getOp2() {
    return op2;
  }

  String getOp3() {
    return op3;
  }

  String getOp4() {
    return op4;
  }

  String getAns() {
    return ans;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return new Question(
        id: json['id'],
        question: json['question'],
        op1: json['op1'],
        op2: json['op2'],
        op3: json['op3'],
        op4: json['op4'],
        ans: json['ans'],
        language: json['language']);
  }
}

