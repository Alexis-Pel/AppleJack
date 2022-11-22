import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:project/dbHelper/constant.dart';


class MongoDatabase{
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
    /* Inserez une data dans la database InsertMany pour plusieurs d'un coup
    await userCollection.insertOne(
      {
        "id" : 1,
        "username":"mp",
        "name":"Max",
        "email":"email"
      }
    ); */
  }

}