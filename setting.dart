import 'package:flutter/material.dart';
import 'staticData/Data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  final Function sendToFirebase;
  final Function fetchData;
  Setting(this.sendToFirebase, this.fetchData);

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
                      d.setLanguage("Marathi");
                    });
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
                    Navigator.pop(context);
                    setState(() {
                      d.setLanguage("Marathi");
                    });
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
                  width: 100,
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
                    "Update Questions",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 115,
                  ),
                  Icon(Icons.update)
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
                  "Restore questions",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 105,
                ),
                Icon(Icons.restore)
              ],
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
