import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInMethod extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleSignInMethod();
  }
}

class _GoogleSignInMethod extends State<GoogleSignInMethod> {
  bool progressbarVisiblity = true;
  bool googleButtonVisiblity = true;

  void initState() {
    super.initState();
    print("Init Method CAll");
    signInWithGoogle();
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

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    authenticate = true;

    if (user.email != null) {
      pushTWidget();
    } else {
      setState(() {
        progressbarVisiblity = false;
      });
    }
  }

  void pushTWidget() {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
