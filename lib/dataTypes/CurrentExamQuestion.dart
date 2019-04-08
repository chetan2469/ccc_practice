import 'package:flutter/material.dart';

class CurrentExamQuestion {
  CurrentExamQuestion(
      {this.icon,
      this.qId,
      this.qNo,
      this.question,
      this.op1,
      this.op2,
      this.op3,
      this.op4,
      this.ans,
      this.uAns});
  final int qId;
  final IconData icon;
  final String qNo;
  String question, op1, op2, op3, op4, ans, uAns;
}