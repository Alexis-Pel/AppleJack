import 'package:flutter/material.dart';
import 'package:project/Models/CompetitionModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import '../Models/HorseModel.dart';
import '../Models/UserModel.dart';
import '../dbHelper/globals.dart';
import 'contest_page.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyAppHorse());
}

class MyAppHorse extends StatelessWidget {
  const MyAppHorse({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HorsePage(),
    );
  }
}

class HorsePage extends StatefulWidget {
  static const tag = "horsePage";

  const HorsePage({super.key});

  //const LoginPage({Key? key}) : super ({key: key});

  @override
  State<HorsePage> createState() => _HorsePage();
}

class _HorsePage extends State<HorsePage> {
  _HorsePage();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Chevaux"),
      ),
      body: Center(
          child: FutureBuilder(
              future: getHorses(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    var totalData = snapshot.data.length;
                    print("Total Data : $totalData");
                    return ListView.builder(
                        itemCount: totalData,
                        itemBuilder: (context, index) {
                          return HorseCard(
                              Horse.fromJson(snapshot.data[index]));
                        });
                  } else {
                    return const Center(child: Text("No Data Disponible"));
                  }
                }
              })),
    );
  }

  getHorses() async {
    await Horse.getHorses();
  }
}

class HorseCard extends StatefulWidget{
  final Horse _horse;

  HorseCard(this._horse);

  @override
  State<HorseCard> createState() => _HorseCard(this._horse);

}

class _HorseCard extends State<HorseCard>{
  final Horse _horse;
  _HorseCard(this._horse);

  final User userlogged = userLogged!;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        //Set color
        color: Colors.blueAccent,
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
                    /*TextButton(
                        onPressed: () async {
                          await joinLeaveCourse(_course);
                        },
                        child: _icon),*/
                    Column(
                        verticalDirection: VerticalDirection.down,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Nom: ${_horse.name}"),
                          Text("Age: ${_horse.age}"),
                          Text("Espèce: ${_horse.breed}"),
                          Text("Robe: ${_horse.coat}"),
                          Text("Specialité: ${_horse.speciality}"),
                        ])
                  ]),
            ],
          ),
        ),
      ),
    );
  }

}
