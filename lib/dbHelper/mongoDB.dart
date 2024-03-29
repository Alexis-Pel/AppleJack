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

  static Future<Map<String, dynamic>?> getOne(Map<String, dynamic> data,String collectionString) async {
    try {
      var collection = db.collection(collectionString);
      var result = await collection.findOne(data);
      return result;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<List<Map<String, Object?>>?> getAllBy(Map<String, dynamic> data,String collectionString) async {
    try {
      var collection = db.collection(collectionString);
      var result = await collection.find(data).toList();
      return result!;
    }
    catch(e){
      print(e);
      return null;
    }
  }
  static Future<Map<String, dynamic>?> getDataOf(Map<String, dynamic> data,String collectionString) async {
    try {
      var collection = db.collection(collectionString);
      var result = await collection.find(data).toList();
      return result!;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  static Future<void> update(Map<String, dynamic> data, String id, String collectionString) async {
    try {
      var collection = db.collection(collectionString);
      var result = await collection.findOne({"_id": id});
      result = data;
      var response = await collection.save(result);
      inspect(response);
      return;
    }
    catch(e){
      print(e);
      return;
    }
  }

  static Future<void> delete(ObjectId id,String collectionString) async {

    try {
      var collection = db.collection(collectionString);
      var result = await collection.remove(where.id(id));
      var response = await collection.remove(result);
      inspect(response);
      return;
    }
    catch(e){
      print(e);
      return;
    }

  }




}