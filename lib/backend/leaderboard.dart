import 'dart:math';

import 'package:athleap/backend/coachprofile.dart';
import 'package:athleap/backend/leaderboard.dart';
import 'package:athleap/backend/profilepage.dart';
import 'package:athleap/info/studentinfo.dart';
import 'package:athleap/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
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

class LeaderboardPage extends StatefulWidget {
  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  // final leaders  =  FirebaseFirestore.instance
  //     .collection("Coaches")
  //     .doc(user!.uid.toString())
  //     .collection("Students").limit(3)
  //     .get();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(83, 61, 229, 1),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://img.freepik.com/premium-vector/avatar-profile-colorful-illustration-1_549209-85.jpg"),
                          child: Card(
                            elevation: 20,
                          ),
                          minRadius: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("2nd",
                              style: TextStyle(
                                  fontFamily: "Cera",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/002/275/847/original/male-avatar-profile-icon-of-smiling-caucasian-man-vector.jpg'),
                          child: Card(
                            elevation: 20,
                          ),
                          minRadius: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("1st",
                              style: TextStyle(
                                  fontFamily: "Cera",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.cover,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector.png"),
                            child: Card(
                              elevation: 20,
                            ),
                            minRadius: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("3rd",
                              style: TextStyle(
                                  fontFamily: "Cera",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(255, 202, 46, 1)),
              height: 150,
              width: 480,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Coaches")
                      .doc(user!.uid.toString())
                      .collection("Students")
                      .orderBy("pMeasure", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            controller: ScrollController(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
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
                                  // onTap: () {
                                  //   setState(() {});

                                  //   // Navigator.push(
                                  //   //     context,
                                  //   //     MaterialPageRoute(
                                  //   //       builder: (context) =>
                                  //   //           ProfilePage(student: student),
                                  //   //     ));
                                  // },
                                  title: Text(
                                    data['Name'],
                                    style: TextStyle(fontFamily: "Cera"),
                                  ),
                                  subtitle: Text(
                                    "Age: "
                                    "${data['Age'].toString()}",
                                    style: TextStyle(fontFamily: "Cera"),
                                  ),
                                  trailing: Text(
                                    "${data['pMeasure'].toString()} points",
                                    style: TextStyle(fontFamily: "Cera"),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
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
              ),
              height: 400,
              width: 480,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AutoSizeText(
              quote(),
              style: TextStyle(
                fontFamily: "Cera",
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String quote() {
    Random random = Random();
    int number = random.nextInt(5);
    List<String> quotes = [
      "If winning were easy everyone would do it.",
      'MINDSET IS EVERYTHING.',
      "If you aren’t going all the way, why go at all?",
      "Feel fearless to succeed.",
      "Success is where prepartion and opportunity meet."
    ];
    return quotes[number];
  }
}
