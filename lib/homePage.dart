import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './staticData/Data.dart';
import 'dataTypes/question.dart';
import 'db/DatabaseHelper.dart';

import 'package:connectivity/connectivity.dart';
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

  void registeredUser() async {
    Data d = new Data();
    if (d.getUName() == null) {
      d.setUName('guest');
      d.setLanguage('English');
    }
  }

  void checkInternetConForFillData() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        final dbHelper = DatabaseHelper.instance;
        print(
            "Connected !! Fetching Data-------------------------------------------");
        dbHelper.deleteAll();
        widget.fetchData();
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        print("Not Connected !!-------------------------------------------");
      }
    });
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
        backgroundColor: Colors.black,
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
                    Navigator.pushReplacementNamed(context, '/dashboard');
                    print('dash==-----------------');
                  },
                  child: Text(
                    "Dashboard",
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
