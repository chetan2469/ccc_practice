import 'package:flutter/material.dart';
import '../dataTypes/question.dart';
import '../db/DatabaseHelper.dart';

class UpdateQuestion extends StatefulWidget {
  final int index;
  final Question question;
  final List<Question> questions;
  UpdateQuestion(this.questions, this.question, this.index);

  @override
  State<StatefulWidget> createState() {
    return _UpdateQuestion();
  }
}

class _UpdateQuestion extends State<UpdateQuestion> {
  final dbHelper = DatabaseHelper.instance;

  final questionController = TextEditingController();
  final op1Controller = TextEditingController();
  final op2Controller = TextEditingController();
  final op3Controller = TextEditingController();
  final op4Controller = TextEditingController();
  final ansController = TextEditingController();
  final languageController = TextEditingController();

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure to update ??"),
          content: Text(
              "After successfull update you will not able to redo info..."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Update"),
              onPressed: () {
                _update();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool qValidate = true,
      op1Validate = true,
      op2Validate = true,
      op3Validate = true,
      op4Validate = true,
      ansValidate = true;

  
  String _selectedLanguage;
  String ans;

  final snackBarSuccess = SnackBar(
    content: Text('Product is Updated !!'),
    duration: const Duration(seconds: 1),
  );

  final snackBarAlert = SnackBar(
    content: Text('Please Fill All Details!!'),
    duration: const Duration(seconds: 1),
  );

  @override
  void initState() {
    super.initState();
    print("Ans = ${widget.question.getAns()}");

    questionController.text = widget.question.getQuestion();
    op1Controller.text = widget.question.getOp1();
    op2Controller.text = widget.question.getOp2();
    op3Controller.text = widget.question.getOp3();
    op4Controller.text = widget.question.getOp4();
    ansController.text = widget.question.getAns();
    languageController.text = widget.question.getLanguage();
    ans = widget.question.getAns();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Update Question Details",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Update Details"),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "cancle",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                validateFields();
                if (qValidate &&
                    op1Validate &&
                    op2Validate &&
                    op3Validate &&
                    op4Validate &&
                    ansValidate) {
                  print("all ok");
                  _showDialog();
                } else {
                  print("put all values");
                }
              },
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            )
          ],
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: TextField(
                      maxLines: 4,
                      controller: questionController,
                      decoration: InputDecoration(
                          labelText: "Enter Question ",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Radio(
                          activeColor: Colors.blue,
                          value: op1Controller.text,
                          groupValue: ans,
                          onChanged: (String a) {
                            setState(() {
                              ans = a;
                              ansController.text = a;
                            });
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: op1Controller,
                            decoration: InputDecoration(
                                labelText: "Enter Option 1 ",
                                border: OutlineInputBorder()),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Radio(
                            activeColor: Colors.blue,
                            value: op2Controller.text,
                            groupValue: ans,
                            onChanged: (String a) {
                              setState(() {
                                ans = a;
                                ansController.text = a;
                              });
                            }),
                        Expanded(
                          child: TextField(
                            controller: op2Controller,
                            decoration: InputDecoration(
                                labelText: "Enter Option 2 ",
                                border: OutlineInputBorder()),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Radio(
                            activeColor: Colors.blue,
                            value: op3Controller.text,
                            groupValue: ans,
                            onChanged: (String a) {
                              setState(() {
                                ans = a;
                                ansController.text = a;
                              });
                            }),
                        Expanded(
                          child: TextField(
                            controller: op3Controller,
                            decoration: InputDecoration(
                                labelText: "Enter Option 3 ",
                                border: OutlineInputBorder()),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Radio(
                            activeColor: Colors.blue,
                            value: op4Controller.text,
                            groupValue: ans,
                            onChanged: (String a) {
                              setState(() {
                                ans = a;
                                ansController.text = a;
                              });
                            }),
                        Expanded(
                          child: TextField(
                            controller: op4Controller,
                            decoration: InputDecoration(
                                labelText: "Enter Option 4 ",
                                border: OutlineInputBorder()),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: TextField(
                controller: ansController,
                decoration: InputDecoration(
                    labelText: "answer ", border: OutlineInputBorder()),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void validateFields() {
    setState(() {
      questionController.text.isEmpty ? qValidate = false : qValidate = true;
      op1Controller.text.isEmpty ? op1Validate = false : op1Validate = true;
      op2Controller.text.isEmpty ? op2Validate = false : op2Validate = true;
      op3Controller.text.isEmpty ? op3Validate = false : op3Validate = true;
      op4Controller.text.isEmpty ? op4Validate = false : op4Validate = true;
      ans != null ? ansValidate = true : ansValidate = false;
    });
  }

  void _update() async {
    // row insert into table
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: widget.question.getId(),
      DatabaseHelper.columnQuestion: questionController.text,
      DatabaseHelper.columnLanguage: _selectedLanguage,
      DatabaseHelper.columnOp1: op1Controller.text,
      DatabaseHelper.columnOp2: op2Controller.text,
      DatabaseHelper.columnOp3: op3Controller.text,
      DatabaseHelper.columnOp4: op4Controller.text,
      DatabaseHelper.columnAns: ansController.text
    };
    final id = await dbHelper.update(row);
    print('Updated row id: $id');

    //add to products List for virtual
    setState(() {
      widget.questions[widget.index].setAns(questionController.text);
      widget.questions[widget.index].setOp1(op1Controller.text);
      widget.questions[widget.index].setOp2(op2Controller.text);
      widget.questions[widget.index].setOp3(op3Controller.text);
      widget.questions[widget.index].setOp4(op4Controller.text);
      widget.questions[widget.index].setAns(ans);
    });
  }
}
