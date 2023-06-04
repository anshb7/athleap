import 'package:athleap/backend/coachdash.dart';
import 'package:athleap/frontend/landingpage.dart';
import 'package:athleap/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var auth = FirebaseAuth.instance;

  var islogin = false;

  void checklogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          islogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checklogin();
    navigatetohome();
  }

  void navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (islogin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => coachDashboard()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => landingpage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 202, 46, 1),
      body: Center(
        child: Text(
          "Athleap",
          style: TextStyle(
              fontFamily: "Cera",
              fontSize: 80,
              color: Color.fromRGBO(83, 61, 229, 1),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
