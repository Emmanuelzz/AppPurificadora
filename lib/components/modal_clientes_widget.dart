import '/flutterflow/flutter_flow_theme.dart';
import '/flutterflow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pci_proyect/client_screen_model.dart';

late String types;

class ModalClientesWidget extends StatefulWidget {
  const ModalClientesWidget({
    Key? key,

    required this.Apellido,
    required this.Nombre,
    required this.Calle,
    required this.CodigoPostal,
    required this.Colonia,
    required this.GarrafonesSolicitados,
    required this.NumeroDeCasa,
    required this.NumeroDeRuta,
    required this.type,
    required this.id,
  }) : super(key: key);
  final String Apellido;
  final String Nombre;
  final String Calle;
  final int CodigoPostal;
  final String Colonia;
  final String GarrafonesSolicitados;
  final String NumeroDeCasa;
  final String NumeroDeRuta;
  final String type;
  final String id;

  @override
  _ModalClientesWidgetState createState() => _ModalClientesWidgetState(
      Apellido,
      Nombre,
      Calle,
      CodigoPostal,
      Colonia,
      GarrafonesSolicitados,
      NumeroDeCasa,
      NumeroDeRuta,
      type,
      id);
}

class _ModalClientesWidgetState extends State<ModalClientesWidget> {
  late String Apellido;
  late String Nombre;
  late String Calle;
  late int CodigoPostal;
  late String Colonia;
  late String GarrafonesSolicitados;
  late String NumeroDeCasa;
  late String NumeroDeRuta;
  late String type;
  late String id;
  TextEditingController apellidoControlador = TextEditingController();
  TextEditingController nombreControlador = TextEditingController();
  TextEditingController calleControlador = TextEditingController();
  TextEditingController codigoPostalControlador = TextEditingController();
  TextEditingController coloniaControlador = TextEditingController();
  TextEditingController garrafonesSolicitadosControlador = TextEditingController();
  TextEditingController numeroDeCasaControlador = TextEditingController();
  TextEditingController numeroDeRutaControlador = TextEditingController();

  final _unfocusNode = FocusNode();

  _ModalClientesWidgetState(
      this.Apellido,
      this.Nombre,
      this.Calle,
      this.CodigoPostal,
      this.Colonia,
      this.GarrafonesSolicitados,
      this.NumeroDeCasa,
      this.NumeroDeRuta,
      this.type,
      this.id);

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    Apellido = widget.Apellido;
    Nombre = widget.Nombre;
    Calle = widget.Calle;
    CodigoPostal = widget.CodigoPostal;
    Colonia = widget.Colonia;
    GarrafonesSolicitados = widget.GarrafonesSolicitados;
    NumeroDeCasa = widget.NumeroDeCasa;
    NumeroDeRuta = widget.NumeroDeRuta;
    type = widget.type;
    types = type;
    id = widget.id;

    apellidoControlador.text = Apellido;
    nombreControlador.text = Nombre;
    calleControlador.text = Calle;
    codigoPostalControlador.text = CodigoPostal.toString();
    coloniaControlador.text = Colonia;
    garrafonesSolicitadosControlador.text = GarrafonesSolicitados;
    numeroDeCasaControlador.text = NumeroDeCasa;
    numeroDeRutaControlador.text = NumeroDeRuta;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .5,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBtnText,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
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
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: TextFormField(
                controller: calleControlador,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Calle',
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
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: TextFormField(
                controller: coloniaControlador,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Colonia',
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
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 10),
              child: TextFormField(
                controller: numeroDeCasaControlador,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Numero',
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
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 10),
              child: TextFormField(
                controller: codigoPostalControlador,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'CP',
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
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: TextFormField(
                controller: garrafonesSolicitadosControlador,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Garrafones solicitados',
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
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: TextFormField(
                controller: numeroDeRutaControlador,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Asignar Ruta:',
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
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    editClient(
                        apellidoControlador.text,
                        calleControlador.text,
                        int.parse(codigoPostalControlador.text),
                        coloniaControlador.text,
                        garrafonesSolicitadosControlador.text,
                        nombreControlador.text,
                        numeroDeCasaControlador.text,
                        numeroDeRutaControlador.text,
                        id);


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
                    deleteClient(id);
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

Future editClient(
    String Apellido,
    String Calle,
    int CodigoPostal,
    String Colonia,
    String GarrafonesSolicitados,
    String Nombre,
    String NumeroDeCasa,
    String NumeroDeRuta,
    String id,
    ) async {
  final docUser = FirebaseFirestore.instance.collection("cliente").doc(id);
  final json = {
    "Apellido": Apellido,
    "Calle": Calle,
    "CodigoPostal": CodigoPostal,
    "Colonia": Colonia,
    "GarrafonesSolicitados": GarrafonesSolicitados,
    "Nombre": Nombre,
    "NumeroDeCasa": NumeroDeCasa,
    "NumeroDeRuta": NumeroDeRuta,
  };
  await docUser.update(json);
}

Future deleteClient(String id) async {

  final docUser = FirebaseFirestore.instance.collection("cliente").doc(id);
  docUser.delete();
}