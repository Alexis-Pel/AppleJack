import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:project/dbHelper/mongoDB.dart';
import 'package:project/dbHelper/constant.dart';


User mongoDbModelFromJson(String str) => User.fromJson(json.decode(str));

String mongoDbModelToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  ObjectId id;
  String firstName;
  String lastName;
  String address;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "address": address,
  };

  static Future<List<Map<String,dynamic>>> getUsers() async{
    var result =  MongoDatabase.getData(USERS_COLLECTION);
    return result;
  }

  static void createUsers(User user) {
    MongoDatabase.createData(user.toJson(),USERS_COLLECTION);
  }


}

