// ignore_for_file: non_constant_identifier_names

import '/flutterflow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

export 'modal_seller_widget.dart';

late String types;

class ModalSellerRegWidget extends StatefulWidget {
  const ModalSellerRegWidget({Key? key,}) : super(key: key);


  @override
  _ModalSellerRegWidgetState createState() => _ModalSellerRegWidgetState();
}

class _ModalSellerRegWidgetState extends State<ModalSellerRegWidget> {
  final apellidoControlador = TextEditingController();
  final nombreControlador = TextEditingController();
  final correoControlador = TextEditingController();

  Future registrar() async
  {
    final docUser= FirebaseFirestore.instance.collection('usuario').doc();
    final json={
      'Apellido':apellidoControlador.text,
      'Nombre':nombreControlador.text,
      'correo':correoControlador.text
    };
    await docUser.set(json);
  }

  @override
  void dispose() {
    //_model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .35,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBtnText,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: TextFormField(
                controller: nombreControlador,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: ' ',
                  hintStyle: FlutterFlowTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF001C30),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
                // validator: _model.textController1Validator.asValidator(context),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: TextFormField(
                controller: apellidoControlador,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  hintText: ' ',
                  hintStyle: FlutterFlowTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF001C30),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
                // validator: _model.textController1Validator.asValidator(context),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: TextFormField(
                controller: correoControlador,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Fulanito@gmail.com',
                  hintStyle: FlutterFlowTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF001C30),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
                //validator: _model.textController2Validator.asValidator(context),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    registrar();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 130,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: Text("Guardar"),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 130,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: const Center(
                      child: Text("Cancelar"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


