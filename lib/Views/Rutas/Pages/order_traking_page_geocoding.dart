import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pci_proyect/Views/Rutas/Modals/route_info_modal.dart';
import 'dart:async';
import 'package:pci_proyect/Utils/API_Google_Maps.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

import 'package:pci_proyect/Views/Rutas/Pages/client_screen_per_route.dart';

import 'package:pci_proyect/Utils/geolocalizacion.dart';
import 'package:pci_proyect/utils/singleton.dart';

class OrderTrackingPageGeocoding extends StatefulWidget {
  final String ruta;

  const OrderTrackingPageGeocoding({Key? key, required this.ruta})
      : super(key: key);

  @override
  State<OrderTrackingPageGeocoding> createState() =>
      OrderTrackingPageGeocodingState();
}

class OrderTrackingPageGeocodingState
    extends State<OrderTrackingPageGeocoding> {
  final Completer<GoogleMapController> _controller = Completer();
  Singleton singleton = Singleton();
  String trackOrderText = '';
  late Future<List<LatLng>?> _routePointsFuture;
  List<LatLng> routePoints = [];
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  Timer? locationUpdateTimer;

  @override
  void initState() {
    Firebase.initializeApp();
    getCurrentLocation();
    _routePointsFuture = getLatLngsByRoute(singleton.selectRoute);
    checkPosition();

    // Inicializa la lista de GeoPoints aquí
    // Inicializa la lista de LatLng aquí
    getLatLngsByRoute(singleton.selectRoute).then((latLngList) {
      setState(() {
        routePoints = latLngList;
      });
    });
    // Inicia un timer que llama a la función checkPosition cada 10 segundos
    locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      // checkPosition();
    });

    super.initState();
  }

  @override
  void dispose() {
    // Cancela la actualización de coordenadas en Firestore
    locationUpdateTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF001C30),
        title: Text(
          trackOrderText,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<LatLng>?>(
              future: _routePointsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay datos disponibles'));
                } else {
                  routePoints = snapshot.data!;
                  getPolyPoints();
                  return Column(
                    children: [
                      Expanded(
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              currentLocation!.latitude!,
                              currentLocation!.longitude!,
                            ),
                            zoom: 14.5,
                          ),
                          polylines: {
                            Polyline(
                              polylineId: const PolylineId("route"),
                              points: polylineCoordinates,
                              color: primaryColor,
                              width: 6,
                            ),
                          },
                          markers: {
                            Marker(
                              markerId: const MarkerId("currentLocation"),
                              position: LatLng(
                                currentLocation!.latitude!,
                                currentLocation!.longitude!,
                              ),
                            ),
                            if (routePoints.isNotEmpty) ...{
                              Marker(
                                markerId: const MarkerId("source"),
                                position: routePoints.first,
                              ),
                              Marker(
                                markerId: const MarkerId("destination"),
                                position: routePoints.last,
                              ),
                              // Add markers for additional points
                              for (int i = 1; i < routePoints.length - 1; i++)
                                Marker(
                                  markerId: MarkerId("point$i"),
                                  position: routePoints[i],
                                ),
                            },
                          },
                          onMapCreated: (mapController) {
                            _controller.complete(mapController);
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ModalRouteInfo(
                              ruta: widget.ruta,
                            ),
                          );
                        },
                        child: const Text('Mostrar clientes'),
                      ),
                    ],
                  );
                }
              },
            ),
    );
  }

  void main() {
    runApp(const MaterialApp(
      home: ClientScreenPerRouteWidget(ruta: 'your_route_value'),
    ));
  }

//Function asincronica para obtener las coordenadas del dispositivo actual
// se genera en esta pantalla ya que es el home page del Vendedor
// Sube las coordenadas actuales a nuestra BD en forma de GeoPoint para su posteior uso
  void checkPosition() async {
    Position position = await Geolocalizacion.determinePosition();
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Obtén el usuario actualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Crea una referencia a la colección "usuario" y un nuevo documento con el UID del usuario
      CollectionReference locationCollection =
          FirebaseFirestore.instance.collection('usuario');
      DocumentReference userDoc = locationCollection.doc(user.uid);

      // Crea un objeto GeoPoint con las coordenadas
      GeoPoint geoPoint = GeoPoint(latitude, longitude);

      // Actualiza el documento del usuario con el punto geográfico bajo el campo "marker" o lo crea si no existe
      userDoc.set({'marker': geoPoint}, SetOptions(merge: true)).then((_) {
        print('Coordenadas actualizadas en Firestore');
      }).catchError((error) {
        print('Error al actualizar coordenadas: $error');
      });
    }
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 16,
              target: LatLng(newLoc.latitude!, newLoc.longitude!),
            ),
          ),
        );

        setState(() {});
      },
    );
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    polylineCoordinates = [];

    for (int i = 0; i < routePoints.length - 1; i++) {
      LatLng point1 = routePoints[i];
      LatLng point2 = routePoints[i + 1];

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(point1.latitude, point1.longitude),
        PointLatLng(point2.latitude, point2.longitude),
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
    }

    setState(() {});
  }

//Funcion para retornar una lista de geopoint de los clientes que pertenecen 1 ruta
  Future<List<LatLng>> getLatLngsByRoute(String ruta) async {
    List<LatLng> latLngList = [];
    print("la ruta por hacer es :" + ruta);
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              'cliente') // Reemplaza 'cliente' con el nombre de tu colección
          .where('NumeroDeRuta', isEqualTo: ruta)
          .get();

      querySnapshot.docs.forEach((doc) {
        GeoPoint? marker = doc.get('Marker') as GeoPoint?;
        if (marker != null) {
          latLngList.add(LatLng(marker.latitude, marker.longitude));
        }
      });
    } catch (e) {
      print('Error al obtener las coordenadas LatLng: $e');
    }

    return latLngList;
  }
}
