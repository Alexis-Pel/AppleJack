import 'package:flutter/material.dart';

import 'course.dart';

void main() async {
  runApp(const CoursePage());
}

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Add Course',
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _Page();
}

class _Page extends State<Page> {
  //Define Variables
  String _terrain = Terrain.carriere.name;
  String _discipline = Discipline.dressage.name;
  DateTime _date = DateTime(2022, 1, 1, 0, 0, 0);
  int _duration = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un cours"),
      ),
      body: Center(
          child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 2,
        child: Form(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //Terrain Radio
            Column(
              children: [
                Text("Veuillez choisir un Terrain"),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Carrière'),
                      leading: Radio<String>(
                        value: Terrain.carriere.name,
                        groupValue: _terrain,
                        onChanged: (String? value) {
                          setState(() {
                            _terrain = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Manège'),
                      leading: Radio<String>(
                        value: Terrain.manege.name,
                        groupValue: _terrain,
                        onChanged: (String? value) {
                          setState(() {
                            _terrain = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Discipline radio
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  const Text("Veuillez choisir une discipline"),
                  Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Dressage'),
                        leading: Radio<String>(
                          value: Discipline.dressage.name,
                          groupValue: _discipline,
                          onChanged: (String? value) {
                            setState(() {
                              _discipline = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Endurance'),
                        leading: Radio<String>(
                          value: Discipline.endurance.name,
                          groupValue: _discipline,
                          onChanged: (String? value) {
                            setState(() {
                              _discipline = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text("Saut d'obstacle"),
                        leading: Radio<String>(
                          value: Discipline.saut_obstacle.name,
                          groupValue: _discipline,
                          onChanged: (String? value) {
                            setState(() {
                              _discipline = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Date Picker
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: TextButton(
                  onPressed: showDate,
                  child: Column(
                    children: [
                      const Text("Selectionner la date"),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Text(
                            "${_date.day}/${_date.month}/${_date.year} à ${_date.hour}:${_date.minute}"),
                      ),
                    ],
                  )),
            ),

            //Duration
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('30 minutes'),
                    leading: Radio<int>(
                      value: 30,
                      groupValue: _duration,
                      onChanged: (int? value) {
                        setState(() {
                          _duration = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('1 heure'),
                    leading: Radio<int>(
                      value: 60,
                      groupValue: _duration,
                      onChanged: (int? value) {
                        setState(() {
                          _duration = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  sendCourse(Course(_date, _duration, _terrain, _discipline));
                  setState(() {
                    //_cards = result;
                  });
                },
                child: Text("Send"))
          ],
        )),
      )),
    );
  }

  //Set Date and Hour to variables
  void setDate(hour, date) {
    if (hour != null && date != null) {
      setState(() {
        _date =
            DateTime(date.year, date.month, date.day, hour.hour, hour.minute);
      });
    }
  }

  void sendCourse(Course course) {

    //
    //SEND COURSE TO DATABASE
    //

    //Display snackbar
    var snackBar = SnackBar(
      content: const Text('Cours ajouté'),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //Show Date and Hour Picker
  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    ).then((date) =>
        showTimePicker(initialTime: TimeOfDay.now(), context: context)
            .then((hour) => setDate(hour, date)));
  }
}
