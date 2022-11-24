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
    required this.username,
    required this.password,
    required this.age,
    required this.link,
    required this.picture,
    required this.role,
  });

  ObjectId id;
  String tel;
  String mail;
  String username;
  String password;
  String age;
  String link;
  String picture;
  int role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    tel: json["tel"],
    mail: json["mail"],
    username: json["username"],
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
    "username": username,
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
  static Future<Map<String, dynamic>?> updatePassword(Map<String, dynamic> json,String password) async {
    var user = await MongoDatabase.getOne(json,USERS_COLLECTION);
    User test = User.fromJson(user!);
    test.password = password;

    MongoDatabase.update(test.toJson(), test.id.toString(), USERS_COLLECTION);
  }
  static Future<Map<String, dynamic>?> updateUser(Map<String, dynamic> json,String username,String email,String tel,String password,String age,String link,String picture) async {
    var user = await MongoDatabase.getOne(json,USERS_COLLECTION);
    User test = User.fromJson(user!);
    test.username = username;
    test.mail = email;
    test.tel= tel;
    test.password=password;
    test.age= age;
    test.link=link;
    test.picture=picture;
    MongoDatabase.update(test.toJson(), test.id.toString(), USERS_COLLECTION);
  }
}

