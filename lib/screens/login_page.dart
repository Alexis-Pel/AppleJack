import 'package:flutter/material.dart';
import 'package:project/screens/add_user.dart';
import '../Models/UserModel.dart';
import '../dbHelper/globals.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  //const LoginPage({Key? key}) : super ({key: key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/images/appleJackLogo.png"),
                ),
                const SizedBox(height: 30),

                //Connecte toi !
                const Text(
                  'Connecte toi',
                  style: TextStyle(fontSize: 45, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'BIENVENUE SUR APPLEJACK',
                  style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 50),

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
                const SizedBox(height: 10),

                //Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
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
                const SizedBox(height: 30),

                TextButton(
                  onPressed: () {
                    login();
                  },
                  child:
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70.0),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                              child:Text(
                              'Je me connecte',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                              ),
                            ),
                          )),
                        ),
                ),
                const SizedBox(height: 50),

                TextButton(
                  onPressed: () {
                    addUser();
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

  Future<void> login() async {
    if(_emailController.text.contains("@") && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      // Get user by mail and password
      var result = await User.getOneUser({"mail": _emailController.text, "password": _passwordController.text});
      //User connected
      try{
        User user = User.fromJson(result!);
        userLogged = user;
        goToHome();
      }
      // Email or Password incorrect
      catch(e){
        var snackBar = SnackBar(
          content: const Text('Email ou mot de passe incorrect'),
          action: SnackBarAction(
            label: 'Fermer',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void addUser() {
    Navigator.pushNamed(context, AddUserPage.tag);
  }

  void goToHome() {
    Navigator.pushNamed(context, Home.tag);
  }
}
