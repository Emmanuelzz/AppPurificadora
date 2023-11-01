import '/flutterflow/flutter_flow_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pci_proyect/Views/Clientes/Modals/cliente_editar.dart';
import 'package:pci_proyect/Views/Clientes/Modals/cliente_registrar.dart';
import 'package:pci_proyect/Models/cliente.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_AppBar.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_drawer.dart';

class ClientScreenWidget extends StatefulWidget {
  const ClientScreenWidget({Key? key}) : super(key: key);

  @override
  _ClientScreenWidgetState createState() => _ClientScreenWidgetState();
}

class _ClientScreenWidgetState extends State<ClientScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

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
      floatingActionButton: FloatingActionButton(
        onPressed: _showModalRegistrarCliente,
        backgroundColor: Color(0xFF54C1FF),
        elevation: 8,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 24,
        ),
      ),
      drawer: CustomDrawer(),
      appBar: CustomAppBar(title: 'Clientes', scaffoldKey: scaffoldKey),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cliente').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('No hay informacion');

        final clientes = snapshot.data!.docs;
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: clientes.length,
          itemBuilder: (context, index) {
            final ds = clientes[index];
            return _buildListItem(context, ds);
          },
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot ds) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: FlutterFlowTheme.of(context).secondaryBackground,
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () => _showModalEditarCliente(context, ds),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // <- Alinea a la izquierda
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0), // <- Agrega un espacio
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 70,
                ),
              ),
              Expanded(
                // <- Toma todo el espacio restante
                child: Text(
                  ds["Nombre"] + " " + ds["Apellido"],
                  style: FlutterFlowTheme.of(context).bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModalRegistrarCliente() async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: const ModalRegistrarClientes(),
        ),
      ),
    );
  }

  void _showModalEditarCliente(
      BuildContext context, DocumentSnapshot ds) async {
    final clienteActual = Cliente(
      id: ds.id,
      nombre: ds["Nombre"] ?? "",
      apellido: ds["Apellido"] ?? "",
      calle: ds["Calle"] ?? "",
      codigoPostal: ds["CodigoPostal"] ?? "",
      colonia: ds['Colonia'] ?? "",
      numeroDeCasa: ds['NumeroDeCasa'] ?? "",
      numeroDeRuta: ds['NumeroDeRuta'] ?? "",
    );

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: ModalEditarCliente(
            cliente: clienteActual,
          ),
        ),
      ),
    );
    setState(() {});
  }
}

Future<void> createClient({
  required String Apellido,
  required String Calle,
  required int CodigoPostal,
  required String Colonia,
  required String Nombre,
  required String NumeroDeCasa,
  required String NumeroDeRuta,
}) async {
  final docClient = FirebaseFirestore.instance.collection("cliente").doc();
  final json = {
    "Apellido": Apellido,
    "Calle": Calle,
    "CodigoPostal": CodigoPostal,
    "Colonia": Colonia,
    "Nombre": Nombre,
    "NumeroDeCasa": NumeroDeCasa,
    "NumeroDeRuta": NumeroDeRuta,
  };
  await docClient.set(json);
}
