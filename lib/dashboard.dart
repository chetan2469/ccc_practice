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
  Dashboard(this.questions, this.sendToFirebase, this.getDataFromFirebase);

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
                },
              ),
              FlatButton(
                child: Text("Hindi"),
                onPressed: () {
                  //  sp.setString('language', "Hindi");
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Marathi"),
                onPressed: () {
                  sp.setString('language', "Marathi");
                  Navigator.pop(context);
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
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>About()));
                  },
                  child: Text("about"),
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
                            builder: (BuildContext context) =>
                                Setting(widget.sendToFirebase)));
                  },
                  child: Text("Setting"),
                ),
              ),
            ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CCC Exam Practice"),
          actions: <Widget>[
            _simplePopup(),
          ],
        ),
        body: BottomNavBar(widget.questions));
  }
}
