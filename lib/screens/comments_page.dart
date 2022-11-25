import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:project/Models/PartyModel.dart';
import 'package:project/screens/add_horse.dart';
import 'package:project/screens/party_calendar_page.dart';
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
        PartyCalendar.tag: (context) => PartyCalendar(),
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
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            SizedBox(
              height: 90,
              child: TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, PartyCalendar.tag);
                },
                child: Text("Retour", style: TextStyle(color: Colors.blue)),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: MediaQuery.of(context).size.height/1.20,
              child:ListView.builder(
                  itemCount: _party.comments!.length,
                  itemBuilder: (context, index) {
                    return CommentCard(_party.comments[index]);
                  }),
            )
          ],
        )
      ),
      floatingActionButton: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width/10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Envoyer un message',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: ElevatedButton(
                onPressed: () async {
                  sendComment(_commentController.text);
                  _commentController.text = "";
                },
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shadowColor: Colors.black,
                  backgroundColor: Colors.deepPurple,
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.send)),
          )
        ],
      ),
    );
  }

  Future<Party> getParty(context) async {
    var test = ModalRoute.of(context)!.settings.arguments as Party;
    return test;
  }

  getHorses() async {
    return await Horse.getHorsesOwner(userlogged.id);
  }

  void sendComment(String text) {
    setState(() {
      if (text.isNotEmpty){
        var message = {"message": text, "name": userlogged.username, "photo": userlogged.picture};
        _party.comments.add(message);
        updateCourse(_party.toJson(), _party.id.toString());
      }
    });
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
      color: Colors.white,
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
                            Text(
                              "${_comment['name']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.deepPurple),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("${_comment['message']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.deepPurple)),
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
