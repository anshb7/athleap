import 'package:athleap/backend/profilepage.dart';
import 'package:athleap/info/studentinfo.dart';
import 'package:athleap/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  var user = FirebaseAuth.instance.currentUser;
  String s = "";
  studentInfo student = studentInfo(
      name: "",
      age: 0,
      speed: 0,
      agility: 0,
      coordination: 0,
      flexibility: 0,
      reactionTime: 0,
      strength: 0);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection("Coaches")
        .doc(user!.uid.toString())
        .get()
        .then((value) => {s = value.data()!['name']});
    setState(() {});

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Dashboard",
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
        body: StreamBuilder<QuerySnapshot>(
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
              return CircularProgressIndicator();
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  onTap: () {
                    student = studentInfo(
                        name: data['Name'],
                        age: data['Age'],
                        speed: double.parse(data['speed']),
                        agility: double.parse(data['agility']),
                        coordination: double.parse(data['coordination']),
                        flexibility: double.parse(data['flexibility']),
                        reactionTime: double.parse(data['reactionTime']),
                        strength: double.parse(data['strength']));

                    setState(() {});

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ProfilePage(student: student),
                    //     ));
                  },
                  title: Text(data['Name']),
                  subtitle: Text(data['Age'].toString()),
                );
              }).toList(),
            );
          },
        ));
  }
}
