// import 'dart:html';

// import 'dart:html';
import 'package:athleap/backend/coachdata.dart';
import 'package:athleap/backend/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:athleap/backend/coachdash.dart';
import 'package:athleap/info/coachinfo.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:athleap/provider/googlesignin.dart';

class CoachLogin extends StatefulWidget {
  CoachLogin({super.key});

  @override
  State<CoachLogin> createState() => _CoachLoginState();
}

class _CoachLoginState extends State<CoachLogin> {
  bool showspinner = false;
  CollectionReference coaches =
      FirebaseFirestore.instance.collection("Coaches");

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coach Login",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Cera"),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  child: Text(
                    "Login with Email ID!",
                    style: TextStyle(fontSize: 25, fontFamily: "Cera"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontFamily: "Cera"),
                        hintText: "Enter Email ID",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontFamily: "Cera"),
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        showspinner = true;
                      });
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => CoachData())));
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: "Cera"),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => RegisterUser())));
                        },
                        child: Text(
                          "Sign up now!",
                          style:
                              TextStyle(color: Colors.blue, fontFamily: "Cera"),
                        ))
                  ],
                ),
                Divider(),
                Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GestureDetector(
                      onTap: () {
                        try {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.signInWithGoogle();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => CoachData())));
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png")),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
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
