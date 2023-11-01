import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_drawer.dart';
import 'package:pci_proyect/Views/Rutas/Pages/geocoding_refactor.dart';
import 'package:pci_proyect/Views/Rutas/Pages/order_traking_page_geocoding.dart';

class ClientScreenPerRouteWidget extends StatefulWidget {
  final String ruta;

  const ClientScreenPerRouteWidget({Key? key, required this.ruta})
      : super(key: key);

  @override
  _ClientScreenPerRouteWidgetState createState() =>
      _ClientScreenPerRouteWidgetState();
}

class _ClientScreenPerRouteWidgetState
    extends State<ClientScreenPerRouteWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

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
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
          title: _buildAppBarTitle(),
          centerTitle: false,
          elevation: 2,
        ),
        drawer: CustomDrawer(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: streamClientsForRoute(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final routeNumber = snapshot.data!.docs.isNotEmpty
              ? snapshot.data!.docs[0]['NumeroDeRuta']
              : '';
          return Align(
            alignment: Alignment.centerRight,
            child: Text('$routeNumber'),
          );
        }
        return const SizedBox();
      },
    );
  }


  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: streamClientsForRoute(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Ocurrió un error");
        } else if (snapshot.hasData) {
          final users = snapshot.data!.docs;
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data();
              return _buildClientCard(user);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildClientCard(Map<String, dynamic> user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.grey[200],
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
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
                    '${user['Nombre']} ${user['Apellido']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${user['Calle']}, ${user['NumeroDeCasa']}, ${user['Colonia']}',
                    style: const TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                //GeocodingRefactor(ruta: widget.ruta),
                OrderTrackingPageGeocoding(ruta: widget.ruta),
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
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamClientsForRoute() {
    return FirebaseFirestore.instance
        .collection("cliente")
        .where("NumeroDeRuta", isEqualTo: widget.ruta)
        .snapshots();
  }
}
