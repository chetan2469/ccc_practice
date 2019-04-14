import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './staticData/Data.dart';
import 'dataTypes/question.dart';
import 'package:connectivity/connectivity.dart';
import 'db/DatabaseHelper.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  final Function sendToFirebase;
  final Function getDataFromFirebase;
  final Function fetchData;
  final List<Question> questions;
  HomePage(this.sendToFirebase, this.getDataFromFirebase, this.questions,
      this.fetchData);

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  bool progressbarVisiblity = true;
  bool googleButtonVisiblity = true;
  Data d = new Data();

  final Connectivity connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> subscription;

  void initState() {
    super.initState();
    registeredUser();
  }

  void checkInternetCon() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        print(
            "Connected to Mobile Network !!-------------------------------------------");
        d.setUName("chedo");
        final dbHelper = DatabaseHelper.instance;
        dbHelper.deleteAll();
        widget.fetchData();
        print("Makeing NULL DATABASE");
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (result == ConnectivityResult.wifi) {
        print(
            "Connected to wifi Network !!-------------------------------------------");
        d.setUName("chedo");
        final dbHelper = DatabaseHelper.instance;
        dbHelper.deleteAll();
        print("MAkeing NULL DATABASE");
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        print("Not Connected !!-------------------------------------------");
        connectionRequestPopup();
      }
    });
  }

  connectionRequestPopup() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString("language") == null) {
      sp.setString('language', 'English');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text('You have Internet Connection for first time setup !!'),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }
  }

  void registeredUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getString('uname') != null && widget.questions.length > 90) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      checkInternetCon();
    }
  }

  String displayMessage = 'Login with';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  FirebaseUser user;
  bool authenticate = false;

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    d.setUName(user.displayName);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    authenticate = true;

    if (user.email != null) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() {
        progressbarVisiblity = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/banner.png'),
              Container(
                width: 180,
                height: 60,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  color: Color(0xFFEF5350),
                  onPressed: () {
                    signInWithGoogle();
                  },
                  child: Text(
                    "Google",
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: 180,
                height: 60,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  color: Color(0xFF536DF0),
                  onPressed: () {
                    registeredUser();
                  },
                  child: Text(
                    "Guest",
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "Sign in for continue...",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
