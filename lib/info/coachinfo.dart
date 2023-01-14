import 'package:flutter/foundation.dart';

class CoachInfo with ChangeNotifier {
  String name = "";
  String emailId = "";
  double phNo = 0;
  String sportName = "";
  String academyName = "";
  CoachInfo(
      {required this.name,
      required this.emailId,
      required this.phNo,
      required this.academyName,
      required this.sportName});
  Map<String, dynamic> toJson() => {
        "name": name,
        "emailId": emailId,
        "phNo": phNo,
        "sportName": sportName,
        "academyName": academyName
      };
  static CoachInfo fromJson(Map<String, dynamic> json) {
    return CoachInfo(
        name: json['name'],
        emailId: json['emailID'],
        phNo: json['phNo'],
        academyName: json['academyName'],
        sportName: json['sportName']);
  }
}

class Coaches with ChangeNotifier {
  List<CoachInfo> _coaches = [];
  List<CoachInfo> get coaches {
    return [..._coaches];
  }
}
