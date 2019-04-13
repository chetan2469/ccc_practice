import 'package:flutter/material.dart';
import 'bottomNavBar.dart';
import 'dataTypes/question.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about.dart';
import './setting.dart';

class Dashboard extends StatefulWidget {
  List<Question> questions;
  final Function sendToFirebase;
  final Function getDataFromFirebase;
  final Function fetchData;
  Dashboard(this.questions, this.sendToFirebase, this.getDataFromFirebase,
      this.fetchData);

  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  @override
  initState() {
    super.initState();
    checkLanuageIsSet();
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

  checkLanuageIsSet() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString("language") == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Select Your Default Language"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("English"),
                onPressed: () {
                  sp.setString('language', "English");
                  Navigator.pop(context);
                  widget.fetchData();
                },
              ),
              FlatButton(
                child: Text("Hindi"),
                onPressed: () {
                  //  sp.setString('language', "Hindi");
                  Navigator.pop(context);
                  widget.fetchData();
                },
              ),
              FlatButton(
                child: Text("Marathi"),
                onPressed: () {
                  sp.setString('language', "Marathi");
                  Navigator.pop(context);
                  widget.fetchData();
                },
              )
            ],
          );
        },
      );
    }
  }

  final databaseReference = FirebaseDatabase.instance.reference();

  Widget _simplePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => About()));
                  },
                  child: Text("About"),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: GestureDetector(
                  onTap: () {
                    print("setting");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Setting(
                                widget.sendToFirebase, widget.fetchData)));
                  },
                  child: Text("Setting"),
                ),
              ),
            ],
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text("CCC Exam Practice"),
            actions: <Widget>[
              _simplePopup(),
            ],
          ),
          body: BottomNavBar(widget.questions)),
    );
  }
}
