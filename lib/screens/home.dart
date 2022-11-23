import 'package:flutter/material.dart';
import 'package:project/screens/course_page.dart';
import 'package:project/screens/soiree_page.dart';
import '../dbHelper/mongoDB.dart';
import 'package:project/screens/dashboard.dart';


void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp( const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});
  static const tag = "Home";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Applejack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add_chart),),
                Tab(icon: Icon(Icons.add_circle),),
                Tab(icon: Icon(Icons.add_box_outlined)),
                Tab(icon: Icon(Icons.add)),
                Tab(icon: Icon(Icons.add_circle_outline))
              ],
            ),
            title: const Text('Applejack'),
          ),
          body: TabBarView(
            children: [
              Dashboard(),
              CoursePage(),
              PartyPage(),
              Dashboard(),
              Dashboard(),
            ],
          ),
        ),
      ),
    );
  }
}

