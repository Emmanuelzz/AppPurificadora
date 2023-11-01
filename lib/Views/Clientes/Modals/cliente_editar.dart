import 'package:firebase_auth/firebase_auth.dart';

import '/flutterflow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pci_proyect/Models/cliente.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_text_form_field.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_modal_title.dart';


final _formKey = GlobalKey<FormState>();

class ModalEditarCliente extends StatefulWidget {
  final Cliente cliente;

  const ModalEditarCliente({
    Key? key,
    required this.cliente,
  }) : super(key: key);

  @override
  _ModalEditarClienteState createState() => _ModalEditarClienteState();
}

class _ModalEditarClienteState extends State<ModalEditarCliente> {
  final apellidoController = TextEditingController();
  final nombreController = TextEditingController();
  final calleController = TextEditingController();
  final codigoPostalController = TextEditingController();
  final coloniaController = TextEditingController();
  final numeroDeCasaController = TextEditingController();
  final numeroDeRutaController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    apellidoController.text = widget.cliente.apellido;
    nombreController.text = widget.cliente.nombre;
    calleController.text = widget.cliente.calle;
    codigoPostalController.text = widget.cliente.codigoPostal.toString();
    coloniaController.text = widget.cliente.colonia;
    numeroDeCasaController.text = widget.cliente.numeroDeCasa;
    numeroDeRutaController.text = widget.cliente.numeroDeRuta;
    super.initState();
  }

  @override
  void dispose() {
    // Liberar los controllers
    apellidoController.dispose();
    nombreController.dispose();
    calleController.dispose();
    codigoPostalController.dispose();
    coloniaController.dispose();
    numeroDeCasaController.dispose();
    numeroDeRutaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: auth.currentUser!.email == "eduardogp2203@gmail.com"
          ? MediaQuery.of(context).size.height * .55
          : MediaQuery.of(context).size.height * .18,
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
              if (auth.currentUser!.email == "eduardogp2203@gmail.com")
              CustomAppBar(title: 'Editar cliente'),
              auth.currentUser!.email == "eduardogp2203@gmail.com" 
                  ? CustomTextFormField(controller: nombreController, labelText: 'Nombre', hintText: ' ', maxLength: 50)  
                  : Text('Nombre:' + nombreController.text),
              auth.currentUser!.email == "eduardogp2203@gmail.com"
                  ? CustomTextFormField(controller: apellidoController, labelText: 'Apellidos', hintText: ' ', maxLength: 50)
                  : Text('Apellidos:' + nombreController.text),
              auth.currentUser!.email == "eduardogp2203@gmail.com"
                  ? CustomTextFormField(controller: calleController, labelText: 'Calle', hintText: ' ', maxLength: 100)
                  : Text('Calle:' + nombreController.text),
              auth.currentUser!.email == "eduardogp2203@gmail.com"
                  ? CustomTextFormField(controller: codigoPostalController, labelText: 'Código Postal', hintText: ' ', maxLength: 5, isNumeric: true)
                  : Text('Código Postal:' + nombreController.text),
              auth.currentUser!.email == "eduardogp2203@gmail.com"
                  ? CustomTextFormField(controller: coloniaController, labelText: 'Colonia', hintText: ' ', maxLength: 100)
                  : Text('Colonia:' + nombreController.text),
              auth.currentUser!.email == "eduardogp2203@gmail.com"
                  ? CustomTextFormField(controller: numeroDeCasaController, labelText: 'Número de Casa', hintText: ' ', maxLength: 10)
                  : Text('Número de Casa:' + nombreController.text),
              auth.currentUser!.email == "eduardogp2203@gmail.com"
                  ? CustomTextFormField(controller: numeroDeRutaController, labelText: 'Número de Ruta', hintText: ' ', maxLength: 10)
                  : Text('Número de Ruta:' + nombreController.text),
              if (auth.currentUser!.email == "eduardogp2203@gmail.com")
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) { // Validar el formulario
                        editClient(
                            widget.cliente.id,
                            apellidoController.text,
                            nombreController.text,
                            calleController.text,
                            int.parse(codigoPostalController.text),
                            coloniaController.text,
                            numeroDeCasaController.text,
                            numeroDeRutaController.text
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Guardar"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      deleteClient(widget.cliente.id);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Eliminar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> editClient(
    String clientId,
    String apellido,
    String nombre,
    String calle,
    int codigoPostal,
    String colonia,
    String numeroDeCasa,
    String numeroDeRuta
    ) async {
  final docRef = FirebaseFirestore.instance.collection('cliente').doc(clientId);
  final updatedData = {
    'Nombre': nombre,
    'Apellido': apellido,
    'Calle': calle,
    'CodigoPostal': codigoPostal,
    'Colonia': colonia,
    'NumeroDeCasa': numeroDeCasa,
    'NumeroDeRuta': numeroDeRuta,
  };
  await docRef.update(updatedData);
}

Future<void> deleteClient(String id) async {
  final docClient = FirebaseFirestore.instance.collection("cliente").doc(id);
  docClient.delete();
}
