import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:project/dbHelper/mongoDB.dart';
import 'package:project/dbHelper/constant.dart';


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mail,
    required this.password,
    required this.role,
  });

  ObjectId id;
  String firstName;
  String lastName;
  String mail;
  String password;
  int role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    mail: json["mail"],
    password: json["password"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "mail": mail,
    "password": password,
    "role": role,
  };


  static Future<List<Map<String,dynamic>>> getUsers() async{
    var result =  MongoDatabase.getData(USERS_COLLECTION);
    return result;
  }

  static void createUsers(User user) {
    MongoDatabase.createData(user.toJson(),USERS_COLLECTION);
  }


}

