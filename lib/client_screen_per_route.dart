import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pci_proyect/order_traking_page_geocoding.dart';

class ClientScreenPerRouteWidget extends StatefulWidget {
  final String ruta;

  const ClientScreenPerRouteWidget({Key? key, required this.ruta}) : super(key: key);

  @override
  _ClientScreenPerRouteWidgetState createState() =>
      _ClientScreenPerRouteWidgetState();
}

class _ClientScreenPerRouteWidgetState extends State<ClientScreenPerRouteWidget> {

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF001C30),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Align(
            alignment: AlignmentDirectional(1, 0),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: readProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final users = snapshot.data!.docs;
                  final routeNumber = users.isNotEmpty ? users[0]['NumeroDeRuta'] : '';
                  return Text(
                    'Clientes - $routeNumber',
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: readProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Ocurrió un error");
            } else if (snapshot.hasData) {
              final users = snapshot.data!.docs;
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index].data();
                  return Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
                                  user['Nombre'] + ' ' + user['Apellido'],
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
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderTrackingPageGeocoding(ruta: widget.ruta),
              ),
            );
          },
          child: Container(
            height: 60,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Iniciar ruta',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
