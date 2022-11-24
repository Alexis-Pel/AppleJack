import 'package:flutter/material.dart';
import 'package:project/Models/DashboardEventModel.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const tag = "pageTwo";

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  void _changeState() {
    setState(() {
    });
  }

  // Cette methode ajoute nos evenements
  Card _addEventToDashboard(DashboardEvent data) {
      return Card(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        elevation: 20,
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(data.message),
            Text(data.type),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // List data = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      // On utilise FutureBuilder car il s'agit d'une class asyncfonne
      body: FutureBuilder(
        future: getDashboardEvents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Si nous avons de données, on ajoute les évenements
            if(snapshot.hasData) {
              var totalData = snapshot.data.length;
              return ListView.builder(
                  itemCount: totalData,
                  itemBuilder: (context, index) {
                    return _addEventToDashboard(
                        DashboardEvent.fromJson(snapshot.data[index]
                        )
                    );
                  },
              );
            } else {
              return const Text("Donnés non disponibles");
            }
          }
        },
      ),
    );
  }
}