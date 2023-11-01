import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pci_proyect/Views/Common/Widgets/custom_AppBar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pci_proyect/Views/Repartidores/Widgets/repartidor_dropdown.dart';
import 'package:pci_proyect/Models/repartidor.dart';
import 'package:pci_proyect/Views/Rutas/Widgets/rutas_dropdown.dart';

import 'package:pci_proyect/Views/Common/Widgets/custom_drawer.dart'; // Importar el CustomDrawer
import '../../../flutterflow/flutter_flow_util.dart';

class AssignRouteScreen extends StatefulWidget {
  const AssignRouteScreen({Key? key}) : super(key: key);

  @override
  _AssignRouteScreenState createState() => _AssignRouteScreenState();
}

class _AssignRouteScreenState extends State<AssignRouteScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedRoute;
  Repartidor? selectedRepartidor;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CalendarFormat _currentFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    deleteOldData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asignar el key al Scaffold
      appBar: CustomAppBar(title: 'Asignar Rutas', scaffoldKey: _scaffoldKey),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          _buildCalendar(),
          _buildRouteDropdown(),
          _buildRepartidorDropdown(),
          ElevatedButton(
            onPressed: _assignRoute,
            child: const Text('Asignar Ruta'),
          ),
          Expanded(child: _buildAssignedRoutesList()),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.now().subtract(const Duration(days: 7)), // Hasta un mes antes para la vista de mes
      lastDay: DateTime.now().add(const Duration(days: 7)), // Hasta un mes después para la vista de mes
      focusedDay: selectedDate,
      locale: 'es_ES',
      selectedDayPredicate: (day) => isSameDay(selectedDate, day),
      onDaySelected: (selected, focused) {
        // Evita la selección de sábados y domingos
        if (selected.weekday != DateTime.saturday && selected.weekday != DateTime.sunday) {
          setState(() => selectedDate = selected);
        }
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendDecoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.grey),
      ),
      calendarFormat: _currentFormat, // Utiliza la variable de estado
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      onFormatChanged: (format) {
        setState(() {
          _currentFormat = format; // Actualiza el formato actual
        });
      },
    );
  }



  Widget _buildRouteDropdown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0), // Esto añade bordes a los lados.
      child: RutaDropdown(
        value: selectedRoute,
        onChanged: (newValue) => setState(() => selectedRoute = newValue),
      ),
    );
  }

  Widget _buildRepartidorDropdown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0), // Esto añade bordes a los lados.
      child: RepartidorDropdown(
        onChanged: (selected) => setState(() => selectedRepartidor = selected),
      ),
    );
  }


  Widget _buildAssignedRoutesList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('usuario').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) => _buildRouteListItem(snapshot.data!.docs[index]),
        );
      },
    );
  }

  Widget _buildRouteListItem(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final List<dynamic> assignedRoutes = data['rutasAsignadas']?[formatDay(selectedDate)] ?? [];

    if (assignedRoutes.isEmpty) return Container();

    return ListTile(
      title: Text("${data['Nombre']} ${data['Apellido']}"),
      subtitle: Wrap(
        spacing: 5.0,
        children: assignedRoutes.map((ruta) {
          return _buildRouteChip(doc.id, ruta);
        }).toList(),
      ),
    );
  }

  Widget _buildRouteChip(String repartidorId, String route) {
    return GestureDetector(
      onTap: () => _removeRoute(repartidorId, route),
      child: Chip(
        label: Text(route),
        deleteIcon: const Icon(Icons.close),
        onDeleted: () => _removeRoute(repartidorId, route),
      ),
    );
  }

  Future<void> _assignRoute() async {
    if (selectedRoute == null || selectedRepartidor == null) {
      // Considerar mostrar un mensaje de error o alerta.
      return;
    }

    await FirebaseFirestore.instance.collection('usuario').doc(selectedRepartidor!.id).set({
      'rutasAsignadas': {
        formatDay(selectedDate): FieldValue.arrayUnion([selectedRoute!])
      }
    }, SetOptions(merge: true));

    setState(() => selectedRoute = null);
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String formatDay(DateTime date) {
    return DateFormat('EEEE', 'es_ES').format(date); // Devuelve "Lunes", "Martes", etc.
  }


  Future<void> _removeRoute(String repartidorId, String routeToRemove) async {
    final docRef = FirebaseFirestore.instance.collection('usuario').doc(repartidorId);
    final doc = await docRef.get();
    final rutasAsignadas = doc.get('rutasAsignadas') ?? {};
    final formattedDate = formatDay(selectedDate);

    if (!rutasAsignadas.containsKey(formattedDate)) return;

    final currentRoutes = List<String>.from(rutasAsignadas[formattedDate]);
    currentRoutes.remove(routeToRemove);

    if (currentRoutes.isEmpty) {
      rutasAsignadas.remove(formattedDate);
    } else {
      rutasAsignadas[formattedDate] = currentRoutes;
    }

    await docRef.update({'rutasAsignadas': rutasAsignadas});
    setState(() {});
  }

  void deleteOldData() async {
    final cutoffDateBefore = DateTime.now().subtract(const Duration(days: 30));
    final cutoffDateAfter = DateTime.now().add(const Duration(days: 30));

    final querySnapshotBefore = await FirebaseFirestore.instance
        .collection('usuario')
        .where('rutasAsignadas', isLessThan: formatDay(cutoffDateBefore))
        .get();

    for (final doc in querySnapshotBefore.docs) {
      await doc.reference.delete();
    }

    final querySnapshotAfter = await FirebaseFirestore.instance
        .collection('usuario')
        .where('rutasAsignadas', isGreaterThan: formatDay(cutoffDateAfter))
        .get();

    for (final doc in querySnapshotAfter.docs) {
      await doc.reference.delete();
    }
  }

}
