import 'package:flutter/material.dart';
import 'package:pago_servicios/components/drop_down.dart';
import 'package:pago_servicios/components/rounded_button.dart';
import 'package:pago_servicios/entities/catalogo.dart';
import 'package:intl/intl.dart';
import 'package:pago_servicios/entities/servicio.dart';

//EJEMPLO CATALOGO
List<Catalogo> catalogos = [
  Catalogo('Servicio', 'CFE'),
  Catalogo('Servicio', 'Gas'),
  Catalogo('Servicio', 'Agua'),
  Catalogo('Servicio', 'Netflix'),
  Catalogo('Servicio', 'Spotify'),
  Catalogo('Servicio', 'Colegiatura'),
  Catalogo('Servicio', 'Carro'),
  Catalogo('Servicio', 'Renta'),
  Catalogo('Servicio', 'Hipoteca'),
];

List<Catalogo> catalogosCategorias = [
  Catalogo('CFE', 'Domicilio'),
  Catalogo('Gas', 'Domicilio'),
  Catalogo('Agua', 'Domicilio'),
  Catalogo('Netflix', 'Entretenimiento'),
  Catalogo('Spotify', 'Entretenimiento'),
  Catalogo('Colegiatura', 'Educacion'),
  Catalogo('Carro', 'Pago de Bienes'),
  Catalogo('Renta', 'Domicilio'),
  Catalogo('Hipoteca', 'Pago de Bienes'),
  Catalogo('Otro', 'Otro')
];

List<Catalogo> catalogosCat = [
  Catalogo('TipoServicio', 'Domicilio'),
  Catalogo('TipoServicio', 'Entretenimiento'),
  Catalogo('TipoServicio', 'Pago de Bienes'),
  Catalogo('TipoServicio', 'Educacion'),
  Catalogo('TipoServicio', 'Otro')
];

List<String> categorias = catalogosCat.map((e) => e.descripcion).toList();

class FormServicioAdmin extends StatefulWidget {
  final Catalogo catalogoServicio;

  const FormServicioAdmin({Key key, this.catalogoServicio}) : super(key: key);

  @override
  _FormServicioAdminState createState() => _FormServicioAdminState();
}

class _FormServicioAdminState extends State<FormServicioAdmin> {
  String _nombre;
  String _descripcion;

  Catalogo catalogoNuevo;

  void setNombre(String nombre) {
    setState(() {
      _nombre = nombre;
      widget.catalogoServicio.setNombre(nombre);
      catalogoNuevo.setNombre(nombre);
    });
  }

  void setDescripcion(String descripcion) {
    setState(() {
      _descripcion = descripcion;
      widget.catalogoServicio.setDescripcion(descripcion);
      catalogoNuevo.setDescripcion(descripcion);
    });
  }

  //FUNCION EN CASO DE QUE SEA EDICION
  @override
  void initState() {
    super.initState();
    if (widget.catalogoServicio != null) {
      setState(() {
        _nombre = widget.catalogoServicio.nombre;
        _descripcion = widget.catalogoServicio.descripcion;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          child: Column(
        children: <Widget>[
          TextField(
            onChanged: (newValue) {
              setState(() {
                _nombre = newValue;
              });
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                hintText: _nombre == null ? 'Nombre' : _nombre,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
          ),
          // DropDown(
          //   funcion: setDescripcion,
          //   valor: _descripcion,
          //   pista: 'Categoria',
          //   valores: categorias,
          // ),
        ],
      )),
    );
  }
}
