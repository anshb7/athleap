import 'package:athleap/backend/coachdash.dart';
import 'package:athleap/backend/profilepage.dart';
import 'package:athleap/frontend/landingpage.dart';
import 'package:athleap/frontend/splash.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
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
import 'package:responsive_framework/responsive_framework.dart';

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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Coaches()),
          ChangeNotifierProvider.value(value: GoogleSignInProvider())
        ],
        child: MaterialApp(
          builder: (context, child) => ResponsiveWrapper.builder(child,
              maxWidth: 1000,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: Color(0xFFF5F5F5))),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) =>
                Splash(), //islogin ? coachDashboard() : landingpage(),
            'loginscreen': (context) => HomeScreen(),
            '/coachlogin': (context) => CoachLogin(),
            '/parentlogin': (context) => ParentLogin(),
          },
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: Color.fromRGBO(83, 61, 229, 1),
                  secondary: Color.fromRGBO(83, 61, 229, 1))),
        ));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(83, 61, 229, 1),
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
                child: AutoSizeText(
                  "Are you a parent?",
                  style: TextStyle(
                    fontFamily: "Cera",
                    fontSize: 45,
                    color: Color.fromRGBO(255, 202, 46, 1),
                  ),
                )),
            Text(
              "OR",
              style: TextStyle(
                  fontFamily: "Cera", fontSize: 30, color: Colors.white),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: CoachLogin(),
                          type: PageTransitionType.rightToLeft));
                },
                child: Text(
                  "Are you a coach?",
                  style: TextStyle(
                    fontFamily: "Cera",
                    fontSize: 45,
                    color: Color.fromRGBO(255, 202, 46, 1),
                  ),
                ))
          ]),
        )));
  }
}
