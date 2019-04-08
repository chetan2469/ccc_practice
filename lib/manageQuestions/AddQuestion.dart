import 'package:flutter/material.dart';
import '../dataTypes/question.dart';
import '../db/DatabaseHelper.dart';

class AddQuestion extends StatefulWidget {
  final List<Question> questions;
  AddQuestion(this.questions);

  @override
  State<StatefulWidget> createState() {
    return _AddQuestion();
  }
}

class _AddQuestion extends State<AddQuestion> {
  final dbHelper = DatabaseHelper.instance;

  final questionController = TextEditingController();
  final op1Controller = TextEditingController();
  final op2Controller = TextEditingController();
  final op3Controller = TextEditingController();
  final op4Controller = TextEditingController();
  final ansController = TextEditingController();
  final languageController = TextEditingController();

  bool qValidate = false,
      op1Validate = false,
      op2Validate = false,
      op3Validate = false,
      op4Validate = false,
      languageValidate = false,
      ansValidate = false;

  List<String> _languages = ['English', 'Marathi', 'Hindi'];
  String _selectedLanguage;
  String ans;

  final snackBarSuccess = SnackBar(
    content: Text('Product is added !!'),
    duration: const Duration(seconds: 1),
  );

  final snackBarAlert = SnackBar(
    content: Text('Please Fill All Details!!'),
    duration: const Duration(seconds: 1),
  );

  @override
  void initState() {
    super.initState();
    _clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
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
                            });
                          }),
                      Expanded(
                        child: TextField(
                          controller: op3Controller,
                          decoration: InputDecoration(
                              labelText: "Enter Option 4 ",
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
                DropdownButton(
                  hint: Text('Choose Language'),
                  value: _selectedLanguage,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLanguage = newValue;
                    });
                  },
                  items: _languages.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
                          },
                          color: Colors.blueAccent,
                          child: Text(
                            "back",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              questionController.text.isEmpty
                                  ? qValidate = false
                                  : qValidate = true;
                              op1Controller.text.isEmpty
                                  ? op1Validate = false
                                  : op1Validate = true;
                              op2Controller.text.isEmpty
                                  ? op2Validate = false
                                  : op2Validate = true;
                              op3Controller.text.isEmpty
                                  ? op3Validate = false
                                  : op3Validate = true;
                              op4Controller.text.isEmpty
                                  ? op4Validate = false
                                  : op4Validate = true;
                              ans != null
                                  ? ansValidate = true
                                  : ansValidate = false;
                              _selectedLanguage != null
                                  ? languageValidate = true
                                  : languageValidate = false;
                            });

                            if (qValidate &&
                                op1Validate &&
                                op2Validate &&
                                op3Validate &&
                                op4Validate &&
                                languageValidate &&
                                ansValidate) {
                              print("all ok");

                              _insert();
                            } else {
                              print("put all values");
                              Scaffold.of(context).showSnackBar(snackBarAlert);
                            }
                          },
                          color: Colors.blueAccent,
                          child: Text(
                            "submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  void _insert() async {
    // row insert into table
    Map<String, dynamic> row = {
      DatabaseHelper.columnQuestion: questionController.text,
      DatabaseHelper.columnLanguage: _selectedLanguage,
      DatabaseHelper.columnOp1: op1Controller.text,
      DatabaseHelper.columnOp2: op2Controller.text,
      DatabaseHelper.columnOp3: op3Controller.text,
      DatabaseHelper.columnOp4: op4Controller.text,
      DatabaseHelper.columnAns: ans
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');

    //add to products List for virtual
    Question q = new Question(
        id:id as int,
        question:questionController.text,
        op1:op1Controller.text,
        op2:op2Controller.text,
        op3:op3Controller.text,
        op4:op4Controller.text,
        ans:ans,
        language:_selectedLanguage);
    widget.questions.add(q);
    Scaffold.of(context).showSnackBar(snackBarSuccess);

    _clear();
  }

  void _clear() {
    qValidate = false;
    op1Validate = false;
    op2Validate = false;
    op3Validate = false;
    op4Validate = false;
    languageValidate = false;
    ansValidate = false;
    questionController.text = '';
    op1Controller.text = '';
    op2Controller.text = '';
    op3Controller.text = '';
    op4Controller.text = '';
    _selectedLanguage = null;
    ans = null;
  }

  void setDefaluts() {
    questionController.text =
        'Lorem ipsum dolor sit amet, consectetur adipiscing ';
    _selectedLanguage = 'English';
    op1Controller.text = 'dolor sit amet  ';
    op2Controller.text = 'amet, consectetur adipiscing ';
    op3Controller.text = 'consectetur';
    op4Controller.text = 'consectetur';
    ans = 'op2';
  }
}
