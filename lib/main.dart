import 'package:flutter/material.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/login_page.dart';
import 'dbHelper/mongoDB.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const tag = "main";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Home.tag: (context) => Home(),
        MyApp.tag: (context) => const MyApp()
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}