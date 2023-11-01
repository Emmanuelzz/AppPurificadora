import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModalRouteInfo extends StatefulWidget {
  final String ruta;

  const ModalRouteInfo({Key? key, required this.ruta})
      : super(key: key);

  @override
  _ModalRouteInfoState createState() =>
      _ModalRouteInfoState();
}

class _ModalRouteInfoState extends State<ModalRouteInfo> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AppBar(
              backgroundColor: const Color(0xFF001C30),
              automaticallyImplyLeading: false,
              title: Align(
                alignment: AlignmentDirectional(1, 0),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: readProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final users = snapshot.data!.docs;
                      final routeNumber =
                      users.isNotEmpty ? users[0]['NumeroDeRuta'] : '';
                      return Text(
                        'Clientes - $routeNumber',
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              centerTitle: false,
              elevation: 2,
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: readProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Ocurrió un error");
                } else if (snapshot.hasData) {
                  final users = snapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index].data();
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.grey[200],
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 70,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      user['Nombre'] +
                                          ' ' +
                                          user['Apellido'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      user['Calle'] +
                                          ', ' +
                                          user['NumeroDeCasa'] +
                                          ', ' +
                                          user['Colonia'],
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readProducts() {
    return FirebaseFirestore.instance
        .collection("cliente")
        .where("NumeroDeRuta", isEqualTo: widget.ruta)
        .snapshots();
  }
}
