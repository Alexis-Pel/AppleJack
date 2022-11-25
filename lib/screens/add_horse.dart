import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:project/Models/DashboardEventModel.dart';
import 'package:project/dbHelper/globals.dart';
import 'package:project/screens/horse_page.dart';

import '../Models/HorseModel.dart';

class AddHorsePage extends StatefulWidget {
  static const tag = "AddHorsePage";
  //const LoginPage({super.key});
  //const LoginPage({Key? key}) : super ({key: key});

  @override
  State<AddHorsePage> createState() => _AddHorsePageState();
}

class _AddHorsePageState extends State<AddHorsePage> {
  final nameController = TextEditingController();
  final photoController = TextEditingController();
  final coatController = TextEditingController();
  final breedController = TextEditingController();
  final genderController = TextEditingController();
  final specialityController = TextEditingController();
  final stable = "";
  final owner = userLogged!.id;
  final DP = [];

  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter un cheval"),
        ),
        body: SingleChildScrollView(
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
                controller: photoController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "URL de l'image",
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),

              SizedBox(height: 20),
              //Picture
              TextField(
                controller: coatController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Robe',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Age",
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              //Breed
              TextField(
                controller: breedController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Race',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              //gender
              TextField(
                controller: genderController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Genre',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              //speciality
              TextField(
                controller: specialityController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Specialité',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                  onPressed: () async {
                    try {
                      if (nameController.text.isNotEmpty &&
                          photoController.text.isNotEmpty &&
                          breedController.text.isNotEmpty &&
                          ageController.text.isNotEmpty &&
                          coatController.text.isNotEmpty &&
                          genderController.text.isNotEmpty &&
                          specialityController.text.isNotEmpty) {
                        Horse horse = Horse(
                          id: m.ObjectId(),
                          photo: photoController.text,
                          name: nameController.text,
                          age: ageController.text,
                          coat: coatController.text,
                          breed: breedController.text,
                          gender: genderController.text,
                          speciality: specialityController.text,
                          owner: owner,
                          stable: stable,
                          dp: DP,
                        );

                        createDashboardEvent(DashboardEvent(
                          id: m.ObjectId(),
                          type: breedController.text,
                          message: "Un utilisateur vient d'ajouter un nouveau cheval"
                        ));

                        await Horse.createHorse(horse).then((value) =>
                            Navigator.pushNamed(context, HorsePage.tag));
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
                    Navigator.pushNamed(context, HorsePage.tag);
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
        ));
  }
}
