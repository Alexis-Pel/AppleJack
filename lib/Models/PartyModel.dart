import 'package:mongo_dart/mongo_dart.dart';
import '../dbHelper/constant.dart';
import '../dbHelper/mongoDB.dart';
import 'dart:convert';

Party partyFromJson(String str) => Party.fromJson(json.decode(str));
String partyToJson(Party data) => json.encode(data.toJson());

enum ThemeParty {apero, repas}

class Party {
  // Variables
  ObjectId id;
  String theme;
  String picture;
  String comment;
  List<dynamic> participant;

  // Constructor
  Party(
    this.id,
    this.theme,
    this.picture,
    this.participant,
    this.comment,
  );

  // Getters
  String get _theme => theme;
  String get _picture => picture;
  String get _comment => comment;
  ObjectId get _id => id;
  List<dynamic> get _participant => participant;

  // Map from Json
  factory Party.fromJson(Map<String, dynamic> json) => Party(
    json["_id"],
    json["theme"],
    json["picture"],
    json["participant"],
    json["comment"],
  );

  // Convert from Json
  Map<String, dynamic> toJson() => {
    "_id": id,
    "theme": theme,
    "picture": picture,
    "participant": participant,
    "comment": comment,
  };

}

Future<List<Map<String, dynamic>>> getPartys() async {
  var result = MongoDatabase.getData(PARTY_COLLECTION);
  return result;
}

Future<void> createParty(Party party) async {
  var response = await MongoDatabase.createData(party.toJson(), PARTY_COLLECTION);
}
