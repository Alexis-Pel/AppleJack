import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:project/screens/course_page.dart';
import '../Models/CourseModel.dart';
import '../dbHelper/globals.dart';

void main() async {
  runApp(const MyAppCalendar());
}

var _cards = [];

class MyAppCalendar extends StatelessWidget {
  const MyAppCalendar({super.key});
  static const tag = "Calendar";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        c_Page.tag: (context) => const c_Page(),
      },
      debugShowCheckedModeBanner: false,
      home: CalendarPage(),
    );
  }
}

class CalendarCard extends StatefulWidget {
  final Course _course;
  CalendarCard(this._course);

  @override
  State<CalendarCard> createState() => _CalendarCard(this._course);
}

class _CalendarCard extends State<CalendarCard> {
  _CalendarCard(this._course);
  final Course _course;
  final m.ObjectId _id = userLogged!.id;
  Icon _icon = const Icon(Icons.add, size: 40);

  Future<void> joinLeaveCourse(Course course) async {
    if (course.participants.contains(_id)) {
      course.participants.remove(_id);
    } else {
      course.participants.add(_id);
    }
    await updateCourse(course.toJson(), course.id.toString());
    //Display snackbar
    var snackBar = SnackBar(
      content: const Text('Participation prise en compte'),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Color textColor = Colors.black;

  Color setPerso() {
    if (_course.participants.contains(_id)) {
      _icon = const Icon(Icons.exit_to_app_outlined, size: 40);
      textColor = Colors.white;
      return Colors.deepPurple;
    } else {
      _icon = const Icon(Icons.add, size: 40);
      textColor = Colors.black;
      return Colors.white;
    }
  }
  TextButton adminButton(){
    if(userLogged!.role==1){
      return TextButton(

          onPressed: () {

        Course.deleteCourse(this._course.id).then((_) => setState(() {}));
      }, child: Icon(Icons.remove,color: Colors.deepPurple,));
    }
    return TextButton(
        onPressed: () async {
          await joinLeaveCourse(_course);
        },
        child: _icon
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        //Set color
        color: setPerso(),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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

                    adminButton(),
                    Column(
                        verticalDirection: VerticalDirection.down,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "${_course.date.day}/${_course.date.month}/${_course.date.year} à ${_course.date.hour}:${_course.date.minute}",
                            style: TextStyle(color: textColor,fontWeight: FontWeight.w500),
                          ),
                          Text("Terrain: ${_course.terrain}",
                              style: TextStyle(color: textColor,fontWeight: FontWeight.w500)),
                          Text("Discipline: ${_course.discipline}",
                              style: TextStyle(color: textColor,fontWeight: FontWeight.w500)),
                          Text("Durée: ${_course.duration} minutes",
                              style: TextStyle(color: textColor,fontWeight: FontWeight.w500))
                        ])
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  //const LoginPage({Key? key}) : super ({key: key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: getWeekCourses(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      var totalData = snapshot.data.length;
                      return ListView.builder(
                          itemCount: totalData,
                          itemBuilder: (context, index) {
                            return CalendarCard(
                                Course.fromJson(snapshot.data[index]));
                          });
                    } else {
                      return const Center(child: Text("No Data Disponible"));
                    }
                  }
                })),
        //Add button
        floatingActionButton: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, c_Page.tag)
                .then((value) => setState(() {}));
          },
          style: ElevatedButton.styleFrom(
            elevation: 10,
            shadowColor: Colors.black,
            backgroundColor: Colors.deepPurple,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15),
          ),
          child: const Icon(Icons.add),
        ));
  }
}
