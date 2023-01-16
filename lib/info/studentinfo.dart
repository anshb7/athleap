import 'package:flutter/foundation.dart';
import 'package:flutter/physics.dart';

class studentInfo with ChangeNotifier {
  String name = "";
  int speed = 0;
  int agility = 0;
  int reactionTime = 0;
  int flexibility = 0;
  int strength = 0;
  int age = 0;
  int coordination = 0;

  studentInfo(
      {required this.name,
      required this.age,
      required this.speed,
      required this.agility,
      required this.coordination,
      required this.flexibility,
      required this.reactionTime,
      required this.strength});
  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "speed": speed,
        "agility": agility,
        "coordination": coordination,
        "flexibility": flexibility,
        "reactionTime": reactionTime,
        "strength": strength
      };
  static studentInfo fromJson(Map<String, dynamic> json) {
    return studentInfo(
        name: json['name'],
        age: json['age'],
        speed: json['speed'],
        agility: json['agility'],
        coordination: json['coordination'],
        flexibility: json['flexibility'],
        reactionTime: json['reactionTime'],
        strength: json['strength']);
  }
}

class Students with ChangeNotifier {
  List<studentInfo> _students = [];
  List<studentInfo> get students {
    return [..._students];
  }
}
