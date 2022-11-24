import 'package:mongo_dart/mongo_dart.dart';

import '../dbHelper/constant.dart';
import '../dbHelper/mongoDB.dart';

enum Terrain { carriere, manege }

enum Discipline { dressage, saut_obstacle, endurance }

class Course {
  //Variables
  ObjectId _id;
  String _terrain;
  String _discipline;
  DateTime _date;
  int _duration;
  List<dynamic> _participants;

   //Constructor

  Course(this._date, this._duration, this._terrain, this._discipline, this._id, this._participants);

  // Getters
  String get terrain => _terrain;

  String get discipline => _discipline;

  DateTime get date => _date;

  int get duration => _duration;

  List<dynamic> get participants => _participants;

  ObjectId get id => _id;

  //Map from Json
  factory Course.fromJson(Map<String, dynamic> json) => Course(json['date'],
      json['duration'], json['terrain'], json['discipline'], json['_id'], json['participants']);

  //Convert to json
  Map<String, dynamic> toJson() => {
        "_id": _id,
        "date": _date,
        "duration": _duration,
        "terrain": _terrain,
        "discipline": _discipline,
        "participants": _participants
      };
}

Future<List<Map<String, dynamic>>> getCourses() async {
  var result = MongoDatabase.getData(COURSE_COLLECTION);
  return result;
}

Future<void> createCourse(Course course) async {
  var response = await MongoDatabase.createData(course.toJson(), COURSE_COLLECTION);
}

Future<void> updateCourse(Map<String, dynamic> data, String id) async {;
  MongoDatabase.update(data, id, COURSE_COLLECTION);
}

Future<List<Map<String, Object?>>?> getWeekCourses() async {
  var today = DateTime.now();
  var aadays = (today.day - (today.day - today.weekday + 1));
  var aaaa = Duration(days: aadays, hours: today.hour, minutes: today.minute);
  var bbbb = Duration(days: 6 - aadays);


  var before = today.subtract(aaaa);
  var after = today.add(bbbb);

  var result = await MongoDatabase.getAllBy({"date": {r"$gte": before, r"$lt": after}}, COURSE_COLLECTION);

  return result;
}
