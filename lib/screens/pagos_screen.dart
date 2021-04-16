import 'package:flutter/material.dart';
import 'package:pago_servicios/components/custom_drawer.dart';
import 'package:pago_servicios/components/custom_list_tile.dart';
import 'package:pago_servicios/components/form_servicio_pago.dart';
import 'package:pago_servicios/components/form_servicio_pago_servicio.dart';
import 'package:pago_servicios/components/rounded_button.dart';
import 'package:pago_servicios/entities/servicio.dart';
import 'package:pago_servicios/models/data_container.dart';
import 'package:pago_servicios/models/menu_item.dart';
import 'package:pago_servicios/screens/servicio_screen.dart';
import 'package:pago_servicios/screens/welcome_screen.dart';

import '../constants.dart';

class PagosScreen extends StatefulWidget {
  static const String id = 'pagos_screen';
  @override
  _PagosScreenState createState() => _PagosScreenState();
}

class _PagosScreenState extends State<PagosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.buildAppBar(context, 'Pago de Servicios'),
      drawer: DrawerCustom(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FormServicioPagoServicio(textoBoton: 'Pagar'),
          ],
        )),
      ),
    );
  }
}
