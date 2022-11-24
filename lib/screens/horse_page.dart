import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:project/screens/add_horse.dart';
import '../Models/HorseModel.dart';
import '../Models/UserModel.dart';
import '../dbHelper/globals.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyAppHorse());
}

class MyAppHorse extends StatelessWidget {
  const MyAppHorse({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AddHorsePage.tag: (context) => AddHorsePage(),
      },
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

  final User userlogged = userLogged!;

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
        floatingActionButton: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, AddHorsePage.tag)
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
        )
    );
  }

  getHorses() async {
    return await Horse.getHorsesOwner(userlogged.id);
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

/*  Image.network(
  'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
  width: 280.0,
  )*/

  @override
  Widget build(BuildContext context) {
    return Card(
        //Set color
        color: Colors.blueAccent,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/1.1,
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
                            ]),
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      _horse.photo,
                                    ), fit: BoxFit.cover)
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            )
          ],
        ),
    );
  }

}
