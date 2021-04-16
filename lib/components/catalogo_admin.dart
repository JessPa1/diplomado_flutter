import 'package:flutter/material.dart';
import 'package:pago_servicios/entities/catalogo.dart';

import 'drop_down.dart';

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

List<Catalogo> catalogosGeneral = [
  Catalogo('Servicio', 'CFE'),
  Catalogo('Servicio', 'Gas'),
  Catalogo('Servicio', 'Agua'),
  Catalogo('Servicio', 'Netflix'),
  Catalogo('Servicio', 'Spotify'),
  Catalogo('Servicio', 'Colegiatura'),
  Catalogo('Servicio', 'Carro'),
  Catalogo('Servicio', 'Renta'),
  Catalogo('Servicio', 'Hipoteca'),
  Catalogo('TipoServicio', 'Domicilio'),
  Catalogo('TipoServicio', 'Entretenimiento'),
  Catalogo('TipoServicio', 'Pago de Bienes'),
  Catalogo('TipoServicio', 'Educacion'),
  Catalogo('TipoServicio', 'Otro'),
  Catalogo('Hipoteca', 'Pago de Bienes'),
  Catalogo('TipoUsuario', 'Nivel 1'),
  Catalogo('TipoUsuario', 'Admin'),
];

class CatalogoAdmin extends StatefulWidget {
  final String catalogo;

  const CatalogoAdmin({Key key, this.catalogo}) : super(key: key);
  @override
  _CatalogoAdminState createState() => _CatalogoAdminState();
}

class _CatalogoAdminState extends State<CatalogoAdmin> {
  String _nombre;
  String _descripcion;
  List<Catalogo> _descripciones;
  List<String> _nuevasDescripciones;
  List<Widget> _textFields;

  Catalogo catalogoNuevo;

  void setNombre(String nombre) {
    setState(() {
      _nombre = nombre;
      catalogoNuevo.setNombre(nombre);
    });
  }

  void setNuevaDescripcion(String nuevaDescripcion) {
    _nuevasDescripciones.add(nuevaDescripcion);
  }

  void remplazarDescripcion(String nuevaDescripcion, String viejaDescripcion) {
    _nuevasDescripciones.removeWhere((element) => element == viejaDescripcion);
    _nuevasDescripciones.add(nuevaDescripcion);

    _nuevasDescripciones.forEach((element) {
      print(element);
    });
  }

  void setDescripcion(String descripcion) {
    setState(() {
      _descripcion = descripcion;
      catalogoNuevo.setDescripcion(descripcion);
    });
  }

  //FUNCION EN CASO DE QUE SEA EDICION
  @override
  void initState() {
    super.initState();
    _textFields = [];
    if (widget.catalogo != null) {
      setState(() {
        _nombre = widget.catalogo;
        _descripciones =
            catalogosGeneral.where((e) => e.getNombre() == _nombre).toList();
        _nuevasDescripciones =
            _descripciones.map((e) => e.descripcion).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Nombre de Catalogo: ',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  TextField(
                    onChanged: (newValue) {
                      setState(() {
                        _nombre = newValue;
                      });
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: _nombre == null
                            ? 'Escriba nombre de Catalogo'
                            : _nombre,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
                _descripciones != null
                    ? 'Descripciones:'
                    : 'Descripciones nuevas:',
                style: TextStyle(color: Colors.black, fontSize: 20)),
            _descripciones != null
                ? SingleChildScrollView(
                    child: Column(
                      children: _descripciones
                          .map(
                            (e) => TextFieldCustom(
                              funcion: remplazarDescripcion,
                              hint: e.descripcion,
                            ),
                          )
                          .toList(),
                    ),
                  )
                : TextFieldCustom(
                    funcion: setNuevaDescripcion,
                    hint: 'Escriba una subcategoría o descripcion',
                  ),
            SingleChildScrollView(
              child: Column(
                children: _textFields.toList(),
              ),
            ),
            InkWell(
              splashColor: Colors.grey.shade100,
              onTap: () {
                setState(() {
                  _textFields.add(
                    TextFieldCustom(
                      funcion: setNuevaDescripcion,
                      hint: 'Escriba una subcategoría o descripcion',
                    ),
                  );
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Agregar campo',
                    style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 15),
                  ),
                  Icon(
                    Icons.add_box_rounded,
                    size: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldCustom extends StatelessWidget {
  final String hint;
  final Function funcion;

  const TextFieldCustom({Key key, this.hint, this.funcion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (String newValue) {
        funcion(newValue, hint);
      },
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }
}
