import 'package:flutter/material.dart';
import 'staticData/Data.dart';
import './db/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  final Function sendToFirebase;
  final Function fetchData;
  final Function clearQuestionList;
  Setting(this.sendToFirebase, this.fetchData,this.clearQuestionList);

  @override
  State<StatefulWidget> createState() {
    return _Setting();
  }
}

class _Setting extends State<Setting> {
  Data d = new Data();
  Widget _languagePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: GestureDetector(
                  onTap: () {
                    print("English");
                    Navigator.pop(context);
                    setState(() {
                      d.setLanguage("English");
                    });
                     widget.fetchData();
                  },
                  child: Text("English"),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: GestureDetector(
                  onTap: () {
                    print("Hindi");
                    Navigator.pop(context);
                    setState(() {
                   //   d.setLanguage("Hindi");
                    });
                     widget.fetchData();
                  },
                  child: Text("Hindi"),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: GestureDetector(
                  onTap: () {
                    print("Marathi");
                    Navigator.pop(context);
                    setState(() {
                    //  d.setLanguage("Marathi");
                    });
                     widget.fetchData();
                  },
                  child: Text("Marathi"),
                ),
              )
            ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              children: <Widget>[
                Text(
                  "Default Language",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 95,
                ),
                _languagePopup()
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              widget.sendToFirebase(sp.getString('uname'));

              showInSnackBar("thanks for Community...");
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    "Backup to Server",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 115,
                  ),
                  Icon(Icons.backup)
                ],
              ),
            ),
          ),
           GestureDetector(
            onTap: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              widget.fetchData();
              showInSnackBar("data is fetching from server...");
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    "Restore Questions",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 105,
                  ),
                  Icon(Icons.update)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
             final dbHelper = DatabaseHelper.instance;
            dbHelper.deleteAll();
            widget.clearQuestionList();
              showInSnackBar("data is fetching from server...");
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    "Clear Questions",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 124,
                  ),
                  Icon(Icons.restore)
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              children: <Widget>[
                Text(
                  "Share your Data",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 122,
                ),
                Icon(Icons.share)
              ],
            ),
          )
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }
}
