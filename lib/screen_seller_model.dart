import 'package:pci_proyect/client_screen_model.dart';
import 'package:pci_proyect/components/modal_seller_reg_widget.dart';

import '/flutterflow/flutter_flow_icon_button.dart';
import '/flutterflow/flutter_flow_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'components/modal_seller_widget.dart';
export 'screen_seller_model.dart';

late int seller = 0;
late Map <userClass, dynamic> usersData;

class ScreenSellerWidget extends StatefulWidget {
  const ScreenSellerWidget({Key? key}) : super(key: key);

  @override
  _ScreenSellerWidgetState createState() => _ScreenSellerWidgetState();
}

class _ScreenSellerWidgetState extends State<ScreenSellerWidget> {
  //late screen_seller_model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    load();
    //_model = createModel(context, () => ScreenSellerModel());
  }

  @override
  void dispose() {
    // _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: const ModalSellerRegWidget(),
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
        title: Align(
          alignment: AlignmentDirectional(1, 0),
          child: Text(
            'Vendedores',
            style: FlutterFlowTheme.of(context).title2.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('usuario').snapshots(),
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
                                  child: ModalSellerWidget(
                                    Apellido: ds["Apellido"].toString(),
                                    Nombre: ds["Nombre"].toString(),
                                    Correo: ds["correo"].toString(),
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

    );

  }
  Stream <Iterable<user>> readProducs()
  => FirebaseFirestore.instance
      .collection("usuario")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => user.fromJson(doc.data())));
}

class user {
  final String Apellido;
  final String Nombre;
  final String Correo;

  user({
    this.Apellido = "",
    this.Nombre = "",
    this.Correo = ""
  });

  static user fromJson(Map <String, dynamic> json) => user(
      Apellido: json["Apellido"],
      Nombre: json["Nombre"],
      Correo: json["correo"]
  );
}

Future createSeller({required String email}) async{
  final docUser = FirebaseFirestore.instance.collection("usuario").doc();
  final json = {
    "Apellido" :  "",//docUser.id,
    "Nombre" : "",//email,
    "correo" : email,//email,
  };
  await docUser.set(json);
}

Future load() async {
  seller = await FirebaseFirestore.instance.collection("usuario").snapshots().length;
  print(seller);
}

