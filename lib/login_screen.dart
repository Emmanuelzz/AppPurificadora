import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter/material.dart';
import 'package:pci_proyect/home_page_users.dart';

import 'dart:io' show Platform;

import 'package:pci_proyect/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
              headerBuilder: (context, constraints, _) {
                return Image.asset(
                    "assets/LogoOrdinas.jpg"
                );
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
                //const AppleProviderConfiguration(),
                //Platform.isAndroid
                //    ? const GoogleProviderConfiguration(
                //    clientId:
                //    "625007570364-5hjnpv5cb8o1hh6e7lmusokf0re2ko3s.apps.googleusercontent.com")
                //    : const GoogleProviderConfiguration(
                //    clientId:
                //    "457091133693-bkraq4oqmlsfbsaksb3djm1dq9ra58f9.apps.googleusercontent.com"),
              ]);
        }
        return FirebaseAuth.instance
            .currentUser!.email == "eduardogp2203@gmail.com"
            ? const HomePageWidget()
            : const HomePageUser();
      },
    );
  }
}