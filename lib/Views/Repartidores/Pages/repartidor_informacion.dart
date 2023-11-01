import '/flutterflow/flutter_flow_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pci_proyect/Views/Repartidores/Modals/repartidor_editar.dart';
import 'package:pci_proyect/Models/repartidor.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_AppBar.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_drawer.dart';

class ScreenSellerWidget extends StatefulWidget {
  const ScreenSellerWidget({Key? key}) : super(key: key);

  @override
  _ScreenSellerWidgetState createState() => _ScreenSellerWidgetState();
}

class _ScreenSellerWidgetState extends State<ScreenSellerWidget> {
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
      drawer: CustomDrawer(),
      appBar: CustomAppBar(title: 'Repartidores', scaffoldKey: scaffoldKey),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('usuario').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('No hay informacion');

        final users = snapshot.data!.docs;
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            final ds = users[index];
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
          onTap: () => _showModalEditarRepartidor(context, ds),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,  // <- Alinea a la izquierda
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),  // <- Agrega un espacio
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 70,
                ),
              ),
              Expanded(  // <- Toma todo el espacio restante
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

  void _showModalEditarRepartidor(BuildContext context, DocumentSnapshot ds) async {
    final repartidorActual = Repartidor(
      id: ds.id,
      nombre: ds["Nombre"] ?? "",
      apellido: ds["Apellido"] ?? "",
      correo: ds["correo"] ?? "",

    );

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder( // Agregar esta línea para redondear las esquinas
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: EdgeInsets.all(10), // Margen igual en todos los lados
          child: ModalEditarRepartidor(
            repartidor: repartidorActual,
            type: "", // Puedes asignar un valor adecuado para type si es necesario.
          ),
        ),
      ),
    );
    setState(() {});
  }
}
