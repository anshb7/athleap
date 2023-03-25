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
        padding: const EdgeInsets.all(8.0),
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
                          child: Card(
                            elevation: 20,
                          ),
                          minRadius: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("2nd",
                              style: TextStyle(
                                  fontFamily: "Cera", color: Colors.black)),
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
                          child: Card(
                            elevation: 20,
                          ),
                          minRadius: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("1st",
                              style: TextStyle(
                                  fontFamily: "Cera", color: Colors.black)),
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
                          child: Card(
                            elevation: 20,
                          ),
                          minRadius: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("3rd",
                              style: TextStyle(
                                  fontFamily: "Cera", color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              height: 150,
              width: 400,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
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
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
              height: 400,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
