import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pci_proyect/client_screen_per_route.dart';
import 'package:pci_proyect/components/route_info_modal.dart';
import 'dart:async';
import 'API_Google_Maps.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pci_proyect/client_screen_per_route.dart';


class OrderTrackingPageGeocoding extends StatefulWidget {
  final String ruta;

  const OrderTrackingPageGeocoding({Key? key, required this.ruta})
      : super(key: key);

  @override
  State<OrderTrackingPageGeocoding> createState() =>
      OrderTrackingPageGeocodingState();
}

class OrderTrackingPageGeocodingState extends State<OrderTrackingPageGeocoding> {
  final Completer<GoogleMapController> _controller = Completer();
  String trackOrderText = '';

  List<LatLng> routePoints = [];
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

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

  Future<LatLng> geocodeAddress(String address) async {
    const apiKey =
        'AIzaSyDygFA8VYmQNlutSc71vxoOY6Zr8RlImTA'; // Replace with your Google Geocoding API key
    final encodedAddress = Uri.encodeComponent(address);
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final result = data['results'][0];
        final location = result['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        return LatLng(lat, lng);
      } else {
        throw Exception('Geocoding failed: ${data['status']}');
      }
    } else {
      throw Exception('Geocoding request failed');
    }
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

  @override
  void initState() {
    Firebase.initializeApp();
    getCurrentLocation();
    convertAddressesToGeopoints();
    super.initState();
  }

  void convertAddressesToGeopoints() async {
    try {
      CollectionReference clientsCollection =
      FirebaseFirestore.instance.collection('cliente');

      QuerySnapshot querySnapshot = await clientsCollection
          .where("NumeroDeRuta", isEqualTo: widget.ruta)
          .get();

      List<LatLng> newRoutePoints = [];
      List<Future<LatLng>> geocodingFutures = [];

      querySnapshot.docs.forEach((document) {
        String street = document['Calle'];
        String houseNumber = document['NumeroDeCasa'];
        String neighborhood = document['Colonia'];
        int postalCode = document['CodigoPostal'];

        String address =
            '$street $houseNumber, $neighborhood, $postalCode, San Luis, S.L.P.';

        geocodingFutures.add(geocodeAddress(address));
      });

      List<LatLng> geocodedPoints = await Future.wait(geocodingFutures);
      newRoutePoints.addAll(geocodedPoints);

      setState(() {
        routePoints = newRoutePoints;
        trackOrderText = 'Seguimiento de ${widget.ruta}';
      });

      getPolyPoints();
    } catch (e) {
      print('Error converting addresses to geopoints: $e');
    }
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
          ? const Center(child: Text("Loading"))
          : Column(
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
                builder: (context) =>
                    ModalRouteInfo(
                      ruta: widget.ruta,
                    ),
              );
            },
            child: const Text('Mostrar clientes'),
          ),
        ],
      ),
    );
  }


  void main() {
    runApp(const MaterialApp(
      home: ClientScreenPerRouteWidget(ruta: 'your_route_value'),
    ));
  }
}
