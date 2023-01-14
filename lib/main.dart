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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Coaches()),
          ChangeNotifierProvider.value(value: GoogleSignInProvider())
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: CoachLogin()));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Score!",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Arinoe",
                  fontWeight: FontWeight.bold,
                  fontSize: 35)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage("assets/images/soccer.gif"))),
              ),
            ),
            Padding(padding: EdgeInsets.all(20)),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => ParentLogin()))),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              child: Text(
                "Are you a parent?",
                style: TextStyle(
                    color: Colors.white, fontSize: 25, fontFamily: "Arinoe"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "OR",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => CoachData()))),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              child: Text(
                "Are you a coach? ",
                style: TextStyle(
                    color: Colors.white, fontSize: 25, fontFamily: "Arinoe"),
              ),
            )
          ],
        ));
  }
}
