// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:athleap/info/studentinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.student});
  final studentInfo student;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    List<String> metrics = [
      "SPEED",
      "AGILITY",
      "COORDINATION",
      "REACTION TIME",
      "STRENGTH",
      "FLEXIBILITY"
    ];
    List<String> metricvalues = [
      widget.student.speed,
      widget.student.agility,
      widget.student.coordination,
      widget.student.reactionTime,
      widget.student.strength,
      widget.student.flexibility
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color.fromRGBO(255, 202, 46, 1),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("Player Profile",
                    style: TextStyle(
                        fontFamily: "Cera",
                        color: Color.fromRGBO(83, 61, 229, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30))),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Center(
              child: Card(
                elevation: 8,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.yellow,
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                            child: Container(
                              child: Center(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Name",
                                              style: TextStyle(
                                                  fontFamily: "Cera",
                                                  color: Colors.black)),
                                          Center(
                                            child: Text(widget.student.name,
                                                style: TextStyle(
                                                    fontFamily: "Cera",
                                                    color: Colors.black)),
                                          )
                                        ],
                                      ),
                                      SizedBox(),
                                      VerticalDivider(
                                        color: Colors.black,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Age",
                                              style: TextStyle(
                                                  fontFamily: "Cera",
                                                  color: Colors.black)),
                                          Text(widget.student.age.toString(),
                                              style: TextStyle(
                                                  fontFamily: "Cera",
                                                  color: Colors.black))
                                        ],
                                      ),
                                      VerticalDivider(
                                        color: Colors.black,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("Academy Name",
                                                  style: TextStyle(
                                                      fontFamily: "Cera",
                                                      color: Colors.black)),
                                              Center(
                                                child: Text("PBC",
                                                    style: TextStyle(
                                                        fontFamily: "Cera",
                                                        color: Colors.black)),
                                              )
                                            ]),
                                      )
                                    ]),
                              ),
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5, color: Colors.grey),
                                  ],
                                  color: Color.fromRGBO(250, 249, 246, 1),
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(83, 61, 229, 1),
                      border: Border.all(color: Color.fromRGBO(83, 61, 229, 1)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 2),
                      ],
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text(
              "METRICS",
              style: TextStyle(
                  fontFamily: "Cera",
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: ListView.builder(
              controller: ScrollController(),
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              Text(
                                metrics[index],
                                style: TextStyle(
                                    fontFamily: "Cera",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                child: Text(
                                  ":",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 10,
                              ),
                              Text(
                                '${double.parse(metricvalues[index]) * 100} %',
                                style: TextStyle(
                                    fontFamily: "Cera",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      Card(
                          elevation: 8,
                          child: LinearProgressIndicator(
                            semanticsLabel: "al",
                            minHeight: 30,
                            value: double.parse(metricvalues[index]),
                          ) // ListTile(

                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(8)),
                          //   tileColor: Colors.blueGrey,
                          //   onTap: () {
                          //     print("yes");
                          //   },
                          // ),
                          ),
                    ],
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
