import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class coachDashboard extends StatefulWidget {
  const coachDashboard({super.key});

  @override
  State<coachDashboard> createState() => _coachDashboardState();
}

class _coachDashboardState extends State<coachDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Coach Dashboard")),
    );
  }
}
