import 'package:flutter/material.dart';
import 'homePage.dart';
import 'dashboard.dart';
import 'noteDrawer.dart';
import 'exam.dart';
import './manageQuestions/ManageQuestion.dart';
import 'dataTypes/question.dart';
import './db/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import './dataTypes/question.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  List<Question> questions = new List();

  @override
  State<StatefulWidget> createState() {
    return _Myapp();
  }
}

class _Myapp extends State<MyApp> {
  final dbHelper = DatabaseHelper.instance;
  String language;
  SharedPreferences sp;
  final Connectivity connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    createSharedPref();
    fillQuestions();
  }

  String getLanguage() {
    return sp.getString('language');
  }

  void clearQuestionList() {
    widget.questions.clear();
  }

  var isLoading = false;

  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    final dbHelper = DatabaseHelper.instance;
    dbHelper.deleteAll();

    String link =
        "https://raw.githubusercontent.com/chetan2469/ccc_practice/master/data.json";

    final response = await http.get(link);
    if (response.statusCode == 200) {
      widget.questions = (json.decode(response.body) as List)
          .map((data) => new Question.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
        insertListToDatabase();
      });
    } else {
      throw Exception('Failed to load ');
    }
  }

  void insertListToDatabase() async {
    print("Feeling Database");
    for (int i = 0; i < widget.questions.length; i++) {
      Map<String, dynamic> row = {
        DatabaseHelper.columnQuestion: widget.questions[i].question,
        DatabaseHelper.columnLanguage: widget.questions[i].language,
        DatabaseHelper.columnOp1: widget.questions[i].op1,
        DatabaseHelper.columnOp2: widget.questions[i].op2,
        DatabaseHelper.columnOp3: widget.questions[i].op3,
        DatabaseHelper.columnOp4: widget.questions[i].op4,
        DatabaseHelper.columnAns: widget.questions[i].ans
      };
      final id = await dbHelper.insert(row);
    }
    fillQuestions();
  }

  void createSharedPref() async {
    sp = await SharedPreferences.getInstance();
    language = sp.getString("language");
  }

  //firebase info
  final databaseReference = FirebaseDatabase.instance.reference();
  final recentJobsRef = FirebaseDatabase.instance.reference();

  void sendToFirebase(String userName) async {
    for (int i = 0; i < widget.questions.length; i++) {
      databaseReference
          .child(userName)
          .child('questions')
          .child(widget.questions[i].getId().toString())
          .set({
        'question': widget.questions[i].getQuestion(),
        'op1': widget.questions[i].getOp1(),
        'op2': widget.questions[i].getOp2(),
        'op3': widget.questions[i].getOp3(),
        'op4': widget.questions[i].getOp4(),
        'ans': widget.questions[i].getAns(),
        'language': widget.questions[i].getLanguage(),
      });
    }
  }

  void getDataFromFirebase() async {
    databaseReference.child('chedo').child('questions').child('1');
  }

  void _insert(String question, String language, String op1, String op2,
      String op3, String op4, String ans) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnQuestion: question,
      DatabaseHelper.columnLanguage: language,
      DatabaseHelper.columnOp1: op1,
      DatabaseHelper.columnOp2: op2,
      DatabaseHelper.columnOp3: op3,
      DatabaseHelper.columnOp4: op4,
      DatabaseHelper.columnAns: ans
    };
    final id = await dbHelper.insert(row);

    Question q = new Question(
        id: id,
        question: question,
        op1: op1,
        op2: op2,
        op3: op3,
        op4: op4,
        ans: ans,
        language: language);
    widget.questions.add(q);
  }

  void fillQuestions() async {
    String ans;
    final allRows = await dbHelper.queryAllRows();
    widget.questions.clear();
    allRows.forEach((row) {
      if (row['ans'] == 'op1') {
        ans = row['op1'];
      } else if (row['ans'] == 'op2') {
        ans = row['op2'];
      } else if (row['ans'] == 'op3') {
        ans = row['op3'];
      } else if (row['ans'] == 'op4') {
        ans = row['op4'];
      } else {
        ans = row['ans'];
      }

      Question q = new Question(
          id: row['_id'] as int,
          question: row['question'],
          op1: row['op1'],
          op2: row['op2'],
          op3: row['op3'],
          op4: row['op4'],
          ans: ans,
          language: row['language']);

      widget.questions.add(q);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chedo On Fire",
      theme: ThemeData(
        primaryColor: Colors.lightBlue[900]
      ),
      routes: {
        "/dashboard": (BuildContext context) => Dashboard(widget.questions,
            sendToFirebase, getDataFromFirebase, fetchData, clearQuestionList),
        "/notes": (BuildContext context) => NoteDrawer(),
        "/exam": (BuildContext context) =>
            Exam(widget.questions, getLanguage()),
        "/manage": (BuildContext context) => ManageQuestions(widget.questions),
      },
      home: HomePage(
          sendToFirebase, getDataFromFirebase, widget.questions, fetchData),
    );
  }
}
