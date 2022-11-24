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
    required this.amateur,
    required this.club1,
    required this.club2,
    required this.club3,
    required this.club4,
  });

  ObjectId id;
  String name;
  String adress;
  String picture;
  DateTime date;
  List<dynamic> amateur;
  List<dynamic> club1;
  List<dynamic> club2;
  List<dynamic> club3;
  List<dynamic> club4;

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
    id: json["_id"],
    name: json["name"],
    adress: json["adress"],
    picture: json["picture"],
    date: json["date"],
    amateur: json["amateur"],
    club1: json["club1"],
    club2: json["club2"],
    club3: json["club3"],
    club4: json["club4"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "adress": adress,
    "picture": picture,
    "date": date,
    "amateur": amateur,
    "club1": club1,
    "club2": club2,
    "club3": club3,
    "club4": club4,

  };
  static Future<List<Map<String, dynamic>>> getCompetitions() async {
    var result = MongoDatabase.getData(COMPETITION_COLLECTION);
    return result;
  }

  static Future<void> createCompetition(Competition competition) async {
    var response = await MongoDatabase.createData(competition.toJson(), COMPETITION_COLLECTION);
  }
}
