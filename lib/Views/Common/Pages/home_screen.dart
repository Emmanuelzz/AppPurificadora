import 'package:firebase_auth/firebase_auth.dart';

import '/flutterflow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import 'package:pci_proyect/Views/Common/Widgets/menu_item.dart';
import 'package:pci_proyect/Utils/my_colors.dart';



import 'package:pci_proyect/Views/Clientes/Pages/cliente_informacion.dart';
import 'package:pci_proyect/Views/Rutas/Pages/route_list_screen.dart';
import 'package:pci_proyect/Views/Rutas/Pages/ruote_assigned_to_user.dart';
import 'package:pci_proyect/Views/Rutas/Pages/location_view_map.dart';
import 'package:pci_proyect/Views/Repartidores/Pages/repartidor_informacion.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_AppBar.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_drawer.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: CustomDrawer(),
        appBar: CustomAppBar(title: 'Home', scaffoldKey: scaffoldKey),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                if (auth.currentUser!.email == "eduardogp2203@gmail.com")
                  MenuItemWidget(
                    icon: Icons.person_sharp,
                    title: 'Repartidores',
                    color: MyColors.trueBlue, // Updated color
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenSellerWidget(),
                        ),
                      );
                    },
                  ),
                MenuItemWidget(
                  icon: Icons.people_alt,
                  title: 'Clientes',
                  color: MyColors.truePurple, // Updated color
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClientScreenWidget(),
                      ),
                    );
                  },
                ),
                if (auth.currentUser!.email == "eduardogp2203@gmail.com")
                MenuItemWidget(
                  icon: Icons.location_on_outlined,
                  title: 'Posiciones',
                  color: MyColors.trueEmerald, // Updated color
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationViewMap(),
                      ),
                    );
                  },
                ),
                MenuItemWidget(
                  icon: Icons.map_outlined,
                  title: 'Rutas',
                  color: MyColors.trueOrangeAccent, // Updated color
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RouteListScreenWidget(),
                      ),
                    );
                  },
                ),
                if (auth.currentUser!.email == "eduardogp2203@gmail.com")
                MenuItemWidget(
                  icon: Icons.assignment_turned_in_outlined,
                  title: 'Asignar Rutas',
                  color: MyColors.trueTeal, // Updated color
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AssignRouteScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
