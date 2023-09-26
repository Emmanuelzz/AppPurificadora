// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pci_proyect/client_screen.dart';

import '/flutterflow/flutter_flow_icon_button.dart';
import '/flutterflow/flutter_flow_theme.dart';
import '/flutterflow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:pci_proyect/route_list_screen.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({Key? key}) : super(key: key);

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: Drawer(
        semanticLabel: "Menú",
        width: MediaQuery.of(context).size.width * .7,
        elevation: 16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                FlutterFireUIAuth.signOut(
                  context: context,
                );
              },
              child: Container(
                width: 130,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Text("Log Out"),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF001C30),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: const Icon(
            Icons.menu,
            color: Color(0xFF00B2EB),
            size: 30,
          ),
          onPressed: () async {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Align(
          alignment: const AlignmentDirectional(1, 0),
          child: Text(
            'Inicio',
            textAlign: TextAlign.end,
            style: FlutterFlowTheme.of(context).title2.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
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
                Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 15, 5, 15),
                    child: InkWell(
                      onTap: () async{
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context)
                        => const ClientScreenWidget()
                        ));
                      },
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD9D9D9),
                              ),
                              child: const Icon(
                                Icons.people_alt,
                                color: Colors.black,
                                size: 100,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Color(0xFFBDFF00),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                child: Text(
                                  'Clientes',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 15, 5, 15),
                  child: InkWell(
                    onTap: () async{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RouteListScreenWidget()));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                            ),
                            child: const Icon(
                              Icons.map_outlined,
                              color: Colors.black,
                              size: 100,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                              child: Text(
                                'Rutas',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
