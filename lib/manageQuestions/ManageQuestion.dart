import 'package:flutter/material.dart';
import 'QuestionList.dart';
import 'AddQuestion.dart';
import '../dataTypes/question.dart';

class ManageQuestions extends StatefulWidget {
  final List<Question> questions;
  ManageQuestions(this.questions);

  @override
  State<StatefulWidget> createState() {
    return _ManageQuestions();
  }
}

class _ManageQuestions extends State<ManageQuestions> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Your Own Questions"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.add),
                text: "Add Question",
              ),
              Tab(
                icon: Icon(Icons.list),
                text: "List Questions",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[AddQuestion(widget.questions), QuestionList(widget.questions)],
        ),
      ),
    );
  }
}
