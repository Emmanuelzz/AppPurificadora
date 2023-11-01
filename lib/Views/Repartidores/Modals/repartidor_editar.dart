import '/flutterflow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pci_proyect/Models/repartidor.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_text_form_field.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_modal_title.dart';

final _formKey = GlobalKey<FormState>();

class ModalEditarRepartidor extends StatefulWidget {
    final Repartidor repartidor;
    final String type;

    const ModalEditarRepartidor({
        Key? key,
        required this.repartidor,
        required this.type,
    }) : super(key: key);

    @override
    _ModalEditarRepartidorState createState() => _ModalEditarRepartidorState();
}

class _ModalEditarRepartidorState extends State<ModalEditarRepartidor> {
    TextEditingController apellidoControlador = TextEditingController();
    TextEditingController nombreControlador = TextEditingController();
    TextEditingController correoControlador = TextEditingController();

    @override
    void initState() {
        apellidoControlador.text = widget.repartidor.apellido;
        nombreControlador.text = widget.repartidor.nombre;
        correoControlador.text = widget.repartidor.correo;
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
            height: MediaQuery.of(context).size.height * .35,
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
                            CustomAppBar(title: 'Editar repartidor'),
                            CustomTextFormField(controller: nombreControlador, labelText: 'Nombre', hintText: ' ', maxLength: 50),
                            CustomTextFormField(controller: apellidoControlador, labelText: 'Apellidos', hintText: ' ', maxLength: 50),
                            CustomTextFormField(controller: correoControlador, labelText: 'Email', hintText: 'Fulanito@gmail.com', enabled: false),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end, // Alinea a la derecha
                                children: [
                                    ElevatedButton(
                                        onPressed: () {
                                            if (_formKey.currentState!.validate()) { // Validar el formulario
                                                editSeller(widget.repartidor.id, apellidoControlador.text, nombreControlador.text, correoControlador.text);
                                                Navigator.pop(context);
                                            }
                                        },
                                        child: const Text("Guardar"),
                                    ),
                                    const SizedBox(width: 16), // Añade espacio entre los botones
                                    ElevatedButton(
                                        onPressed: () {
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            deleteSeller(widget.repartidor.id);
                                            Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(primary: Colors.red),
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