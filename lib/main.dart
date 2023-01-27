import 'package:athleap/backend/coachdash.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:athleap/backend/coachdata.dart';
import 'package:athleap/backend/register.dart';
import 'package:athleap/frontend/parent.dart';
import 'package:athleap/backend/coach.dart';
import 'package:athleap/info/coachinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athleap/provider/googlesignin.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Coaches()),
          ChangeNotifierProvider.value(value: GoogleSignInProvider())
        ],
        child: MaterialApp(
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(primary: Color.fromRGBO(83, 61, 229, 1))),
            home: islogin ? coachDashboard() : HomeScreen()));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(241, 252, 250, 1),
          title: Align(
            alignment: Alignment.center,
            child: Text("Athleap",
                style: TextStyle(
                    color: Color.fromRGBO(83, 61, 229, 1),
                    fontFamily: "Cera",
                    fontWeight: FontWeight.bold,
                    fontSize: 35)),
          ),
        ),
        body: Center(
            child: Container(
          height: 200,
          width: double.infinity,
          child: Column(children: [
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => ParentLogin())));
                },
                child: Text(
                  "Are you a parent?",
                  style: TextStyle(fontFamily: "Cera", fontSize: 30),
                )),
            Text(
              "OR",
              style: TextStyle(fontFamily: "Cera", fontSize: 20),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => CoachLogin())));
                },
                child: Text(
                  "Are you a coach?",
                  style: TextStyle(fontFamily: "Cera", fontSize: 30),
                ))
          ]),
        )));
  }
}
