import 'package:athleap/main.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:animated_button/animated_button.dart';
import 'package:page_transition/page_transition.dart';

class landingpage extends StatelessWidget {
  List<Image> go = [
    Image.asset("assets/images/1.png"),
    Image.asset("assets/images/2.png"),
    Image.asset("assets/images/3.png"),
    Image.asset("assets/images/4.png"),
    Image.asset("assets/images/5.png")
  ];
  landingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 202, 46, 1),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ATHLEAP",
                  style: TextStyle(
                      fontFamily: "Cera",
                      fontSize: 40,
                      color: Color.fromRGBO(83, 61, 229, 1),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Dream.Train.Achieve.",
                  style: TextStyle(
                      fontFamily: "Cera",
                      color: Color.fromRGBO(83, 61, 229, 1),
                      fontSize: 60),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "The sky has no limits and neither should you!",
                  style: TextStyle(
                      color: Color.fromRGBO(83, 61, 229, 1),
                      fontFamily: "Cera",
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 250,
                  width: 400,
                  child: Swiper(
                    itemWidth: 450,
                    itemHeight: 300,
                    layout: SwiperLayout.DEFAULT,
                    duration: 1000,
                    autoplay: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: Card(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: go[index])),
                        ),
                      );
                    },
                    pagination: SwiperPagination(
                        builder: SwiperPagination.rect,
                        margin: EdgeInsets.all(5.0)),
                    scale: 1,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                AnimatedButton(
                  shadowDegree: ShadowDegree.dark,
                  color: Color.fromRGBO(83, 61, 229, 1),
                  width: 300,
                  child: Text(
                    'Tap to get started!',
                    style: TextStyle(
                      fontFamily: "Cera",
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: HomeScreen(),
                            type: PageTransitionType.rightToLeft));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
