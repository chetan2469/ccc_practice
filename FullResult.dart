import 'package:flutter/material.dart';
import './dataTypes/CurrentExamQuestion.dart';

class FullResult extends StatefulWidget {
  final List<CurrentExamQuestion> _selectedRandomQuestions;

  FullResult(this._selectedRandomQuestions);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FullResult();
  }
}

class _FullResult extends State<FullResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
            child: Icon(Icons.home),
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget._selectedRandomQuestions.length,
          itemBuilder: _buildResultQuestions,
        ),
      ),
    );
  }

  Widget _buildResultQuestions(BuildContext context, int index) {
    String quest = widget._selectedRandomQuestions[index].question;
    String uans = widget._selectedRandomQuestions[index].uAns;
    String ans = widget._selectedRandomQuestions[index].ans;

    if (quest.length > 25) {
      quest = quest.substring(0, 25) + "...";
    }

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("${index + 1}", style: TextStyle(fontSize: 20)),
              SizedBox(
                width: 20,
              ),
              Text(
                " ${quest}",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Icon(Icons.done),
              Text(
                uans,
                style:
                    TextStyle(color: ans == uans ? Colors.green : Colors.red),
              ),
              SizedBox(width: 10,),
              Text(
                "(${ans})",
                style: TextStyle(color: Colors.green),
              ),
            ],
          )
        ],
      ),
    );
  }
}
