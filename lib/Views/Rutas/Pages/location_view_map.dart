import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_AppBar.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_drawer.dart';

import '../../../utils/singleton.dart';

class LocationViewMap extends StatefulWidget {
  const LocationViewMap({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<LocationViewMap> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController? _controller;
  Set<Marker> _markers = Set<Marker>();
  Singleton singelton = Singleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      appBar: CustomAppBar(title: 'Posiciones', scaffoldKey: scaffoldKey),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(22.1565,
              -100.9855), // Coordenadas de San Luis Potosí // Centro del mapa inicial
          zoom: 12.0, // Nivel de zoom
        ),
        markers: _markers,
      ),
    );
  }

  Future<String> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      CollectionReference userCollection =
      FirebaseFirestore.instance.collection('usuario');
      DocumentSnapshot userDocument = await userCollection.doc(uid).get();

      if (userDocument.exists) {
        final data = userDocument.data() as Map<String, dynamic>;
        if (data.containsKey('nombre')) {
          return data['nombre'] as String;
        }
      }
    }

    return 'Nombre no encontrado'; // Si no se encontró el usuario o el nombre
  }

  // Función para cargar marcadores desde Firestore y mostrarlos en el mapa
  void loadMarkersFromFirestore() {
    // Aquí debes consultar Firestore para obtener los datos de los puntos (marcadores)
    // y luego crear marcadores y agregarlos a _markers.
    // Ejemplo:
    FirebaseFirestore.instance
        .collection('usuario')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        double latitude = doc.data()['marker'].latitude;
        double longitude = doc.data()['marker'].longitude;
        _markers.add(Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: await getUserName(),
            )
            // Otras opciones como icono personalizado, información adicional, etc.
            ));
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadMarkersFromFirestore();
  }
}
