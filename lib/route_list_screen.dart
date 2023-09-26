import '/flutterflow/flutter_flow_icon_button.dart';
import '/flutterflow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pci_proyect/client_screen_per_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class RouteListScreenWidget extends StatefulWidget {
  const RouteListScreenWidget({Key? key}) : super(key: key);

  @override
  _RouteListScreenWidgetState createState() => _RouteListScreenWidgetState();
}

class _RouteListScreenWidgetState extends State<RouteListScreenWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  // Variable de instancia para almacenar los nombres de ruta únicos
  final Set<String> nombresRutaUnicos = Set<String>();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
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
        appBar: AppBar(
          backgroundColor: const Color(0xFF001C30),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title: const Align(
            alignment: AlignmentDirectional(1, 0),
            child: Text(
              'Rutas',
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('cliente').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    final List<Widget> cards = [];

                    for (final doc in docs) {
                      final numeroDeRuta = doc.get('NumeroDeRuta') as String;

                      // Verificar si el nombre de ruta ya se ha agregado antes
                      if (!nombresRutaUnicos.contains(numeroDeRuta)) {
                        // Agregar el nombre de ruta al conjunto de nombres únicos
                        nombresRutaUnicos.add(numeroDeRuta);

                        // Crear la card y agregarla a la lista de cards
                        //Implementar codigo para cuando se agregue una card, agregar una coleccion
                        //en la BD para tener un registro de estas.
                        cards.add(
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClientScreenPerRouteWidget(ruta: numeroDeRuta),
                                  ),
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.route,
                                      color: Colors.black,
                                      size: 70,
                                    ),
                                    Text(numeroDeRuta),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    return ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: cards,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}