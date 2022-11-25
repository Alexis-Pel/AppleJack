import 'package:flutter/material.dart';
import 'package:project/Models/DashboardEventModel.dart';
import 'package:project/screens/login_page.dart';
import '../Models/UserModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;

class AddUserPage extends StatefulWidget {
  static const tag = "AddUserPage";
  //const LoginPage({super.key});
  //const LoginPage({Key? key}) : super ({key: key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  //controller
  final _nameController = TextEditingController();
  final _telController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  final _linkController = TextEditingController();
  final _imageController = TextEditingController();
  final _id= m.ObjectId();
  final role = 0;

  //String _role = Role.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/images/appleJackLogo.png"),
                ),
                const SizedBox(height: 10),

                //Connecte toi !
                const Text(
                  'Créer un compte',
                  style: TextStyle(fontSize: 35, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 5),
                const Text(
                  'BIENVENUE SUR APPLEJACK',
                  style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 20),
                //Tel
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _telController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Téléphone',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                //Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Email',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                //Username
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Username',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                //Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                //Age
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Age',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _imageController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Profil Picture',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                TextButton(
                  onPressed: () {
                   User.createUsers((User(
                       id: _id,
                       tel: _telController.text,
                       mail: _emailController.text,
                       username: _usernameController.text,
                       password: _passwordController.text,
                       age: _ageController.text,
                       link: _linkController.text ,
                       picture: _imageController.text,
                       role: 0))
                   );
                   createDashboardEvent(DashboardEvent(
                       id: m.ObjectId(),
                       type: _usernameController.text,
                       message: 'Un nouveau utilisateur à rejoint Applejack !',
                   ));
                  },
                  child:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child:Text(
                            'Créer un compte',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> register() async {
    if(_emailController.text.contains("@") && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _telController.text.isNotEmpty && _usernameController.text.isNotEmpty && _ageController.text.isNotEmpty && _linkController.text.isNotEmpty && _imageController.text.isNotEmpty) {
      // Register User to Database

      var result =  User.createUsers((User(id: _id, tel: _telController.text, mail: _emailController.text, username: _usernameController.text, password: _passwordController.text, age: _ageController.text, link: "" , picture: "https://avatars.githubusercontent.com/u/77855537?v=4", role: 0)));
      //Register Sucessfull
      AfterRegister();
    }
    else{
      // Formulaire incomplet
      var snackBar = SnackBar(
        content: const Text('Inscription incomplete'),
        action: SnackBarAction(
          label: 'Fermer',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }

  void AfterRegister() {
    Navigator.pushNamed(context, LoginPage.tag);
  }

}
