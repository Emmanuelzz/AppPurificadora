import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RutaDropdown extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final String? value;

  RutaDropdown({this.onChanged, this.value});

  @override
  _RutaDropdownState createState() => _RutaDropdownState();
}

class _RutaDropdownState extends State<RutaDropdown> {
  List<String> rutas = [];

  @override
  void initState() {
    super.initState();
    _fetchRutas();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40; // 20 de margen a cada lado
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10), // Añade un poco de espacio en el interior también
      child: DropdownButton<String>(
        isExpanded: true, // Asegúrate de tener esto
        hint: Text("Selecciona una ruta"),
        value: widget.value,
        items: rutas.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: widget.onChanged,
      ),
    );
  }

  void _fetchRutas() async {
    final snapshot = await FirebaseFirestore.instance.collection('cliente').get();
    final Set<String> uniqueRoutes = {};
    for (final doc in snapshot.docs) {
      final numeroDeRuta = doc.get('NumeroDeRuta') as String;
      uniqueRoutes.add(numeroDeRuta);
    }
    setState(() {
      rutas = uniqueRoutes.toList();
    });
  }
}
