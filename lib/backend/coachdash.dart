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
  User? user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _studentStream = await FirebaseFirestore.instance
      .collection("Coaches")
      .doc( )
      .collection("Students")
      .get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user!.displayName}'s Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                final SnackBar snackBar;
                snackBar = SnackBar(
                  content: Text("User is successfully signed out!"),
                );
                FirebaseAuth.instance.signOut();
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => HomeScreen())));
              },
              icon: Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
