import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:project/dbHelper/constant.dart';


class MongoDatabase{
  static var db;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
  }

  static Future<List<Map<String,dynamic>>> getData(String collectionString) async{
    var collection = db.collection(collectionString);
    final arrayData= await collection.find().toList();
    return arrayData;
  }

  static Future<String> createData(Map<String, dynamic> data,String collectionString) async {
    try {
      var collection = db.collection(collectionString);
      var result = await collection.insertOne(data);
      return "ok";
    }
    catch(e){
      print(e.toString());
      return e.toString();
    }
  }




}