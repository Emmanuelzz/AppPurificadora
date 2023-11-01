// repartidor.dart

class Repartidor {
  final String id;
  final String nombre;
  final String apellido;
  final String correo;

  Repartidor({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
  });

  Map<String, dynamic> toJson() {
    return {
      'Nombre': nombre,
      'Apellido': apellido,
      'correo': correo,
    };
  }
  static Repartidor fromJson(Map<String, dynamic> json) {
    return Repartidor(
      id: json['id'],
      nombre: json['Nombre'],
      apellido: json['Apellido'],
      correo: json['correo'],
    );
  }

  @override
  String toString() {
    return "$nombre $apellido";
  }
}
