import 'package:pci_proyect/Views/Common/Widgets/custom_AppBar.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_drawer.dart';
import 'package:pci_proyect/utils/singleton.dart';

import '/flutterflow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pci_proyect/Views/Rutas/Pages/client_screen_per_route.dart';

class RouteListScreenWidget extends StatefulWidget {
  const RouteListScreenWidget({Key? key}) : super(key: key);

  @override
  _RouteListScreenWidgetState createState() => _RouteListScreenWidgetState();
}

class _RouteListScreenWidgetState extends State<RouteListScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final Set<String> nombresRutaUnicos = Set<String>();
  Singleton singleton = Singleton();
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
        appBar: CustomAppBar(title: 'Rutas', scaffoldKey: scaffoldKey),
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
                stream: FirebaseFirestore.instance
                    .collection('cliente')
                    .snapshots(),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 20, 10),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                //Se guarda la viarble para pasarla como parametro
                                singleton.selectRoute = numeroDeRuta;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ClientScreenPerRouteWidget(
                                            ruta: numeroDeRuta),
                                  ),
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(
                                          12.0), // Agrega margen alrededor del ícono
                                      child: FaIcon(
                                        FontAwesomeIcons.route,
                                        color: Colors.black,
                                        size: 50, // Hazlo un poco más pequeño
                                      ),
                                    ),
                                    Expanded(
                                      // <- Toma todo el espacio restante
                                      child: Text(
                                        numeroDeRuta,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
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
