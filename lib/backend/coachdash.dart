import 'package:athleap/backend/coachprofile.dart';
import 'package:athleap/backend/leaderboard.dart';
import 'package:athleap/backend/profilepage.dart';
import 'package:athleap/info/studentinfo.dart';
import 'package:athleap/main.dart';
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

class coachDashboard extends StatefulWidget {
  const coachDashboard({super.key});

  @override
  State<coachDashboard> createState() => _coachDashboardState();
}

class _coachDashboardState extends State<coachDashboard> {
  int ind = 0;
  var appbartitiles = ["Dashboard", "Leaderboard", "Coach Profile"];
  var screens = [studentslist(), Leaderboard(), coachprofile()];
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(shape: BoxShape.rectangle),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GNav(
                backgroundColor: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Color.fromRGBO(83, 61, 229, 1),
                color: Color.fromRGBO(83, 61, 229, 1),
                tabBorderRadius: 10,
                padding: EdgeInsets.all(16),
                gap: 8,
                onTabChange: (index) {
                  setState(() {
                    ind = index;
                  });
                },
                tabs: [
                  GButton(
                    textStyle:
                        TextStyle(fontFamily: "Cera", color: Colors.white),
                    icon: Icons.dashboard,
                    text: "Dashboard",
                  ),
                  GButton(
                    textStyle:
                        TextStyle(fontFamily: "Cera", color: Colors.white),
                    icon: Icons.leaderboard,
                    text: "Leaderboard",
                  ),
                  GButton(
                    textStyle:
                        TextStyle(fontFamily: "Cera", color: Colors.white),
                    icon: Icons.face,
                    text: "Profile",
                  )
                ]),
          ),
        ),
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              appbartitiles[ind],
              style: TextStyle(fontFamily: "Cera"),
            ),
          ),
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Coaches")
          .doc(user!.uid.toString())
          .collection("Students")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Center(
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Card(
                    elevation: 5,
                    shadowColor: Color.fromRGBO(83, 61, 229, 1),
                    child: ListTile(
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
    );
  }
}
