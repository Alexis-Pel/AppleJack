import 'package:flutter/material.dart';
import '../dbHelper/mongoDB.dart';
import 'course_page.dart';

void main() async {
  await MongoDatabase.connect();
  runApp(const CoursePage());
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

  @override
Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Ajouter une soirée'),
    );
  }
}