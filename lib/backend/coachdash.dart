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
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${user!.displayName}'s Dashboard",
            style: TextStyle(fontFamily: "Cera"),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  final SnackBar snackBar;
                  snackBar = SnackBar(
                    content: Text("User is successfully signed out!"),
                  );
                  await FirebaseAuth.instance.signOut();
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  await provider.logout();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pushNamed(context, '/coachlogin');
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
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['Name']),
                  subtitle: Text(data['Age'].toString()),
                );
              }).toList(),
            );
          },
        ));
  }
}
