// ignore_for_file: non_constant_identifier_names

import '/flutterflow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

export 'modal_seller_widget.dart';

late String types;

class ModalSellerWidget extends StatefulWidget {
  const ModalSellerWidget({
    Key? key,
    required this.Apellido,
    required this.Nombre,
    required this.Correo,
    required this.type,
    required this.id,
  }) : super(key: key);
  final String Apellido;
  final String Nombre;
  final String Correo;
  final String type;
  final String id;

  @override
  _ModalSellerWidgetState createState() =>
      _ModalSellerWidgetState(Apellido, Nombre, Correo, type, id);
}

class _ModalSellerWidgetState extends State<ModalSellerWidget> {
  late String Apellido;
  late String Nombre;
  late String Correo;
  late String type;
  late String id;
  TextEditingController apellidoControlador = TextEditingController();
  TextEditingController nombreControlador = TextEditingController();
  TextEditingController correoControlador = TextEditingController();

  _ModalSellerWidgetState(this.Apellido, this.Nombre, this.Correo, this.type, this.id);

  @override
  void initState() {
    Apellido = widget.Apellido;
    Nombre = widget.Nombre;
    Correo = widget.Correo;
    print(Apellido);
    type = widget.type;
    types = type;
    id = widget.id;

    apellidoControlador.text = Apellido;
    nombreControlador.text = Nombre;
    correoControlador.text = Correo;
    super.initState();
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
                    editSeller(id, apellidoControlador.text, nombreControlador.text, correoControlador.text);
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
                    deleteSeller(id);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 130,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: const Center(
                      child: Text("Eliminar"),
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

Future editSeller(String userId, String nApellido, String nNombre, String newCorreo) async {
  final docRef = FirebaseFirestore.instance.collection('usuario').doc(userId);

  final updatedData = {
    'Apellido': nApellido,
    'Nombre': nNombre,
    'correo': newCorreo,
  };
  await docRef.update(updatedData);
}

Future deleteSeller(String id) async {

  final docUser = FirebaseFirestore.instance.collection("usuario").doc(id);
  docUser.delete();
}
