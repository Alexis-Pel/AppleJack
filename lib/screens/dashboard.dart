import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const tag = "pageTwo";

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  List dashboardEventList = [];

  void _addEventToDashboard() {
    setState(() {
      dashboardEventList.add(Card(
        color: Colors.orange,
        margin: const EdgeInsets.all(10),
        elevation: 20,
        child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // List data = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _addEventToDashboard();
              },
              icon: const Icon(Icons.add)
          )
        ],
      ),
      body: ListView.builder(
        itemCount: dashboardEventList.length,
        itemBuilder: (context, index) {
          return dashboardEventList[index];
        },
      ),
    );
    throw UnimplementedError();
  }
}