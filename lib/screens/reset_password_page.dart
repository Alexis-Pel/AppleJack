import 'package:flutter/material.dart';
import 'package:project/screens/add_user.dart';
import 'package:project/screens/reset_password_page.dart';
import '../Models/UserModel.dart';
import '../dbHelper/globals.dart';
import 'home.dart';

import 'package:flutter/material.dart';
import '../Models/UserModel.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  static const tag = "ResetPassword";
  @override
  State<ResetPassword> createState() => _ResetPasswordState();

}

class _ResetPasswordState extends State<ResetPassword> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(child:Center(child:SingleChildScrollView( child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/appleJackLogo.png"),
                ),
                const SizedBox(height: 30),

                //Connecte toi !
                const Text(
                  'Reinitialise ton mot de passe ',
                  style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 10),


                TextField(
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
                const SizedBox(height: 50),
                TextField(
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
                    hintText: 'New password',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
                const SizedBox(height: 50),

                TextButton(
                  onPressed: () {
                    verifResetPassword();
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
                            'Reinitialiser le mot de passe',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      )))),
    );
  }
      void resetPasswordAfter(){
        Navigator.pushNamed(context, ResetPassword.tag);
      }
      Future<void> verifResetPassword() async{
        if(_emailController.text.contains("@") && _emailController.text.isNotEmpty) {

          var result = await User.updatePassword({"mail": _emailController.text},_passwordController.text);
          Navigator.pushNamed(context, "LoginPage");
          var snackBar = SnackBar(
            content: const Text('Changement effectué'),
            action: SnackBarAction(
              label: 'Fermer',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        }
        else{
          var snackBar = SnackBar(
            content: const Text('Email ou mot de passe incorrect'),
            action: SnackBarAction(
              label: 'Fermer',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        };

    }
  }



