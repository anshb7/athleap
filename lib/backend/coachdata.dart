import 'package:athleap/backend/coachdash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:athleap/backend/coach.dart';
import 'package:string_validator/string_validator.dart';

import 'package:athleap/info/coachinfo.dart';

class CoachData extends StatefulWidget {
  const CoachData({super.key});

  @override
  State<CoachData> createState() => _CoachDataState();
}

class _CoachDataState extends State<CoachData> {
  final user = FirebaseAuth.instance.currentUser;

  final formkey = GlobalKey<FormState>();
  String name = "";
  String emailId = "";
  double phoneNo = 0;
  String sportName = "";
  String academyName = "";

  CollectionReference coaches =
      FirebaseFirestore.instance.collection("Coaches");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Academy Registration Form",
          style:
              TextStyle(color: Colors.white, fontFamily: "Cera", fontSize: 15),
        ),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          child: Center(
            child: Form(
                key: formkey,
                child: Expanded(
                    child: Center(
                        child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 30),
                          child: Text(
                            "Fill in your details!",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cera'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        child: TextFormField(
                          validator: (value) {
                            if (isInt(value.toString())) {
                              return "Invalid Input";
                            } else if (value?.isEmpty == true) {
                              return "Input can't be null";
                            } else {
                              return null;
                            }
                          },
                          autocorrect: true,
                          decoration: InputDecoration(
                              labelText: "Enter Name",
                              labelStyle: TextStyle(fontFamily: "Cera"),
                              border: OutlineInputBorder(
                                  gapPadding: 2,
                                  borderRadius: BorderRadius.circular(20))),
                          textInputAction: TextInputAction.next,
                          onSaved: (newValue) {
                            setState(() {
                              name = newValue.toString();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        child: TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontFamily: "Cera"),
                              prefixText: "+91",
                              labelText: "Enter phNo.",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (isAlpha(value.toString())) {
                              return "Invalid Input";
                            } else if (value?.isEmpty == true) {
                              return "Input can't be null";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            setState(() {
                              phoneNo = double.parse(newValue.toString());
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        child: TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontFamily: "Cera"),
                              labelText: "Enter Your Sport",
                              border: OutlineInputBorder(
                                  gapPadding: 2,
                                  borderRadius: BorderRadius.circular(20))),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (isInt(value.toString())) {
                              return "Invalid Input";
                            } else if (value?.isEmpty == true) {
                              return "Input can't be null";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            setState(() {
                              sportName = newValue.toString();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        child: TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontFamily: "Cera"),
                              labelText: "Academy Name",
                              border: OutlineInputBorder(
                                  gapPadding: 2,
                                  borderRadius: BorderRadius.circular(20))),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (isInt(value.toString())) {
                              return "Invalid Input";
                            } else if (value?.isEmpty == true) {
                              return "Input can't be null";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            setState(() {
                              academyName = newValue.toString();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            final isValid = formkey.currentState?.validate();
                            if (isValid!) {
                              formkey.currentState?.save();
                              try {
                                createuser();
                                final snackbar = SnackBar(
                                  content: Text(
                                    "Successfully Added!",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            coachDashboard())));
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          child: Text(
                            "Submit! ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Cera"),
                          ),
                        ),
                      ),
                    ],
                  ),
                )))),
          ),
        ),
      ),
    );
  }

  Future createuser() async {
    final coach = CoachInfo(
        name: name,
        emailId: emailId,
        phNo: phoneNo,
        academyName: academyName,
        sportName: sportName);
    final json = coach.toJson();
    return coaches.doc(user!.uid.toString()).set(json);
  }
}
