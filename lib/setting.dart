import 'package:flutter/material.dart';
import 'staticData/Data.dart';
import './db/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  final Function sendToFirebase;
  final Function fetchData;
  final Function clearQuestionList;

  Setting(this.sendToFirebase, this.fetchData, this.clearQuestionList);

  @override
  State<StatefulWidget> createState() {
    return _Setting();
  }
}

class _Setting extends State<Setting> {
  Data d = new Data();
  SharedPreferences sp;
  bool processing = false;

  static const menuItems = <String>[
    'English',
    'Hindi',
    'Marathi',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPref();
  }

  String language;
  void sharedPref() async {
    sp = await SharedPreferences.getInstance();
    language = sp.getString('language');
    print(language + "________________________________________________");
  }

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
      )
      .toList();

  void setLanguage(String lang) {
    setState(() {
      sp.setString('language', lang);
    });
    print("==================${lang}=========================");
  }

  Widget _languagePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: GestureDetector(
                  onTap: () {
                    print("==================English=========================");
                    Navigator.pop(context);
                    setState(() {
                      setLanguage("English");
                    });
                  },
                  child: Text("English"),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: GestureDetector(
                  onTap: () {
                    print("==================Marathi=========================");
                    Navigator.pop(context);
                    setState(() {
                      setLanguage("Marathi");
                    });
                  },
                  child: Text("Marathi"),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: GestureDetector(
                  onTap: () {
                    print("==================Hindi=========================");
                    Navigator.pop(context);
                    setState(() {
                      setLanguage("Hindi");
                    });
                  },
                  child: Text("Hindi"),
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            processing ? LinearProgressIndicator() : SizedBox(),
            ListTile(
              title: Text('Default Language'),
              trailing: DropdownButton(
                value: language,
                hint: Text('Choose'),
                onChanged: ((String newValue) {
                  setState(() {
                    language = newValue;
                    setLanguage(newValue);
                  });
                }),
                items: _dropDownMenuItems,
              ),
            ),
            ListTile(
              title: Text('Restore Questions'),
              trailing: Container(
                margin: EdgeInsets.only(right: 50),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      processing = true;
                    });
                    final dbHelper = DatabaseHelper.instance;
                    dbHelper.deleteAll();
                    await widget.fetchData();
                    setState(() {
                      processing = false;
                    });
                  },
                  child: Icon(Icons.restore),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
