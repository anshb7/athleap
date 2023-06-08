import 'package:athleap/backend/coachdash.dart';
import 'package:athleap/info/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:athleap/backend/coach.dart';
import 'package:string_validator/string_validator.dart';
import 'package:intl/intl.dart';
import 'package:athleap/info/coachinfo.dart';

class studentdata extends StatefulWidget {
  const studentdata({super.key});

  @override
  State<studentdata> createState() => _studentdataState();
}

class _studentdataState extends State<studentdata> {
  TextEditingController date = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  final formkey = GlobalKey<FormState>();
  String name = "";
  String dob = "";
  String sportName = "";
  String academyName = "";
  String coachName = "";

  CollectionReference students =
      FirebaseFirestore.instance.collection("Students");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(83, 61, 229, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Student Registration Form",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 202, 46, 1),
                  fontFamily: "Cera",
                  fontSize: 30),
            ),
            SizedBox(
              height: 200,
            ),
            Center(
              child: Container(
                height: 470,
                child: Card(
                  color: Color.fromRGBO(255, 202, 46, 1),
                  child: Center(
                    child: Form(
                        key: formkey,
                        child: Expanded(
                            child: Center(
                                child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
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
                                  style: TextStyle(fontFamily: "Cera"),
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
                                          borderRadius:
                                              BorderRadius.circular(20))),
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
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime.now(), //get today's date
                                        firstDate: DateTime(
                                            1900), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));
                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy').format(
                                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2022-07-04
                                      //You can format date as per your need

                                      setState(() {
                                        date.text =
                                            formattedDate; //set foratted date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                  controller: date,
                                  style: TextStyle(fontFamily: "Cera"),
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.calendar_today),
                                      labelStyle: TextStyle(fontFamily: "Cera"),
                                      labelText: "Enter DOB",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
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
                                      dob = date.text;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 30),
                                child: TextFormField(
                                  style: TextStyle(fontFamily: "Cera"),
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(fontFamily: "Cera"),
                                      labelText: "Enter Your Sport",
                                      border: OutlineInputBorder(
                                          gapPadding: 2,
                                          borderRadius:
                                              BorderRadius.circular(20))),
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
                                  style: TextStyle(fontFamily: "Cera"),
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(fontFamily: "Cera"),
                                      labelText: "Academy Name",
                                      border: OutlineInputBorder(
                                          gapPadding: 2,
                                          borderRadius:
                                              BorderRadius.circular(20))),
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
                                    vertical: 5, horizontal: 30),
                                child: TextFormField(
                                  style: TextStyle(fontFamily: "Cera"),
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(fontFamily: "Cera"),
                                      labelText: "Coach Name",
                                      border: OutlineInputBorder(
                                          gapPadding: 2,
                                          borderRadius:
                                              BorderRadius.circular(20))),
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
                                      coachName = newValue.toString();
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Container(
                                  width: 50,
                                  child: TextButton(
                                    onPressed: () {
                                      final isValid =
                                          formkey.currentState?.validate();
                                      if (isValid!) {
                                        formkey.currentState?.save();
                                        try {
                                          createuser();
                                          final snackbar = SnackBar(
                                            content: Text(
                                              "Successfully Added!",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
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
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    child: Text(
                                      "Submit! ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(83, 61, 229, 1),
                                        fontSize: 20,
                                        fontFamily: "Cera",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future createuser() async {
    final coach = student(
        name: name,
        dob: dob,
        coachName: coachName,
        //emailId: emailId,
        //phNo: phoneNo,
        academyName: academyName,
        sportName: sportName);
    final json = coach.toJson();
    return students.doc(user!.uid.toString()).set(json);
  }
}
