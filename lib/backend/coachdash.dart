import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
      appBar: AppBar(title: Text("${user!.displayName}'s Dashboard")),
    );
  }
}
