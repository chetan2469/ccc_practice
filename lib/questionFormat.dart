import 'package:flutter/material.dart';
import './dataTypes/question.dart';

class QuestionFormat extends StatefulWidget {
  final Question question;
  final Function setAns;
  QuestionFormat(this.question,this.setAns);
  

  @override
  State<StatefulWidget> createState() {
    return _QuestionFormat();
  }
  
}

class _QuestionFormat extends State<QuestionFormat> {
  
String ans;
  @override
  void initState() {
    super.initState();
     ans=widget.question.getAns();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                child: Text(
                  widget.question.getQuestion(),
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.blue,
                    value: widget.question.getOp1(),
                    groupValue: ans,
                    onChanged: (String a) {
                      setState(() {
                        ans = a;
                        widget.question.setAns(a);
                        widget.setAns(a);
                      });
                    },
                  ),
                  Expanded(
                    child: Text(widget.question.getOp1(),style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: widget.question.getOp2(),
                    groupValue: ans,
                    onChanged: (String a) {
                      setState(() {
                        ans = a;
                        widget.question.setAns(a);
                        widget.setAns(a);
                      });
                    },
                  ),
                  Expanded(
                    child: Text(widget.question.getOp2(),style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: widget.question.getOp3(),
                    groupValue: ans,
                    onChanged: (String a) {
                      setState(() {
                        ans = a;
                        widget.question.setAns(a);
                        widget.setAns(a);
                      });
                    },
                  ),
                  Expanded(
                    child: Text(widget.question.getOp3(),style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: widget.question.getOp4(),
                    groupValue: ans,
                    onChanged: (String a) {
                      setState(() {
                        ans = a;
                        widget.question.setAns(a);
                        widget.setAns(a);
                      });
                    },
                  ),
                  Expanded(
                    child: Text(widget.question.getOp4(),style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}
