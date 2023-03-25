import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:animated_button/animated_button.dart';

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
      backgroundColor: Color.fromRGBO(83, 61, 229, 1),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 40, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Train.Discipline.Reward.",
                style: TextStyle(
                    fontFamily: "Cera", color: Colors.white, fontSize: 40),
              ),
              SizedBox(),
              Text(
                "Track your progress and upskill like never before!",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Cera", fontSize: 20),
              ),
              SizedBox(),
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
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Card(
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: go[index])),
                    );
                  },
                  pagination: SwiperPagination(
                      builder: SwiperPagination.rect,
                      margin: EdgeInsets.all(5.0)),
                  scale: 1,
                ),
              ),
              SizedBox(),
              AnimatedButton(
                shadowDegree: ShadowDegree.dark,
                color: Colors.white,
                width: 300,
                child: Text(
                  'Tap to get started!',
                  style: TextStyle(
                    fontFamily: "Cera",
                    fontSize: 22,
                    color: Color.fromRGBO(83, 61, 229, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
