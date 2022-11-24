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
  DateTime date;

  // Constructor
  Party(
    this.id,
    this.theme,
    this.picture,
    this.participant,
    this.comment,
    this.date,
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
    json["date"],
  );

  // Convert from Json
  Map<String, dynamic> toJson() => {
    "_id": id,
    "theme": theme,
    "picture": picture,
    "participant": participant,
    "comment": comment,
    "date": date,
  };

}

Future<List<Map<String, dynamic>>> getPartys() async {
  var result = MongoDatabase.getData(PARTY_COLLECTION);
  return result;
}

Future<void> createParty(Party party) async {
  var response = await MongoDatabase.createData(party.toJson(), PARTY_COLLECTION);
}

Future<List<Map<String, Object?>>?> getWeekParties() async {
  var today = DateTime.now();
  var aadays = (today.day - (today.day - today.weekday + 1));
  var aaaa = Duration(days: aadays, hours: today.hour, minutes: today.minute);
  var bbbb = Duration(days: 6 - aadays);
  var before = today.subtract(aaaa);
  var after = today.add(bbbb);
  var result = await MongoDatabase.getAllBy({"date": {r"$gte": before, r"$lt": after}}, PARTY_COLLECTION);
  return result;
}