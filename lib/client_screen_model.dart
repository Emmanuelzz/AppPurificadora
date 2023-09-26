import '/components/modal_clientes_widget.dart';
import '/flutterflow/flutter_flow_icon_button.dart';
import '/flutterflow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late int seller = 0;
late Map <userClass, dynamic> usersData;

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

    load();
    // On page load action.
    //SchedulerBinding.instance.addPostFrameCallback((_) async {
    //  await showModalBottomSheet(
    //    isScrollControlled: true,
    //    backgroundColor: Colors.transparent,
    //    enableDrag: false,
    //    context: context,
    //    builder: (context) {
    //      return Padding(
    //        padding: MediaQuery.of(context).viewInsets,
    //        child: const ModalClientesWidget(),
    //      );
    //    },
    //  ).then((value) => setState(() {}));
    //});
  }

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
      appBar: AppBar(
        backgroundColor: const Color(0xFF001C30),
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
        title: Align(
          alignment: const AlignmentDirectional(1, 0),
          child: Text(
            'Clientes',
            style: FlutterFlowTheme.of(context).title2.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 2,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: StreamBuilder(
          stream: readProducs(),
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              return const Text("Ocurrio un error");
            } else if(snapshot.hasData){
              final users = snapshot.data;
              return ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  for(int i = 0; i<users!.length; i++)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 70,
                              ),
                              Text(
                                users.toList()[i].Nombre,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.plus_one_outlined,
                          color: Colors.black,
                          size: 70,
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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

Future load() async {
  seller = await FirebaseFirestore.instance.collection("cliente").snapshots().length;
  usersData;
  print("hey: $seller");
}