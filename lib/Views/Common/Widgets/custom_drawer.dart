import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter/material.dart';

import 'package:pci_proyect/Views/Clientes/Pages/cliente_informacion.dart';
import 'package:pci_proyect/Views/Common/Pages/home_screen.dart';
import 'package:pci_proyect/Views/Common/Pages/login_screen.dart';
import 'package:pci_proyect/Views/Rutas/Pages/location_view_map.dart';
import 'package:pci_proyect/Views/Rutas/Pages/route_list_screen.dart';
import 'package:pci_proyect/Views/Rutas/Pages/ruote_assigned_to_user.dart';
import 'package:pci_proyect/Views/Repartidores/Pages/repartidor_informacion.dart';

class CustomDrawer extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: "Menú",
      width: MediaQuery.of(context).size.width * .7,
      elevation: 16,
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePageWidget(),
                ),
              );
            },
          ),
          if (auth.currentUser!.email == "eduardogp2203@gmail.com")
          ListTile(
            leading: const Icon(Icons.person_sharp),
            title: const Text('Repartidores'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenSellerWidget(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_alt),
            title: const Text('Clientes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ClientScreenWidget(),
                ),
              );
            },
          ),
          if (auth.currentUser!.email == "eduardogp2203@gmail.com")
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text('Posiciones'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationViewMap(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: const Text('Rutas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RouteListScreenWidget(),
                ),
              );
            },
          ),
          if (auth.currentUser!.email == "eduardogp2203@gmail.com")
          ListTile(
            leading: const Icon(Icons.assignment_turned_in_outlined),
            title: const Text('Asignar Rutas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AssignRouteScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              FlutterFireUIAuth.signOut(context: context).then((_) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                );
              });
            },
          ),

        ],
      ),
    );
  }
}
