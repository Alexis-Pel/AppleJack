import 'package:flutter/material.dart';
import 'package:project/screens/add_concours.dart';
import '../Models/CompetitionModel.dart';
import 'course_page.dart';

void main() async {
  runApp(const CoursePage());
}

class ContestPage extends StatelessWidget {
  const ContestPage({super.key});
  static const tag = "contestPage";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MyAppConcours.tag: (context) => const MyAppConcours(),
      },
      title: 'Add Contest',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: setCompetitions(),
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
                            return ConcourCard(Competition.fromJson(snapshot.data[index]));
                          });
                    } else {
                      return const Center(child: Text("No Data Disponible"));
                    }
                  }
                })),

        //Add button
        floatingActionButton: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, MyAppConcours.tag)
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

  setCompetitions() async{
    return await Competition.getCompetitions();

  }
}

class ConcourCard extends StatefulWidget{
  final Competition competition;

  const ConcourCard(this.competition, {super.key});

  @override
  State<ConcourCard> createState() => _ConcourCard(competition);
}

class _ConcourCard extends State<ConcourCard>{
  final Competition competition;

  _ConcourCard(this.competition);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        //Set color
        color: Colors.deepPurple,
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
                    Column(
                        verticalDirection: VerticalDirection.down,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "${competition.date.day}/${competition.date.month}/${competition.date.year} à ${competition.date.hour}:${competition.date.minute}",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                          ),
                          Text("Nom: ${competition.name}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                          Text("Adresse: ${competition.adress}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                        ])
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}