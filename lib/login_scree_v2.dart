import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pci_proyect/home_page_users.dart';

import 'dart:io' show Platform;

import 'package:pci_proyect/home_screen.dart';

class LoginScreenV2 extends StatelessWidget {
  const LoginScreenV2({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    TextEditingController userController = TextEditingController();
    TextEditingController paswordController = TextEditingController();

    return GestureDetector(
      onTap: (){
        //FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.black),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: const[
                    Padding(
                      padding:  EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          "Ondinas",
                          textScaleFactor: 2.6,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "has rutas de entrega",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesomeIcons.userAlt,
                          color: const Color(0xFF0797AF),
                          size: MediaQuery.of(context).size.width
                              / MediaQuery.of(context).size.height * 80 ,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFDAFAFF),
                              border: Border.all(color: Colors.black)
                          ),
                          width: MediaQuery.of(context).size.width * .78,
                          height: MediaQuery.of(context).size.height * .055,
                          child: CupertinoTextField(
                            controller: userController,
                            prefix: const Text(" Correo:"),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesomeIcons.unlockAlt,
                          color: const Color(0xFF0797AF),
                          size: MediaQuery.of(context).size.width
                              / MediaQuery.of(context).size.height * 80 ,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFDAFAFF),
                              border: Border.all(color: Colors.black)
                          ),
                          width: MediaQuery.of(context).size.width * .78,
                          height: MediaQuery.of(context).size.height * .055,
                          child: CupertinoTextField(
                            controller: paswordController,
                            obscureText: true,
                            prefix: const Text(" Contraseña:"),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async{
                          signInEmailPassword(
                            userController.text,
                            paswordController.text,
                          ).then((value) => {
                            if(value.toString().split("(")[0]== "User"){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirebaseAuth.instance
                                        .currentUser!.email != "minuediaz31@gmail.com"
                                        ? const HomePageWidget()
                                        : const HomePageUser(),
                                  )
                              ),
                            } else{
                              print("Error: $value"),
                            }
                          }
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .04,
                          width: MediaQuery.of(context).size.width * .23,
                          decoration: const BoxDecoration(
                              color: Color(0xFF0797AF),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)
                              )
                          ),
                          child: const Center(
                            child: Text(
                              "Ingresar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Future signInEmailPassword(String email, String password) async {
  try {
    UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    User? user = result.user;
    return user;
  } catch (e) {
    return e;
  }
}