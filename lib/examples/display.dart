/*
import 'package:flutter/material.dart';
import 'package:project/Models/UserModel.dart';
import 'package:project/dbHelper/mongoDB.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({Key? key}) : super(key: key);

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      FutureBuilder(
          future: User.getUsers(),
          builder: (context,AsyncSnapshot snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child:
            CircularProgressIndicator(),

            );
        }else {
          if(snapshot.hasData){

            var totalData = snapshot.data.length;
            print("Total Data : $totalData");
            return ListView.builder(itemCount: totalData,itemBuilder: (context,index){

              return displayCard(User.fromJson(snapshot.data[index]));
            });
          }else{
            return Center(child: Text("No Data Disponible"));
          }
        }

      })
      ),
    );
  }
  Widget displayCard(User data) {
    return Card(
      child: Column(
        children: [
          Text('${data.id}'),
          const SizedBox(height: 5),
          Text(data.firstName),
          const SizedBox(height: 5),
          Text(data.lastName),
          const SizedBox(height: 5),
          Text(data.mail),
          const SizedBox(height: 5),
          Text(data.password),
        ],
      ),
    );
  }
}
*/
