import 'package:flutter/material.dart';
import 'package:project/screens/calendar_page.dart';
import 'package:project/screens/concours_page.dart';
import 'package:project/screens/course_page.dart';
import 'package:project/screens/soiree_page.dart';
import '../dbHelper/mongoDB.dart';
import 'package:project/screens/dashboard.dart';
import 'package:project/screens/profil_page.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});
  static const tag = "Home";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppleJack',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.deepPurple,
      ),

      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                // Home
                Tab(
                    icon: Icon(Icons.home),
                    child: Text(
                      style:
                          TextStyle(fontSize: 9, fontFamily: 'Poppins'),
                      "Actualité",
                      maxLines: 1,
                    )),

                //Parties
                Tab(
                    icon: Icon(Icons.local_fire_department),
                    child: Text(
                      style:
                          TextStyle(fontSize: 9, fontFamily: 'Poppins'),
                      "Soirée",
                      maxLines: 1,
                    )),

                //Concours
                Tab(
                    icon: Icon(Icons.sports_score),
                    child: Text(
                      style:
                          TextStyle(fontSize: 9, fontFamily: 'Poppins'),
                      "Concours",
                      maxLines: 1,
                    )),

                //Courses
                Tab(
                  icon: Icon(Icons.calendar_month_outlined),
                  child: Text(
                    style:
                      TextStyle(fontSize: 9, fontFamily: 'Poppins'),
                    "Cours",
                    maxLines: 1,
                  ),
                ),

                //Profile
                Tab(
                  icon: Icon(Icons.account_circle),
                  child: Text(
                    style: TextStyle(fontSize: 9, fontFamily: 'Poppins'),
                    "Profil",
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            title: const Text('APPLEJACK',
              style: TextStyle(fontSize: 24,fontFamily: 'Poppins'),
            ),

          ),
          body: const TabBarView(
            children: [
              Dashboard(),
              PartyPage(),
              ContestPage(),
              MyAppCalendar(),
              ProfilPage(),
            ],
          ),
        ),
      ),
    );
  }
}
