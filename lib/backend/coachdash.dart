import 'package:athleap/backend/coachprofile.dart';
import 'package:athleap/backend/leaderboard.dart';
import 'package:athleap/backend/profilepage.dart';
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

class coachDashboard extends StatefulWidget {
  const coachDashboard({super.key});

  @override
  State<coachDashboard> createState() => _coachDashboardState();
}

class _coachDashboardState extends State<coachDashboard> {
  bool istrue = false;
  int ind = 0;
  var appbartitiles = ["Dashboard", "Leaderboard", "Coach Profile"];
  var screens = [studentslist(), LeaderboardPage(), coachprofile()];
  var user = FirebaseAuth.instance.currentUser;
  String s = "";
  studentInfo student = studentInfo(
      name: "",
      age: "",
      speed: "",
      agility: "",
      coordination: "",
      flexibility: "",
      reactionTime: "",
      strength: "");

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection("Coaches")
        .doc(user!.uid.toString())
        .get()
        .then((value) => {s = value.data()!['name']});
    setState(() {});

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
  var user = FirebaseAuth.instance.currentUser;
  String s = "";
  studentInfo student = studentInfo(
      name: "",
      age: "",
      speed: "",
      agility: "",
      coordination: "",
      flexibility: "",
      reactionTime: "",
      strength: "");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Dashboard",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 202, 46, 1),
                  fontFamily: "Cera",
                  fontSize: 30),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Coaches")
              .doc(user!.uid.toString())
              .collection("Students")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView(
                    controller: ScrollController(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        shadowColor: Color.fromRGBO(83, 61, 229, 1),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor: Color.fromRGBO(255, 202, 46, 1),
                          onTap: () {
                            student = studentInfo(
                                name: data['Name'],
                                age: data['Age'],
                                speed: data['speed'],
                                agility: data['agility'],
                                coordination: data['coordination'],
                                flexibility: data['flexibility'],
                                reactionTime: data['reactionTime'],
                                strength: data['strength']);

                            setState(() {});

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePage(student: student),
                                ));
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                          ),
                          title: Text(
                            data['Name'],
                            style: TextStyle(fontFamily: "Cera"),
                          ),
                          subtitle: Text(
                            "Age: "
                            "${data['Age'].toString()}",
                            style: TextStyle(fontFamily: "Cera"),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
