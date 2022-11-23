import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:project/dbHelper/mongoDB.dart';
import 'package:project/dbHelper/constant.dart';


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.tel,
    required this.mail,
    required this.password,
    required this.age,
    required this.link,
    required this.picture,
    required this.role,
  });

  ObjectId id;
  String tel;
  String mail;
  String password;
  String age;
  String link;
  String picture;
  int role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    tel: json["tel"],
    mail: json["mail"],
    password: json["password"],
    age: json["age"],
    link: json["link"],
    picture: json["picture"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "tel": tel,
    "mail": mail,
    "password": password,
    "age": age,
    "link": link,
    "picture": picture,
    "role": role,
  };

  static Future<List<Map<String,dynamic>>> getUsers() async{
    var result =  MongoDatabase.getData(USERS_COLLECTION);
    return result;
  }

  static void createUsers(User user) {
    MongoDatabase.createData(user.toJson(),USERS_COLLECTION);
  }

  static Future<Map<String, dynamic>?> getOneUser(Map<String, dynamic> json) async {
    return await MongoDatabase.getOne(json, USERS_COLLECTION);
  }

}

