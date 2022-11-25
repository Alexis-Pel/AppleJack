import 'package:flutter/material.dart';
import 'package:project/Models/PartyModel.dart';
import 'package:project/screens/party_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;

import '../dbHelper/globals.dart';
import 'comments_page.dart';

void main() async {
  runApp(const PartyCalendar());
}

var _partyCards = [];

class PartyCalendar extends StatelessWidget {
  const PartyCalendar({super.key});
  static const tag = "partyCalendar";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        s_Page.tag: (context) => const s_Page(),
        MyAppComments.tag: (context) => MyAppComments(),
      },
      debugShowCheckedModeBanner: false,
      home: PartyCalendarPage(),
    );
  }
}

class CalendarCard extends StatefulWidget {
  final Party _party;
  CalendarCard(this._party);

  @override
  State<StatefulWidget> createState() => _CalendarCard(this._party);
}

class _CalendarCard extends State<CalendarCard> {
  _CalendarCard(this._party);
  final Party _party;
  final m.ObjectId _id = userLogged!.id;
  Icon _icon = const Icon(Icons.add, size: 40, color: Colors.white,);

  Future<void> joinLeaveParty(Party party) async {
    if (party.participant.contains(_id)) {
      party.participant.remove(_id);
    } else {
      party.participant.add(_id);
    }
    await updateCourse(party.toJson(), party.id.toString());
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

  MaterialColor setPartyCardColor() {
    if(_party.participant.contains(_id)) {
      _icon = const Icon(Icons.exit_to_app_outlined, size: 40,);
      return Colors.amber;
    } else {
      _icon = const Icon(Icons.add, size: 40, color: Colors.white,);
      return Colors.teal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
     child: Card(
       color: setPartyCardColor(),
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
               children: [
                 Image.network(
                     _party.picture,
                     height: 90,
                     width: 120,
                     fit: BoxFit.fill
                 ),
                 TextButton(
                     onPressed: () async {
                       await joinLeaveParty(_party);
                     },
                     child: _icon
                 ),
                 Column(
                   verticalDirection: VerticalDirection.down,
                   mainAxisSize: MainAxisSize.min,
                   children: <Widget>[
                     const SizedBox(height: 5),
                     Text(
                       "${_party.date.day}/${_party.date.month}/${_party.date.year} à ${_party.date.hour}:${_party.date.minute}"
                     ),
                     const SizedBox(height: 5),
                     Text("Type de soirée : ${_party.theme}"),
                     const SizedBox(height: 5),
                     Text("${_party.comment}"),
                     const SizedBox(height: 5),
                     TextButton(onPressed: () async {
                       setState(() async {
                         await Navigator.pushNamed(context, MyAppComments.tag, arguments: _party) as Party;
                       });
                     }, child: const Text("Détails", style: TextStyle(color: Colors.white),))
                   ],
                 )
               ],
             )
           ],
         ),
       ),
     ),
    );
  }
}

class PartyCalendarPage extends StatefulWidget {
  const PartyCalendarPage({super.key});

  //const LoginPage({Key? key}) : super ({key: key});

  @override
  State<StatefulWidget> createState() => _PartyCalendarPageState();
}

class _PartyCalendarPageState extends State<PartyCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getWeekParties(),
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
                          Party.fromJson(snapshot.data[index])
                      );
                    });
              } else {
                return const Center(
                  child: Text("Données non disponibles"),
                );
              }
            }
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, s_Page.tag)
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
      ),
    );
  }
}
