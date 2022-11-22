import 'package:flutter/material.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({Key? key}) : super(key: key);

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: const [
          Text("Insert Data"),
          SizedBox(height: 50,),
          TextField(
              decoration: InputDecoration(labelText: "First Name")
          ),
        ],
      )
      ),
    );
  }
}
