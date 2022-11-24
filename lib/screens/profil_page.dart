

import 'package:flutter/material.dart';
import 'package:project/dbHelper/globals.dart';

final _nameController = TextEditingController();
var _telController = TextEditingController();
var _emailController = TextEditingController();
var _usernameController = TextEditingController();
var _passwordController = TextEditingController();
var _ageController = TextEditingController();
var _linkController = TextEditingController();
var _imageController = TextEditingController();




class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      _telController.text = userLogged!.tel;
      _emailController.text = userLogged!.mail;
      _usernameController.text = userLogged!.username;
      _passwordController.text = userLogged!.password;
      _ageController.text = userLogged!.age;
      _linkController.text = userLogged!.link;
      _imageController.text = userLogged!.picture;
    });
    return Scaffold(

      body: Container(
        padding: EdgeInsets.only(left: 15,top: 20,right: 15),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Colors.white
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.deepPurple.withOpacity(0.1),

                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("https://media.istockphoto.com/id/1386479313/fr/photo/heureuse-femme-daffaires-afro-am%C3%A9ricaine-mill%C3%A9naire-posant-isol%C3%A9e-sur-du-blanc.jpg?s=612x612&w=is&k=20&c=k1GZ5uX3tp-AEqmgF1zvBeqSQIaIrqxKWjaNGTXTWqI="),
                          fit: BoxFit.cover,
                      ),
                    )),

                  ],
                ),
              ),
              SizedBox(height: 30),
              buildTextField(),

            ],
          ),
        ),
      ),
    );
  }
  Widget buildTextField(){
   return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          // Username
          TextField(
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
          const SizedBox(height: 7),
          // Email
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
          const SizedBox(height: 7),
          // Password
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
              hintText: 'Password',
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
          // Tel
          const SizedBox(height: 7),
          TextField(
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
              hintText: 'Tel',
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
          const SizedBox(height: 7),
          // Age
          TextField(
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
          const SizedBox(height: 7),
          // link FFE
          TextField(
            controller: _linkController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Link FFE',
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
          const SizedBox(height: 7),
          // profil Picture
          TextField(
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
              hintText: 'Link Profil Picture',
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
          const SizedBox(height: 7),
          TextButton(

            onPressed: () {
              ;
            },
            child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child:Text(
                      'Mettre à jour le profil',
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
      )

    );
  }
}
