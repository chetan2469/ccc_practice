import 'package:flutter/material.dart';
import '../dataTypes/question.dart';
import 'UpdateQuestion.dart';

import '../db/DatabaseHelper.dart';

class QuestionList extends StatefulWidget {
  final List<Question> questions;
  QuestionList(this.questions);

  @override
  State<StatefulWidget> createState() {
    return _QuestionList();
  }
}

class _QuestionList extends State<QuestionList> {

final dbHelper = DatabaseHelper.instance;

  Widget _buildProductItem(BuildContext context, int index) {
    String str = widget.questions[index].getQuestion();

    if (str.length > 25) {
      str = widget.questions[index].getQuestion().substring(0, 25) + "...";
    }

    return GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.velocity.pixelsPerSecond.dx > -1000.0) {
            print("Drag Right");
          }
        },
        onDoubleTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdateQuestion(
                    widget.questions, widget.questions[index], index)),
          );
        },
        onLongPress: (){
          print("Long pressed");
          dbHelper.delete(index);
          widget.questions.remove(index);
          
        },
        child: Card(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(str, style: TextStyle(fontSize: 20)),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: widget.questions.length,
        itemBuilder: _buildProductItem,
      ),
    );
  }
}
