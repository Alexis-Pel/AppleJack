import 'package:flutter/material.dart';
import 'package:project/Models/PartyModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:project/screens/party_calendar_page.dart';
import '../dbHelper/mongoDB.dart';

void main() async {
  await MongoDatabase.connect();
  runApp(const PartyPage());
}

class PartyPage extends StatelessWidget {
  const PartyPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Add Party',
      home: s_Page(),
    );
  }
}

class s_Page extends StatefulWidget {
  const s_Page({Key? key}) : super(key: key);
  static const tag = "party_page";

  @override
  State<s_Page> createState() => _Page();
}

class _Page extends State<s_Page> {
  // Define variables
  final _formKey = GlobalKey<FormState>();
  String theme = ThemeParty.apero.name;
  DateTime date = DateTime(2022, 1, 1, 0, 0, 0);
  TextEditingController partyMessageController = TextEditingController();
  TextEditingController partyImageController = TextEditingController();

  @override
Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Ajouter une soirée à thème'),
      ),
      body: SingleChildScrollView(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Veuillez choisir un type de soirée :"),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text("Apèro"),
                leading: Radio<String>(
                  value: ThemeParty.apero.name,
                  groupValue: theme,
                  onChanged: (String? value) {
                    setState(() {
                      theme = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Repas"),
                leading: Radio<String>(
                  value: ThemeParty.repas.name,
                  groupValue: theme,
                  onChanged: (String? value) {
                    setState(() {
                      theme = value!;
                    });
                },
                ),
              ),
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
                              "${date.day}/${date.month}/${date.year} à ${date.hour}:${date.minute}"),
                        ),
                      ],
                    )),
              ),
              Form(
                key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: partyMessageController,
                        decoration: const InputDecoration(
                            labelText: 'Ajouter un message pour indiquer ce que vous comptez apporter'
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: partyImageController,
                        decoration: const InputDecoration(
                            labelText: "Ajoutez l'url d'une image de votre soirée à thème"
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ],
                  )
              )
            ],
          ),
          TextButton(
              onPressed: () {
                sendParty(Party( m.ObjectId(), theme, partyImageController.text, [], partyMessageController.text, date));
              }, 
              child: const Text('Send')
          )
        ],
      ),
      ),
    );
  }
  
  // Here we create a new party event
  void sendParty(Party party) {
    createParty(party);
    
    var snackBar = SnackBar(
        content: const Text('Soirée à thème ajouté'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void setDate(hour, date) {
    if (hour != null && date != null) {
      setState(() {
        date = DateTime(date.year, date.month, date.day, hour.hour, hour.minute);
      });
    }
  }

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