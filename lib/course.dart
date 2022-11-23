enum Terrain { carriere, manege }

enum Discipline { dressage, saut_obstacle, endurance }

class Course {

  //Variables
  final String _terrain;
  final String _discipline;
  final DateTime _date;
  final int _duration;

  //Constructor
  const Course(this._date, this._duration, this._terrain, this._discipline);

  // Getters
  String get terrain => _terrain;
  String get discipline => _discipline;
  DateTime get date => _date;
  int get duration => _duration;
}