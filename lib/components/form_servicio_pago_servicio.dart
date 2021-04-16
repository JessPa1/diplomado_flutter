import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pago_servicios/controllers/servicios_controller.dart';
import 'package:pago_servicios/models/data_container.dart';

import '../constants.dart';
import '../entities/catalogo.dart';
import '../entities/servicio.dart';
import '../models/generic_response_products.dart';
import '../models/network_helper.dart';
import 'drop_down.dart';
import 'rounded_button.dart';

ServicioController _controller = ServicioController();
NetworkHelper _networkHelper = NetworkHelper();

class FormServicioPagoServicio extends StatefulWidget {
  final Servicio servicio;
  final String textoBoton;
  const FormServicioPagoServicio({Key key, this.servicio, this.textoBoton})
      : super(key: key);

  @override
  _FormServicioPagoServicioState createState() =>
      _FormServicioPagoServicioState();
}

class _FormServicioPagoServicioState extends State<FormServicioPagoServicio> {
  String _nombre;
  String _codigoProducto;
  int _referencia;
  String _id;
  double _monto = 0;
  Set<String> _serviciosPago = Set();
  Set<String> _productosDisponibles = Set();
  List<Catalogo> _productoCantidad = List();

  void setNombre(String nombre) {
    setState(() {
      _nombre = nombre;
      _codigoProducto = DataContainer.serviciosUsuario
          .where((ncc) =>
              '${ncc.nombre} - ${ncc.categoria} - ${ncc.cantidad}' == _nombre)
          .first
          .codigoProducto;
    });
  }

  //FUNCION QUE TRAE TODOS LOS PRODUCTOS A PAGAR
  void setProductos() async {
    GenericResponseProducts response = await NetworkHelper().getProducts();
    setState(() {
      response.data.productos.forEach((p) {
        _productoCantidad.add(Catalogo(
            '${p.carrier} - ${response.data.bolsas.where((b) => b.id == p.bolsaId).first.nombre}',
            '${p.monto}'));
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
    setState(() {
      DataContainer.serviciosUsuario.forEach((su) {
        String nombreServicio =
            '${su.nombre} - ${su.categoria} - ${su.cantidad}';
        _serviciosPago.add(nombreServicio);
      });
    });
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
          valoresSet: _serviciosPago,
        ),
        _nombre == null || double.parse(_nombre.split(" - ")[2]) > 0
            ? SizedBox()
            : TextField(
                onChanged: (newValue) {
                  setState(() {
                    _monto = double.parse(newValue);
                  });
                },
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: _referencia == null
                        ? 'Cantidad'
                        : _referencia.toString(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400))),
              ),
        TextField(
          onChanged: (newValue) {
            setState(() {
              _referencia = int.parse(newValue);
            });
          },
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: _referencia == null
                  ? 'Numero de referencia'
                  : _referencia.toString(),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400))),
        ),
        RoundedButton(
            onPressed: () {
              submitPago(context, _codigoProducto, _referencia.toString(),
                  _nombre, _monto);
            },
            title: widget.textoBoton,
            colour: Colors.lightBlue)
      ],
    )));
  }
}

//FUNCION PARA PAGAR
void submitPago(BuildContext context, String codigoProducto, String referencia,
    String nombre, double monto) async {
  dynamic response =
      await NetworkHelper().submitPago(codigoProducto, referencia, monto);

  if (response["success"]) {
    Navigator.of(context).pop();
    ErrorDialogs.confirmationMessage(
        context, "200", 'El Pago se hizo exitosamente');
    // _controller.addReciboPago(nombre, response["data"]["transID"],
    //     DateTime.now().millisecondsSinceEpoch);
  } else {
    Navigator.of(context).pop();
    ErrorDialogs.confirmationMessage(
        context, response["error"], response["message"]);
  }
}
