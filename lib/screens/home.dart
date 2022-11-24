import 'package:flutter/material.dart';
import 'package:project/screens/calendar_page.dart';
import 'package:project/screens/concours_page.dart';
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
        primarySwatch: Colors.deepPurple,
      ),
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add_chart),),
                Tab(icon: Icon(Icons.add_circle),),
                Tab(icon: Icon(Icons.add_box_outlined)),
                Tab(icon: Icon(Icons.add)),
                Tab(icon: Icon(Icons.add_circle_outline)),
                Tab(icon: Icon(Icons.calendar_month_outlined), child:Text(style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),"Cours", maxLines: 1,),)
              ],
            ),
            title: const Text('Applejack'),
          ),
          body: const TabBarView(
            children: [
              Dashboard(),
              CoursePage(),
              PartyPage(),
              ContestPage(),
              Dashboard(),
              MyAppCalendar(),
            ],
          ),
        ),
      ),
    );
  }
}

