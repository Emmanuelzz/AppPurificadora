import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pci_proyect/Models/repartidor.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_text_form_field.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_modal_title.dart';
import '/flutterflow/flutter_flow_theme.dart';

final _formKey = GlobalKey<FormState>();

class CompleteRegistrationModal extends StatefulWidget {
  final User user;

  CompleteRegistrationModal({required this.user});

  @override
  _CompleteRegistrationModalState createState() => _CompleteRegistrationModalState();
}

class _CompleteRegistrationModalState extends State<CompleteRegistrationModal> {
  final apellidoControlador = TextEditingController();
  final nombreControlador = TextEditingController();

  Future<void> registrar() async {
    final repartidor = Repartidor(
      id: widget.user.uid,
      nombre: nombreControlador.text,
      apellido: apellidoControlador.text,
      correo: widget.user.email!,
    );

    await FirebaseFirestore.instance.collection('usuario').doc(widget.user.uid).set(repartidor.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBtnText,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomAppBar(title: 'Registrar repartidor'),
                CustomTextFormField(controller: nombreControlador, labelText: 'Nombre', hintText: ' ', maxLength: 50),
                CustomTextFormField(controller: apellidoControlador, labelText: 'Apellidos', hintText: ' ', maxLength: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registrar();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Guardar"),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    apellidoControlador.dispose();
    nombreControlador.dispose();
    super.dispose();
  }
}