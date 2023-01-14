import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ParentLogin extends StatelessWidget {
  const ParentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _academyid = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Parent Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Login with your Academy ID",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Arinoe",
                fontSize: 30),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: TextField(
              controller: _academyid,
              decoration: InputDecoration(
                  hintText: "Enter ID",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              child: Text(
                "Submit! ",
                style: TextStyle(
                    color: Colors.white, fontSize: 25, fontFamily: "Arinoe"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
