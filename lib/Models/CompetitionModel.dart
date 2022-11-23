// To parse this JSON data, do
//
//     final competition = competitionFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:project/dbHelper/constant.dart';

import '../dbHelper/mongoDB.dart';

Competition competitionFromJson(String str) => Competition.fromJson(json.decode(str));

String competitionToJson(Competition data) => json.encode(data.toJson());

class Competition {
  Competition({
    required this.id,
    required this.name,
    required this.adress,
    required this.picture,
    required this.date,
    required this.cavalier,
  });

  ObjectId id;
  String name;
  String adress;
  String picture;
  String date;
  String cavalier;

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
    id: json["_id"],
    name: json["name"],
    adress: json["adress"],
    picture: json["picture"],
    date: json["date"],
    cavalier: json["cavalier"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "adress": adress,
    "picture": picture,
    "date": date,
    "cavalier": cavalier,
  };
  Future<List<Map<String, dynamic>>> getCompetitions() async {
    var result = MongoDatabase.getData(COMPETITION_COLLECTION);
    return result;
  }

  Future<void> createCompetition(Competition competition) async {
    var response = await MongoDatabase.createData(competition.toJson(), COMPETITION_COLLECTION);
  }
}
