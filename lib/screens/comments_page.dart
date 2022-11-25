import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:project/Models/PartyModel.dart';
import 'package:project/screens/add_horse.dart';
import '../Models/HorseModel.dart';
import '../Models/UserModel.dart';
import '../dbHelper/globals.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyAppComments());
}

class MyAppComments extends StatelessWidget {
  static const tag = "commentsPage";
  const MyAppComments({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

     _party = ModalRoute.of(context)!.settings.arguments as Party;

    return MaterialApp(
      routes: {
        //AddHorsePage.tag: (context) => AddHorsePage(),
      },
      debugShowCheckedModeBanner: false,
      home: CommentsPage(),
    );
  }
}

late Party _party;

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  //const LoginPage({Key? key}) : super ({key: key});

  @override
  State<CommentsPage> createState() => _CommentsPage();
}

class _CommentsPage extends State<CommentsPage> {

  _CommentsPage();

  final User userlogged = userLogged!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView.builder(
              itemCount: _party.comments.length,
              itemBuilder: (context, index) {
                return CommentCard(_party.comments[index]);
              }),
        ));
  }

  Future<Party> getParty(context) async{
    var test = ModalRoute.of(context)!.settings.arguments as Party;
    return test;
  }

  getHorses() async {
    return await Horse.getHorsesOwner(userlogged.id);
  }

}

class CommentCard extends StatefulWidget {
  final Map<String, dynamic> _comment;

  CommentCard(this._comment);

  @override
  State<CommentCard> createState() => _CommentCard(this._comment);
}

class _CommentCard extends State<CommentCard> {
  final Map<String, dynamic> _comment;

  _CommentCard(this._comment);

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
            width: MediaQuery.of(context).size.width / 1.1,
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              verticalDirection: VerticalDirection.down,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    _comment['photo']!,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Column(
                          verticalDirection: VerticalDirection.down,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("${_comment['name']}", style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
                            SizedBox(height: 10,),
                            Text("${_comment['message']}", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                          ]),
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
