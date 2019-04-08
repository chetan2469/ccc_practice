import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './staticData/Data.dart';

class HomePage extends StatefulWidget {
  final Function sendToFirebase;
  final Function getDataFromFirebase;
  HomePage(this.sendToFirebase, this.getDataFromFirebase);

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  bool progressbarVisiblity = true;
  bool googleButtonVisiblity = true;
  Data d = new Data();

  void initState() {
    super.initState();
  
    registeredUser();
  }

  void registeredUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getString('uname') != null) {
      Navigator.pushReplacementNamed(context, '/dashboard');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://samyakinfotech.com/wp-content/uploads/2017/03/CCC-Training-Course-Banner.png'),
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
                  d.setUName("chedo");
                  Navigator.pushReplacementNamed(context, '/dashboard');
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
    );
  }
}
