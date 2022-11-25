import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;

import '../Models/UserModel.dart';
import '../dbHelper/globals.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyAppUser());
}

class MyAppUser extends StatelessWidget {
  const MyAppUser({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      routes: {

      },
      debugShowCheckedModeBanner: false,
      home: UserPage(),
    );
  }
}

class UserPage extends StatefulWidget {
  static const tag = "UserPage";

  const UserPage({super.key});

  //const LoginPage({Key? key}) : super ({key: key});

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  _UserPage();

  final User userlogged = userLogged!;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Les cavaliers"),
        ),
        body: Center(
            child: FutureBuilder(
                future: User.getUsers(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      var totalData = snapshot.data.length;
                      print("Total Data : $totalData");
                      return ListView.builder(
                          itemCount: totalData,
                          itemBuilder: (context, index) {
                            return UserCard(
                                User.fromJson(snapshot.data[index]));
                          });
                    } else {
                      return const Center(child: Text("No Data Disponible"));
                    }
                  }
                })),

    );
  }

  getUsers() async {
    return await User.getUsers();
  }
}

class UserCard extends StatefulWidget{
  final User _user;

  UserCard(this._user);

  @override
  State<UserCard> createState() => _UserCard(this._user);

}

class _UserCard extends State<UserCard>{
  final User _user;
  _UserCard(this._user);

/*  Image.network(
  'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
  width: 280.0,
  )*/

  @override
  Widget build(BuildContext context) {
    return Card(
      //Set color
      color: Colors.blueAccent,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width/1.1,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              verticalDirection: VerticalDirection.down,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      /*TextButton(
                        onPressed: () async {
                          await joinLeaveCourse(_course);
                        },
                        child: _icon),*/
                      Column(
                          verticalDirection: VerticalDirection.down,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Username: ${_user.username}"),
                            Text("Age: ${_user.age}"),
                            Text("Email: ${_user.mail}"),
                            Text("Role: ${_user.role}"),
                            Text("Tel: ${_user.tel}"),
                          ]),
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    _user.picture,
                                  ), fit: BoxFit.cover)
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }

}
