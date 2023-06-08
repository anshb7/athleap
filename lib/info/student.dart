import 'package:flutter/foundation.dart';

class student with ChangeNotifier {
  String name = "";
  String dob;
  String sportName = "";
  String academyName = "";
  String coachName = "";
  student(
      {required this.name,
      required this.dob,
      required this.academyName,
      required this.sportName,
      required this.coachName});
  Map<String, dynamic> toJson() => {
        "name": name,
        "sportName": sportName,
        "academyName": academyName,
        "coachName": coachName,
        "dob": dob,
      };
  static student fromJson(Map<String, dynamic> json) {
    return student(
        name: json['name'],
        dob: json['dob'],
        academyName: json['academyName'],
        sportName: json['sportName'],
        coachName: json['coachName']);
  }
}
