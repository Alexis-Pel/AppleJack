import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:project/screens/dashboard.dart';


void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await MongoDatabase.connect();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Applejack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add_chart),),
                Tab(icon: Icon(Icons.add_circle),),
                Tab(icon: Icon(Icons.add_box_outlined)),
                Tab(icon: Icon(Icons.add)),
                Tab(icon: Icon(Icons.add_circle_outline))
              ],
            ),
            title: const Text('Applejack'),
          ),
          body: TabBarView(
            children: [
              Dashboard(),
              Dashboard(),
              Dashboard(),
              Dashboard(),
              Dashboard(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class  _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}

