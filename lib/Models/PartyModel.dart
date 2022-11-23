// To parse this JSON data, do
//
//     final party = partyFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

import '../dbHelper/constant.dart';
import '../dbHelper/mongoDB.dart';

Party partyFromJson(String str) => Party.fromJson(json.decode(str));

String partyToJson(Party data) => json.encode(data.toJson());

class Party {
  Party({
    required this.id,
    required this.theme,
    required this.picture,
    required this.participant,
    required this.comment,
  });

  ObjectId id;
  String theme;
  String picture;
  String participant;
  String comment;

  factory Party.fromJson(Map<String, dynamic> json) => Party(
    id: json["_id"],
    theme: json["theme"],
    picture: json["picture"],
    participant: json["participant"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "theme": theme,
    "picture": picture,
    "participant": participant,
    "comment": comment,
  };
  Future<List<Map<String, dynamic>>> getPartys() async {
    var result = MongoDatabase.getData(PARTY_COLLECTION);
    return result;
  }

  Future<void> createParty(Party party) async {
    var response = await MongoDatabase.createData(party.toJson(), PARTY_COLLECTION);
  }
}
