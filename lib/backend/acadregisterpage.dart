import 'package:athleap/backend/coach.dart';
import 'package:athleap/backend/coachdata.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class acadregsiter extends StatefulWidget {
  const acadregsiter({super.key});

  @override
  State<acadregsiter> createState() => _acadregsiterState();
}

class _acadregsiterState extends State<acadregsiter> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return CoachData();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went worng"),
            );
          } else {
            return CoachLogin();
          }
        });
  }
}
