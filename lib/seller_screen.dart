import '/flutterflow/flutter_flow_icon_button.dart';
import '/flutterflow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import 'package:pci_proyect/seller_register.dart';
import 'package:pci_proyect/seller_info.dart';

class SellerScreenWidget extends StatefulWidget {
  const SellerScreenWidget({Key? key}) : super(key: key);

  @override
  _SellerScreenWidgetState createState() => _SellerScreenWidgetState();
}

class _SellerScreenWidgetState extends State<SellerScreenWidget> {

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
//COmentario XDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDdd
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)
                => const SellerRegisterWidget()
                )
            );
          },
          backgroundColor: const Color(0xFF54C1FF),
          elevation: 8,
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 24,
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
              'Vendedores',
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
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async{
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)
                            => const SellerInfoWidget()
                            )
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
                          children: const [
                            Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 70,
                            ),
                            Text(
                              'Nombre del Vendedor',
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
      ),
    );
  }
}
