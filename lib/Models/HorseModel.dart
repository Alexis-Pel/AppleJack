// To parse this JSON data, do
//
//     final horse = horseFromJson(jsonString);

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

import '../dbHelper/constant.dart';
import '../dbHelper/mongoDB.dart';

Horse horseFromJson(String str) => Horse.fromJson(json.decode(str));

String horseToJson(Horse data) => json.encode(data.toJson());

class Horse {
  Horse({
    required this.id,
    required this.photo,
    required this.name,
    required this.age,
    required this.coat,
    required this.breed,
    required this.gender,
    required this.speciality,
    required this.owner,
    required this.stable,
    required this.dp,
  });

  ObjectId id;
  String photo;
  String name;
  String age;
  String coat;
  String breed;
  String gender;
  String speciality;
  ObjectId owner;
  String stable;
  List<dynamic> dp;

  factory Horse.fromJson(Map<String, dynamic> json) => Horse(
    id: json["_id"],
    photo: json["photo"],
    name: json["name"],
    age: json["age"],
    coat: json["coat"],
    breed: json["breed"],
    gender: json["gender"],
    speciality: json["speciality"],
    owner: json["owner"],
    stable: json["stable"],
    dp: json["DP"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "photo": photo,
    "name": name,
    "age": age,
    "coat": coat,
    "breed": breed,
    "gender": gender,
    "speciality": speciality,
    "owner": owner,
    "stable": stable,
    "DP": dp,
  };
  static Future<List<Map<String,dynamic>>> getHorses() async{
    var result =  MongoDatabase.getData(HORSE_COLLECTION);
    return result;
  }

  static Future<List<Map<String,dynamic>>?> getHorsesOwner(ObjectId id) async{
    var result =  await MongoDatabase.getAllBy({"owner": id}, HORSE_COLLECTION);
    return result;
  }

  static Future<void> createHorse(Horse horse) async {
    print("envois");
    await MongoDatabase.createData(horse.toJson(),HORSE_COLLECTION);
  }
}
