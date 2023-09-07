// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'dart:convert';
import 'user.dart';

UserList userListFromJson(String str) => UserList.fromJson(json.decode(str));

String userListToJson(UserList data) => json.encode(data.toJson());

class UserList {
  int code;
  String message;
  List<User> data;

  UserList({
    required this.code,
    required this.message,
    required this.data,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        code: json["code"],
        message: json["message"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
