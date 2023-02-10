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
      backgroundColor: Color.fromRGBO(250, 249, 246, 1),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  "https://media.licdn.com/dms/image/D4D03AQGWG7TV3CNDsg/profile-displayphoto-shrink_800_800/0/1672670019852?e=1681344000&v=beta&t=1ND4iOJBv5Q6uQ92ixrAgb7-lkwavbpWg1vY-ywHPQU"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
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
                                          Text(widget.student.name,
                                              style: TextStyle(
                                                  fontFamily: "Cera",
                                                  color: Colors.black))
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
                                              Text("PBC",
                                                  style: TextStyle(
                                                      fontFamily: "Cera",
                                                      color: Colors.black))
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
                  height: 220,
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          metrics[index],
                          style: TextStyle(fontFamily: "Cera", fontSize: 20),
                        )),
                    Card(
                        elevation: 8,
                        child: LinearProgressIndicator(
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
        ]),
      ),
    );
  }
}
