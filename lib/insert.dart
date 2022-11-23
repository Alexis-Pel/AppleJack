import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:project/Models/UserModel.dart';
import 'package:project/dbHelper/mongoDB.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({Key? key}) : super(key: key);

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fnameController = TextEditingController();
  var flastnameController = TextEditingController();
  var fadressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children:  [
          const Text("Insert Data"),
          const SizedBox(height: 50),
           TextField(
              controller: fnameController,
              decoration: InputDecoration(labelText: "First Name")
          ),
           TextField(
              controller: flastnameController,
              decoration: InputDecoration(labelText: "Last Name")
          ),
           TextField(
              controller: fadressController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(labelText: "Address")
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              OutlinedButton(onPressed: (){
                _FakeData();
              }, child: const Text("generate data")),
              ElevatedButton(onPressed: () {
                _insertData(fnameController.text,flastnameController.text,fadressController.text);
              }, child: const Text("insert data"))
            ],
          ),
        ],
      )
      ),
    );
  }

  Future<void> _insertData(String name,String lName,String address)async {
  var _id= m.ObjectId();// permet d'avoir un id unique
  final data = User(id: _id, firstName: name, lastName: lName, address: address);
  User.createUsers(data);
  ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("ID Inseré : ${_id.$oid}")));
  _clearAll();
  }

  void _clearAll(){
    fnameController.text="";
    flastnameController.text="";
    fadressController.text="";
  }

 void _FakeData(){
  setState(() {
    fnameController.text = faker.person.firstName();
    flastnameController.text = faker.person.lastName();
    fadressController.text=faker.address.streetAddress();
  });
}
}