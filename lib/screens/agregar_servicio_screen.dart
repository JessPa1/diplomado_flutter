import 'package:flutter/material.dart';
import 'package:pago_servicios/components/custom_drawer.dart';
import 'package:pago_servicios/components/form_servicio_pago.dart';
import 'package:pago_servicios/components/rounded_button.dart';
import 'package:pago_servicios/controllers/servicios_controller.dart';
import 'package:pago_servicios/entities/servicio.dart';
import '../constants.dart';

ServicioController _controller = ServicioController();

class AgregarServicioScreen extends StatefulWidget {
  static const String id = 'agregar_servicio_screen';
  @override
  _AgregarServicioScreenState createState() => _AgregarServicioScreenState();
}

class _AgregarServicioScreenState extends State<AgregarServicioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.buildAppBar(context, 'Agregar Servicio'),
      drawer: DrawerCustom(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FormServicioPago(textoBoton: 'Agregar'),
          ],
        )),
      ),
    );
  }
}

//FUNCION PARA CONFIRMAR AGREGAR DE SERVICIO
Future addServicio(BuildContext context, Servicio servicio) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text("Ingrese la siguiente info:"),
        content: Text(
          '¡Servicio agregado exitosamente!',
          style: TextStyle(
              fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "OK",
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
