import 'package:flutter/material.dart';
import 'package:project/Models/PartyModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
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
  // Define variables
  final _formKey = GlobalKey<FormState>();
  String theme = ThemeParty.apero.name;
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
                sendParty(Party( m.ObjectId(), theme, partyImageController.text, [], partyMessageController.text));
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
}