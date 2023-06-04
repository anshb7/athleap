import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class coachprofile extends StatefulWidget {
  const coachprofile({super.key});

  @override
  State<coachprofile> createState() => _coachprofileState();
}

class _coachprofileState extends State<coachprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(83, 61, 229, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Coach Profile",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 202, 46, 1),
                  fontFamily: "Cera",
                  fontSize: 30),
            ),
          ),
          SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }
}
