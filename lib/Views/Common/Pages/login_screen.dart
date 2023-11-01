import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter/material.dart';
import 'package:pci_proyect/Views/Common/Modals/complete_registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pci_proyect/Views/Common/Pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void _showCompleteRegistrationModal(User user) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Hace que el modal no pueda ser desestimado al hacer click fuera de él
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: CompleteRegistrationModal(user: user),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          User user = snapshot.data!;

          // Comprueba si el usuario ya está en Firestore
          FirebaseFirestore.instance.collection('usuario').doc(user.uid).get().then((doc) {
            if (!doc.exists) {
              // Si el usuario no está en Firestore, muestra el modal para completar registro
              _showCompleteRegistrationModal(user);
            }
          });

          // Navega a la página principal dependiendo del email del usuario
          return user.email == "eduardogp2203@gmail.com"
              ? const HomePageWidget()
              : const HomePageWidget();

        } else {
          return SignInScreen(
              headerBuilder: (context, constraints, _) {
                return Image.asset("assets/LogoOndinaS.jpg");
              },
              subtitleBuilder: (context, action) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Welcome to our app Please sign in to continue.",
                  ),
                );
              },
              providerConfigs: const [
                EmailProviderConfiguration(),
                // ... otros proveedores de autenticación ...
              ]);
        }
      },
    );
  }
}
