// To parse this JSON data, do
//
//     final dashboardEvent = dashboardEventFromJson(jsonString);
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:project/dbHelper/constant.dart';
import '../dbHelper/mongoDB.dart';

DashboardEvent dashboardEventFromJson(String str) => DashboardEvent.fromJson(json.decode(str));

String dashboardEventToJson(DashboardEvent data) => json.encode(data.toJson());

class DashboardEvent {
  DashboardEvent({
    required this.id,
    required this.type,
    required this.message,
  });

  ObjectId id;
  String type;
  String message;

  factory DashboardEvent.fromJson(Map<String, dynamic> json) => DashboardEvent(
    id: json["_id"],
    type: json["type"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "message": message,
  };
}

Future<List<Map<String, dynamic>>> getDashboardEvents() async {
  var result = MongoDatabase.getData(DASHBOARDEVENT_COLLECTION);
  return result;
}

Future<void> createDashboardEvent(DashboardEvent dashboardEvent) async {
  var response = await MongoDatabase.createData(dashboardEvent.toJson(), DASHBOARDEVENT_COLLECTION);
}
