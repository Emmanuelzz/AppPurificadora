// repartidor_dropdown.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Models/repartidor.dart'; // Importa el modelo Repartidor

class RepartidorDropdown extends StatefulWidget {
  final ValueChanged<Repartidor?> onChanged;
  RepartidorDropdown({required this.onChanged});

  @override
  _RepartidorDropdownState createState() => _RepartidorDropdownState();
}

class _RepartidorDropdownState extends State<RepartidorDropdown> {
  List<Repartidor> repartidores = [];
  Repartidor? selectedRepartidor;

  @override
  void initState() {
    super.initState();
    _fetchRepartidores();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40; // 20 de margen a cada lado
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10), // Añade un poco de espacio en el interior también
      child: DropdownButton<Repartidor>(
        isExpanded: true, // Asegúrate de tener esto
        hint: Text("Selecciona un repartidor"),
        value: selectedRepartidor,
        items: repartidores.map((Repartidor repartidor) {
          return DropdownMenuItem<Repartidor>(
            value: repartidor,
            child: Text(repartidor.toString()),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedRepartidor = newValue;
          });
          widget.onChanged(newValue); // Notifica al widget padre
        },
      ),
    );
  }

  void _fetchRepartidores() async {
    final snapshot = await FirebaseFirestore.instance.collection('usuario').get();
    final List<Repartidor> fetchedRepartidores = [];
    for (final doc in snapshot.docs) {
      fetchedRepartidores.add(Repartidor(
        id: doc.id,
        nombre: doc.get('Nombre') as String,
        apellido: doc.get('Apellido') as String,
        correo: doc.get('correo') as String,
      ));
    }
    setState(() {
      repartidores = fetchedRepartidores;
      selectedRepartidor = null;  // Asegúrate de que selectedRepartidor es null aquí.
    });
  }

}