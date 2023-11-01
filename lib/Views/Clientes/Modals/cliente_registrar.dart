import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '/flutterflow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pci_proyect/Models/cliente.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_text_form_field.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_modal_title.dart';

final _formKey = GlobalKey<FormState>();

class ModalRegistrarClientes extends StatefulWidget {
  const ModalRegistrarClientes({
    Key? key,
  }) : super(key: key);

  @override
  _ModalRegistrarClientesState createState() => _ModalRegistrarClientesState();
}

class _ModalRegistrarClientesState extends State<ModalRegistrarClientes> {
  final apellidoControlador = TextEditingController();
  final nombreControlador = TextEditingController();
  final calleControlador = TextEditingController();
  final codigoPostalControlador = TextEditingController();
  final coloniaControlador = TextEditingController();
  final numeroDeCasaControlador = TextEditingController();
  final numeroDeRutaControlador = TextEditingController();

  Future registrar() async {
    final address =
        '${calleControlador.text} ${numeroDeCasaControlador.text}, ${coloniaControlador.text}, ${codigoPostalControlador.text}, San Luis, S.L.P.';
    final GeoPoint geoPoint = await geocodeAddress(address);

    final cliente = Cliente(
      id: '',
      apellido: apellidoControlador.text,
      calle: calleControlador.text,
      codigoPostal: int.parse(codigoPostalControlador.text),
      colonia: coloniaControlador.text,
      nombre: nombreControlador.text,
      numeroDeCasa: numeroDeCasaControlador.text,
      numeroDeRuta: numeroDeRutaControlador.text,
      geoPoint: geoPoint,
    );
    final docUser = FirebaseFirestore.instance.collection('cliente').doc();
    await docUser.set(cliente.toJson());
  }

  @override
  void dispose() {
    apellidoControlador.dispose();
    nombreControlador.dispose();
    calleControlador.dispose();
    codigoPostalControlador.dispose();
    coloniaControlador.dispose();
    numeroDeCasaControlador.dispose();
    numeroDeRutaControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .55,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBtnText,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
        child: Form(
          key: _formKey, // Añadido para el formulario
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              CustomAppBar(title: 'Registrar cliente'),
              CustomTextFormField(
                  controller: nombreControlador,
                  labelText: 'Nombre',
                  hintText: ' ',
                  maxLength: 50),
              CustomTextFormField(
                  controller: apellidoControlador,
                  labelText: 'Apellidos',
                  hintText: ' ',
                  maxLength: 50),
              CustomTextFormField(
                  controller: calleControlador,
                  labelText: 'Calle',
                  hintText: ' ',
                  maxLength: 100),
              CustomTextFormField(
                  controller: codigoPostalControlador,
                  labelText: 'Código Postal',
                  hintText: ' ',
                  maxLength: 5,
                  isNumeric: true),
              CustomTextFormField(
                  controller: coloniaControlador,
                  labelText: 'Colonia',
                  hintText: ' ',
                  maxLength: 100),
              CustomTextFormField(
                  controller: numeroDeCasaControlador,
                  labelText: 'Número de Casa',
                  hintText: ' ',
                  maxLength: 10),
              CustomTextFormField(
                  controller: numeroDeRutaControlador,
                  labelText: 'Número de Ruta',
                  hintText: ' ',
                  maxLength: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Validar el formulario
                        registrar();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Guardar"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Cancelar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<GeoPoint> geocodeAddress(String address) async {
    print('entro al geocoder');
    const apiKey =
        'AIzaSyDYuPy7FZ3RSZtpP2hpbglG9fSFeLPDvDs'; // Replace with your Google Geocoding API key
    final encodedAddress = Uri.encodeComponent(address);
    print(encodedAddress);
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final result = data['results'][0];
        print(result);
        final location = result['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        return GeoPoint(lat, lng);
      } else {
        throw Exception('Geocoding failed: ${data['status']}');
      }
    } else {
      throw Exception('Geocoding request failed');
    }
  }
}
