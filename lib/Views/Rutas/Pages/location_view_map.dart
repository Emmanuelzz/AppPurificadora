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

  // Función para cargar marcadores desde Firestore y mostrarlos en el mapa
  void loadMarkersFromFirestore() {
    FirebaseFirestore.instance
        .collection('usuario')
        .get()
        .then((querySnapshot) {
      // Limpiar los marcadores existentes antes de cargar nuevos
      _markers.clear();

      querySnapshot.docs.forEach((doc) async {
        // Verificar que el documento tenga la información necesaria
        if (doc.exists &&
            doc.data() != null &&
            doc.data()!.containsKey('marker')) {
          // Obtener las coordenadas del marcador
          GeoPoint markerGeoPoint = doc.data()['marker'];
          double latitude = markerGeoPoint.latitude;
          double longitude = markerGeoPoint.longitude;
          print("geopoint ${markerGeoPoint}");

          // Verificar que las coordenadas sean válidas antes de agregar el marcador
          if (latitude != null && longitude != null) {
            // Obtener el nombre del usuario
            String userName = doc.data()['Nombre'];

            // Crear y agregar el marcador al conjunto de marcadores
            _markers.add(
              Marker(
                markerId: MarkerId(doc.id),
                position: LatLng(latitude, longitude),
                infoWindow: InfoWindow(
                  title: userName,
                ),
              ),
            );
          }
        }
      });

      // Actualizar el estado para reflejar los cambios en el mapa
      setState(() {});
    }).catchError((error) {
      // Manejar cualquier error que pueda ocurrir durante la carga de datos
      print('Error al cargar marcadores: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    loadMarkersFromFirestore();
  }
}
