import 'package:pci_proyect/components/modal_clientes_reg_widget.dart';

import '/flutterflow/flutter_flow_icon_button.dart';
import '/flutterflow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pci_proyect/client_register.dart';

import 'components/modal_clientes_widget.dart';

class ClientScreenWidget extends StatefulWidget {
  const ClientScreenWidget({Key? key}) : super(key: key);

  @override
  _ClientScreenWidgetState createState() => _ClientScreenWidgetState();
}

class _ClientScreenWidgetState extends State<ClientScreenWidget> {

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(isScrollControlled: true,
              backgroundColor: Colors.transparent,
              enableDrag: false,
              context: context,
              builder: (context) {
                return Padding(
                  padding:
                  MediaQuery.of(context).viewInsets,
                  child: const ModalClientesRegWidget(),
                );
              },
            );
          },
          backgroundColor: Color(0xFF54C1FF),
          elevation: 8,
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 24,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF001C30),
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
              'ClienteS',
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('cliente').snapshots(),
            builder: (context,snapshot) {
              if (!snapshot.hasData) {
                return Text('No hay informacion');
              }
              else {
                final users = snapshot.data?.docs;
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data
                          ?.docs[index] as DocumentSnapshot<Object?>;
                      return Padding(
                        padding:const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding:
                                    MediaQuery.of(context).viewInsets,
                                    child: ModalClientesWidget(
                                      Apellido: ds["Apellido"].toString(),
                                      Calle: ds["Calle"],
                                      CodigoPostal: ds["CodigoPostal"],
                                      Colonia: ds["Colonia"],
                                      GarrafonesSolicitados: ds["GarrafonesSolicitados"] ,
                                      Nombre: ds["Nombre"].toString(),
                                      NumeroDeCasa: ds["NumeroDeCasa"].toString(),
                                      NumeroDeRuta: ds["NumeroDeRuta"].toString(),
                                      type: " ",
                                      id: ds.id.toString(),
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 70,
                                ),
                                Text(
                                  ds["Nombre"],
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
              }
            }

        ),
      ),
    );
  }
  Stream <Iterable<userClass>> readProducs()
  => FirebaseFirestore.instance
      .collection("cliente")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => userClass.fromJson(doc.data())));
}

class userClass {
  final String Apellido;
  final String Nombre;
  final String Calle;
  final int CodigoPostal;
  final String Colonia;
  final String GarrafonesSolicitados;
  final String NumeroDeCasa;
  final String NumeroDeRuta;

  userClass({
    this.Apellido = "",
    this.Nombre = "",
    this.Calle = "",
    this.CodigoPostal = 0,
    this.Colonia = "",
    this.GarrafonesSolicitados = "",
    this.NumeroDeCasa = "",
    this.NumeroDeRuta = "",
  });

  static userClass fromJson(Map <String, dynamic> json) => userClass(
    Apellido: json["Apellido"],
    Calle: json["Calle"],
    CodigoPostal: json["CodigoPostal"],
    Colonia: json["Colonia"],
    GarrafonesSolicitados: json["GarrafonesSolicitados"],
    Nombre: json["Nombre"],
    NumeroDeCasa: json["NumeroDeCasa"],
    NumeroDeRuta: json["NumeroDeRuta"],
  );
}

Future createSeller({
  required String Apellido,
  required String Calle,
  required int CodigoPostal,
  required String Colonia,
  required String GarrafonesSolicitados,
  required String Nombre,
  required String NumeroDeCasa,
  required String NumeroDeRuta,
}) async{
  final docUser = FirebaseFirestore.instance.collection("cliente").doc();
  final json = {
    "Apellido" : Apellido,
    "Calle" : Calle,
    "CodigoPostal" : CodigoPostal,
    "Colonia" : Colonia,
    "GarrafonesSolicitados" : GarrafonesSolicitados,
    "Nombre" : Nombre,
    "NumeroDeCasa" : NumeroDeCasa,
    "NumeroDeRuta" : NumeroDeRuta,
  };
  await docUser.set(json);
}