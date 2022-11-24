import 'package:flutter/material.dart';
import 'package:project/Models/CompetitionModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;

import 'concours_page.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyAppConcours());
}

class MyAppConcours extends StatelessWidget {
  const MyAppConcours({super.key});

  static const tag = "add_concours";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ContestPage.tag: (context) => const ContestPage(),
      },
      debugShowCheckedModeBanner: false,
      home: AddConcoursPage(),
    );
  }
}

class AddConcoursPage extends StatefulWidget {
  static const tag = "ConcoursPage";

  const AddConcoursPage({super.key});

  //const LoginPage({Key? key}) : super ({key: key});

  @override
  State<AddConcoursPage> createState() => _AddConcoursPage();
}

class _AddConcoursPage extends State<AddConcoursPage> {
  _AddConcoursPage();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    DateTime _date = DateTime.now();
    final pictureController = TextEditingController();
    final adressController = TextEditingController();

    //Set Date and Hour to variables
    void setDate(hour, date) {
      if (hour != null && date != null) {
        _date =
            DateTime(date.year, date.month, date.day, hour.hour, hour.minute);
      }
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un concours"),
      ),
      body: Center(
          child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 2,
        child: Form(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 60),
            //Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Nom',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),

            SizedBox(height: 20),
            //Adress
            TextField(
              controller: adressController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Adresse',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),

            SizedBox(height: 20),
            //Picture
            TextField(
              controller: pictureController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Lien image',
                fillColor: Colors.grey[200],
                filled: true,
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
                      ),
                    ],
                  )),
            ),
            TextButton(
                onPressed: () async {
                  try {
                    if (nameController.text.isNotEmpty &&
                        adressController.text.isNotEmpty &&
                        pictureController.text.isNotEmpty) {
                      Competition toSend = Competition(
                        id: m.ObjectId(),
                        name: nameController.text,
                        adress: adressController.text,
                        picture: pictureController.text,
                        date: _date,
                        amateur: [],
                        club1: [],
                        club2: [],
                        club3: [],
                        club4: [],
                      );
                      await Competition.createCompetition(toSend)
                          .then((value) => setState(() {
                                //Display snackbar
                                var snackBar = SnackBar(
                                  content: const Text('Concours ajouté'),
                                  action: SnackBarAction(
                                    label: 'Close',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pushNamed(context, ContestPage.tag);
                              }));
                    }
                  } catch (e) {
                    print(e);
                  }
                  //sendCourse(Course(_date, _duration, _terrain, _discipline, m.ObjectId(), []));
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text("Send")),
            TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, ContestPage.tag);
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text("Annuler"))
          ],
        )),
      )),
    );
  }
}
