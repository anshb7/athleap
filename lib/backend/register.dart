import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:athleap/backend/coach.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _auth = FirebaseAuth.instance;
  bool islogin = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showspinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration Page",
          style: TextStyle(fontFamily: "Cera"),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: Text(
                "Please Fill In The Following Details:",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Cera",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontFamily: "Cera"),
                    hintText: "Enter Your Email ID",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: TextField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontFamily: "Cera"),
                    hintText: "Enter Desired Password",
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
                    final SnackBar snackBar;
                    snackBar = SnackBar(
                        content: Text("User is successfully registered!"));
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => CoachLogin())));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showspinner = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(10, 90),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: Text(
                  "Submit! ",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: "Cera"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
