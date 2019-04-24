import 'package:flutter/material.dart';
import 'dataTypes/question.dart';
import 'FullResult.dart';
import 'dart:math';
import './staticData/Data.dart';
import './dataTypes/CurrentExamQuestion.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

enum TabsDemoStyle { iconsAndText, iconsOnly, textOnly }

class Exam extends StatefulWidget {
  final List<Question> questions;
  final String language;
  Exam(this.questions, this.language);

  @override
  State<StatefulWidget> createState() {
    return _Exam();
  }
}

List<CurrentExamQuestion> _selectedRandomQuestions = <CurrentExamQuestion>[];

class _Exam extends State<Exam> with SingleTickerProviderStateMixin {
  TabController _controller;
  TabsDemoStyle _demoStyle = TabsDemoStyle.iconsAndText;
  String ans;

  void _showResult(int score) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Result"),
          content: Text(
              "Your Score is ${score} out of ${_selectedRandomQuestions.length}"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            FlatButton(
              child: Text("full Result"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FullResult(_selectedRandomQuestions)));
              },
            ),
          ],
        );
      },
    );
  }

  void _showAlert() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Please fill all answers !!"),
          content: Text(
              "You can submit paper after filling all answers "),
          actions: <Widget>[
            
            FlatButton(
              child: Text("ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeDemoStyle(TabsDemoStyle style) {
    setState(() {
      _demoStyle = style;
    });
  }

  exitExam() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Are you sure ? for Exit from exam !!'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("yes"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            FlatButton(
              child: Text("no"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  Decoration getIndicator() {
    return ShapeDecoration(
      shape: const StadiumBorder(
            side: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) +
          const StadiumBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).accentColor;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fill all Answers'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.backspace),
              onPressed: () {
                setState(() {
                  exitExam();
                });
              },
            ),
            RaisedButton(
              onPressed: () {
                print("On Submit");
                int score = 0;
                bool flag = true;

                for (int i = 0; i < _selectedRandomQuestions.length; i++) {
                  if (_selectedRandomQuestions[i].uAns == null) {
                    flag = false;
                  }
                }

                if (flag == true) {
                  for (int i = 0; i < _selectedRandomQuestions.length; i++) {
                    if (_selectedRandomQuestions[i].ans ==
                        _selectedRandomQuestions[i].uAns) {
                      score++;
                    }
                    print(
                        "${_selectedRandomQuestions[i].ans} -------------${_selectedRandomQuestions[i].uAns}");
                  }
                  _showResult(score);
                } else {_showAlert();}
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
              disabledColor: iconColor,
              color: Colors.lightBlue[900],
            )
          ],
          bottom: TabBar(
            controller: _controller,
            isScrollable: true,
            indicator: getIndicator(),
            tabs: _selectedRandomQuestions.map<Tab>((CurrentExamQuestion page) {
              assert(_demoStyle != null);
              return Tab(text: page.qNo);
            }).toList(),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children:
              _selectedRandomQuestions.map<Widget>((CurrentExamQuestion page) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Container(
                key: ObjectKey(page.icon),
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  child: ListView(
                    children: <Widget>[
                      Center(
                          child: Column(
                        children: <Widget>[
                          Icon(
                            page.icon,
                            color: iconColor,
                            size: 128.0,
                            semanticLabel: 'Placeholder for ${page.qNo} tab',
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Text(
                              page.question,
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                activeColor: Colors.blue,
                                value: page.op1,
                                groupValue: ans,
                                onChanged: (String a) {
                                  setState(() {
                                    ans = a;
                                    page.uAns = a;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(page.op1,
                                    style: TextStyle(fontSize: 20)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                activeColor: Colors.blue,
                                value: page.op2,
                                groupValue: ans,
                                onChanged: (String a) {
                                  setState(() {
                                    ans = a;
                                    page.uAns = a;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(page.op2,
                                    style: TextStyle(fontSize: 20)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                activeColor: Colors.blue,
                                value: page.op3,
                                groupValue: ans,
                                onChanged: (String a) {
                                  setState(() {
                                    ans = a;
                                    page.uAns = a;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(page.op3,
                                    style: TextStyle(fontSize: 20)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                activeColor: Colors.blue,
                                value: page.op4,
                                groupValue: ans,
                                onChanged: (String a) {
                                  setState(() {
                                    ans = a;
                                    page.uAns = a;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(page.op4,
                                    style: TextStyle(fontSize: 20)),
                              )
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void start() async{
    var rng = new Random();
    var q = new List();
    int x;
    
    
    print("LANGUAGE = ${widget.language}");
    print("Question Length ${widget.questions.length}");
    _selectedRandomQuestions.clear();
    var counter = 0;
    for (var i = 1; i <= 5; i++) {
      x = rng.nextInt(widget.questions.length - 1);
      if (!q.contains(x) &&
          x != null &&
          widget.questions[x].getLanguage() == widget.language ) {
        q.add(x);

        _selectedRandomQuestions.add(CurrentExamQuestion(
            qId: widget.questions[x].getId(),
            icon: Icons.question_answer,
            qNo: (++counter).toString(),
            question: widget.questions[x].getQuestion(),
            op1: widget.questions[x].getOp1(),
            op2: widget.questions[x].getOp2(),
            op3: widget.questions[x].getOp3(),
            op4: widget.questions[x].getOp4(),
            ans: widget.questions[x].getAns(),
            uAns: null));
      } else {
        --i;
        continue;
      }
    }

    _controller =
        TabController(vsync: this, length: _selectedRandomQuestions.length);
  }

  List<CurrentExamQuestion> getQuestions() {
    return _selectedRandomQuestions;
  }
}
