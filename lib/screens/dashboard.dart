import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const tag = "pageTwo";

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    // List data = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      body: Text('Dashboard'),
    );
    throw UnimplementedError();
  }
}