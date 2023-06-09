// import 'dart:html';

// import 'dart:html';
import 'package:athleap/backend/coachdata.dart';
import 'package:athleap/backend/register.dart';
import 'package:athleap/backend/studentdata.dart';
import 'package:athleap/backend/studentregister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:athleap/backend/coachdash.dart';
import 'package:athleap/info/coachinfo.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:athleap/provider/googlesignin.dart';
import 'package:athleap/provider/googlesignin.dart';

class StudentLogin extends StatefulWidget {
  StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  late Future<UserCredential> userr;
  bool showspinner = false;
  CollectionReference coaches =
      FirebaseFirestore.instance.collection("Coaches");
  bool islogin = false;
  List<String> finaldocs = [];

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 202, 46, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Student Login",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(83, 61, 229, 1),
                      fontFamily: "Cera",
                      fontSize: 40),
                ),
                SizedBox(
                  height: 200,
                ),
                Card(
                  elevation: 8,
                  color: Color.fromRGBO(83, 61, 229, 1),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 30),
                        child: Text(
                          "Login with Email ID!",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Cera",
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 30),
                        child: TextField(
                          cursorColor: Colors.white,
                          style: TextStyle(
                              fontFamily: "Cera", color: Colors.white),
                          controller: email,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(255, 202, 46, 1))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.white)),
                              hintStyle: TextStyle(
                                  fontFamily: "Cera", color: Colors.white),
                              hintText: "Enter Email ID",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 30),
                        child: TextField(
                          cursorColor: Colors.white,
                          style: TextStyle(
                              fontFamily: "Cera", color: Colors.white),
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(255, 202, 46, 1))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.white)),
                              hintStyle: TextStyle(
                                  fontFamily: "Cera", color: Colors.white),
                              hintText: "Enter Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            isTrue();

                            setState(() {
                              showspinner = true;
                            });
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text);
                              for (var i in finaldocs) {
                                if (i ==
                                    FirebaseAuth.instance.currentUser!.uid) {
                                  islogin = true;
                                  break;
                                } else {
                                  islogin = false;
                                }
                              }
                              setState(() {});

                              if (islogin) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            coachDashboard())));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => studentdata())));
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                            setState(() {
                              showspinner = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
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
                      Text(
                        "OR ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Cera"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            userr = googleSignIn().signInWithGoogle();
                            userr.then((value) =>
                                Navigator.pushReplacementNamed(
                                    context, '/studentdata'));
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://blog.hubspot.com/hubfs/image8-2.jpg"),
                            radius: 25,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New User?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cera",
                                color: Colors.white),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            RegisterStudent())));
                              },
                              child: Text(
                                "Sign up now!",
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 202, 46, 1),
                                    fontFamily: "Cera"),
                              ))
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future isTrue() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('Coaches').get();
    final List<DocumentSnapshot> documents = result.docs;
    List<String> docIds = [];
    documents.forEach((element) {
      String s = element.id;
      docIds.add(s);
    });
    finaldocs = docIds;
    print(finaldocs);
  }

  // void _onPressed() {
  //   FirebaseFirestore.instance
  //       .collection("Coaches")
  //       .where("phNo", isEqualTo: double.parse(_academyid.text))
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print(result.data());
  //     });
  //   });
  // }
}
