import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/servicios_controller.dart';
import '../entities/catalogo.dart';
import '../entities/servicio.dart';
import '../models/generic_response_products.dart';
import '../models/network_helper.dart';
import 'drop_down.dart';
import 'rounded_button.dart';

ServicioController _controller = ServicioController();

class FormServicioPago extends StatefulWidget {
  final Servicio servicio;
  final String textoBoton;
  const FormServicioPago({Key key, this.servicio, this.textoBoton})
      : super(key: key);

  @override
  _FormServicioPagoState createState() => _FormServicioPagoState();
}

class _FormServicioPagoState extends State<FormServicioPago> {
  String _nombre;
  int _fechaPago;
  String _id;
  Set<String> _productosDisponibles = Set();
  List<Catalogo> _productoCodigo = List();

  void setNombre(String nombre) {
    setState(() {
      _nombre = nombre;
    });
  }

  void setFechaPago() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2022))
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _fechaPago = value.millisecondsSinceEpoch;
          //_nuevoServicio.fechaPago = value.millisecondsSinceEpoch;
        });
      }
    });
  }

  //FUNCION QUE TRAE TODOS LOS PRODUCTOS A PAGAR
  void setProductos() async {
    GenericResponseProducts response = await NetworkHelper().getProducts();
    setState(() {
      response.data.productos.forEach((p) {
        _productoCodigo.add(Catalogo(
            '${p.carrier} - ${response.data.bolsas.where((b) => b.id == p.bolsaId).first.nombre} - ${p.monto}',
            '${p.codigo}'));
      });

      _productosDisponibles = response.data.productos
          .map((p) =>
              '${p.carrier} - ${response.data.bolsas.where((b) => b.id == p.bolsaId).first.nombre} - ${p.monto}')
          .toSet();
    });
  }

  //FUNCION EN CASO DE QUE SEA EDICION
  @override
  void initState() {
    super.initState();
    setProductos();
    if (widget.servicio != null) {
      setState(() {
        _id = widget.servicio.id;
        _nombre = widget.servicio.nombre;
        _fechaPago = widget.servicio.fechaPago;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
            child: Column(
      children: <Widget>[
        DropDown(
          sizeHint: 20.0,
          funcion: setNombre,
          valor: _nombre,
          pista: 'Servicio',
          valoresSet: _productosDisponibles,
        ),
        GestureDetector(
          onTap: setFechaPago,
          child: Container(
            height: 50,
            padding: EdgeInsets.only(top: 15.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
            ),
            child: Text(
              _fechaPago == null
                  ? 'Fecha de Pago'
                  : DateFormat.yMEd()
                      .format(DateTime.fromMillisecondsSinceEpoch(_fechaPago)),
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
        RoundedButton(
            onPressed: () {
              _controller.addUpdateServicio(
                  context,
                  _id,
                  _nombre,
                  _fechaPago,
                  _productoCodigo
                      .where((cp) => cp.nombre == _nombre)
                      .first
                      .descripcion);
            },
            title: widget.textoBoton,
            colour: Colors.lightBlue)
      ],
    )));
  }
}
