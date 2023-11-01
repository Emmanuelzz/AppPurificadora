// cliente.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Cliente {
  final String id;
  final String nombre;
  final String apellido;
  final String calle;
  final int codigoPostal;
  final String colonia;
  final String numeroDeCasa;
  final String numeroDeRuta;
  final GeoPoint? geoPoint;

  Cliente({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.calle,
    required this.codigoPostal,
    required this.colonia,
    required this.numeroDeCasa,
    required this.numeroDeRuta,
    this.geoPoint,
  });

  Map<String, dynamic> toJson() {
    return {
      'Nombre': nombre,
      'Apellido': apellido,
      'Calle': calle,
      'CodigoPostal': codigoPostal,
      'Colonia': colonia,
      'NumeroDeCasa': numeroDeCasa,
      'NumeroDeRuta': numeroDeRuta,
      'Marker': geoPoint,
    };
  }

  static Cliente fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nombre: json['Nombre'],
      apellido: json['Apellido'],
      calle: json['Calle'],
      codigoPostal: json['CodigoPostal'],
      colonia: json['Colonia'],
      numeroDeCasa: json['NumeroDeCasa'],
      numeroDeRuta: json['NumeroDeRuta'],
      geoPoint: json['Marker'],
    );
  }

  @override
  String toString() {
    return "$nombre $apellido";
  }
}
