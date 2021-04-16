import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/custom_drawer.dart';
import '../constants.dart';
import '../entities/servicio.dart';
import '../models/data_container.dart';

class CalendarioScreen extends StatefulWidget {
  static const String id = 'calendario_screen';

  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  List<Servicio> _servicios;
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;

//LLAMADA A FIREBASE PARA RECUPERAR SERVICIOS
  void getServicios() {
    setState(() {
      _servicios = DataContainer.serviciosUsuario;
    });
  }

  @override
  void initState() {
    super.initState();
    getServicios();
    _controller = CalendarController();
    _eventController = TextEditingController();

    _events = {};
    for (Servicio servicio in _servicios) {
      DateTime fechaPago =
          DateTime.fromMillisecondsSinceEpoch(servicio.fechaPago);
      List<dynamic> nombre = [servicio.nombre];

      _events.putIfAbsent(fechaPago, () => nombre);
    }

    print(_events);

    _selectedEvents = [];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: Constants.buildAppBar(context, 'Calendario de Pagos'),
      drawer: DrawerCustom(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            Column(
              children: _servicios
                  .map((servicio) => ListItem(servicio: servicio))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Servicio servicio;

  const ListItem({Key key, this.servicio}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 32, bottom: 32, left: 16.0, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      servicio.nombre,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Fecha: ${DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(servicio.fechaPago))}',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                    Text(
                      'Cantidad: ${servicio.cantidad}',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
