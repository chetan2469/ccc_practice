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
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('back to dashboard...'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    child: Text('ok'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add Questions For Community"),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  child: Icon(Icons.backspace),
                ),
              )
            ],
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
            children: <Widget>[
              AddQuestion(widget.questions),
              QuestionList(widget.questions)
            ],
          ),
        ),
      ),
    );
  }
}
