import 'package:athleap/backend/coachprofile.dart';
import 'package:athleap/backend/leaderboard.dart';
import 'package:athleap/backend/profilepage.dart';
import 'package:athleap/frontend/shimmer.dart';
import 'package:athleap/info/studentinfo.dart';
import 'package:athleap/main.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:athleap/provider/googlesignin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athleap/backend/leaderboard.dart';
import 'package:athleap/frontend/skeleton.dart';
import 'package:athleap/frontend/shimmer.dart';

class studentDashboard extends StatefulWidget {
  const studentDashboard({super.key});

  @override
  State<studentDashboard> createState() => _studentDashboardState();
}

class _studentDashboardState extends State<studentDashboard> {
  bool istrue = false;
  int ind = 0;
  var appbartitiles = ["Dashboard", "Leaderboard", "Coach Profile"];
  var screens = [studentslist(), LeaderboardPage(), coachprofile()];
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(83, 61, 229, 1),
        bottomNavigationBar: CurvedNavigationBar(
            color: Color.fromRGBO(37, 38, 50, 1),
            buttonBackgroundColor: Color.fromRGBO(255, 202, 46, 1),
            animationCurve: Curves.easeIn,
            height: 60,
            animationDuration: Duration(milliseconds: 400),
            backgroundColor: Color.fromRGBO(83, 61, 229, 1),
            onTap: (value) {
              setState(() {
                istrue = true;
                ind = value;
              });
            },
            items: [
              Icon(Icons.dashboard_sharp, color: Colors.white),
              Icon(Icons.leaderboard, color: Colors.white),
            ]),
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  final SnackBar snackBar;
                  snackBar = SnackBar(
                    content: Text("User is successfully signed out!"),
                  );
                  FirebaseAuth.instance.signOut();
                  googleSignIn().signOutWithGoogle();

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (route) => false);
                },
                icon: Icon(
                  Icons.logout_sharp,
                  color: Colors.white,
                ))
          ],
        ),
        body: screens[ind]);
  }
}

class studentslist extends StatefulWidget {
  const studentslist({super.key});

  @override
  State<studentslist> createState() => _studentslistState();
}

class _studentslistState extends State<studentslist> {
  String name = "";
  String dob = "";
  String academyName = "";
  String coachName = "";
  String sport = "";
  void initState() {
    FirebaseFirestore.instance
        .collection("Students")
        .doc(user!.uid.toString())
        .get()
        .then((value) {
      setState(() {
        name = value.data()!['name'];
        dob = value.data()!['dob'];
        academyName = value.data()!['academyName'];
        coachName = value.data()!['coachName'];
        sport = value.data()!['sportName'];
      });
    });
    super.initState();
  }

  var user = FirebaseAuth.instance.currentUser;
  String s = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Hi! ${name}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 202, 46, 1),
                  fontFamily: "Cera",
                  fontSize: 30),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0.8,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                          minRadius: 40,
                        ),
                        Text(
                          "Sport: ${sport}",
                          style: TextStyle(fontFamily: "Cera", fontSize: 20),
                        )
                      ]),
                  Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "DOB: ${dob}",
                        style: TextStyle(fontFamily: "Cera", fontSize: 20),
                      ),
                      Text(
                        "Academy Name: ${academyName}",
                        style: TextStyle(fontFamily: "Cera", fontSize: 20),
                      ),
                      Text(
                        "Coach Name: ${coachName}",
                        style: TextStyle(fontFamily: "Cera", fontSize: 20),
                      )
                    ],
                  ),
                  Divider(),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(255, 202, 46, 1),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
        )
      ],
    );
  }
}
