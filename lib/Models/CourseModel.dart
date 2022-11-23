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

  //Constructor
  Course(this._date, this._duration, this._terrain, this._discipline, this._id);

  // Getters
  String get terrain => _terrain;

  String get discipline => _discipline;

  DateTime get date => _date;

  int get duration => _duration;

  //Map from Json
  factory Course.fromJson(Map<String, dynamic> json) => Course(json['date'],
      json['duration'], json['terrain'], json['discipline'], json['_id']);

  //Convert to json
  Map<String, dynamic> toJson() => {
        "_id": _id,
        "date": _date,
        "duration": _duration,
        "terrain": _terrain,
        "discipline": _discipline,
      };
}

Future<List<Map<String, dynamic>>> getCourses() async {
  var result = MongoDatabase.getData(COURSE_COLLECTION);
  return result;
}

Future<void> createCourse(Course course) async {
  var response = await MongoDatabase.createData(course.toJson(), COURSE_COLLECTION);
}
