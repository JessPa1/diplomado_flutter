import 'package:flutter/material.dart';
import 'package:pago_servicios/models/generic_response_products.dart';
import 'package:pago_servicios/models/network_helper.dart';

import '../components/custom_drawer.dart';
import '../components/form_servicio_admin.dart';
import '../constants.dart';
import '../entities/catalogo.dart';
import 'reset_password.dart';

class CategoriasAdminScreen extends StatefulWidget {
  static const String id = 'categorias_admin_screen';
  @override
  _CategoriasAdminScreenState createState() => _CategoriasAdminScreenState();
}

class _CategoriasAdminScreenState extends State<CategoriasAdminScreen> {
  List<String> _categorias = List<String>();
  List<String> _categoriasMostrar = List<String>();

  List<String> _categoriasDisponibles = List();
  List<Catalogo> _productoCodigo = List();
  List<Catalogo> _categoriaServicio = List();

  @override
  void initState() {
    super.initState();
    setProductos();
  }

  List<String> listaSet(String categoria) {
    List<String> list = _categoriaServicio
        .where((a) => a.nombre == categoria)
        .map((e) => e.descripcion)
        .toSet()
        .toList();
    return list;
  }

  //FUNCION QUE TRAE TODOS LOS PRODUCTOS A PAGAR
  void setProductos() async {
    GenericResponseProducts response = await NetworkHelper().getProducts();
    setState(() {
      _categorias = response.data.bolsas.map((e) => e.nombre).toList();
      _categoriasMostrar = _categorias;

      _categoriasDisponibles = response.data.productos
          .map((p) =>
              '${response.data.bolsas.where((b) => b.id == p.bolsaId).first.nombre} - ${p.carrier} - ${p.monto} - ${p.codigo}')
          .toList();
    });

    response.data.productos.forEach((element) {
      Catalogo catSer = Catalogo(
          response.data.bolsas
              .where((b) => b.id == element.bolsaId)
              .first
              .nombre,
          element.carrier);
      _categoriaServicio.add(catSer);
    });
  }

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Categorias');
  void choiceAction(String choice) {
    if (choice == Constants.reset) {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, ResetPassword.id);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  if (this.cusIcon.icon == Icons.search) {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      onChanged: (text) {
                        text = text.toLowerCase();
                        setState(() {
                          _categoriasMostrar = _categorias.where((s) {
                            var sNombe = s.toLowerCase();

                            return sNombe.contains(text);
                          }).toList();
                        });
                      },
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          hintText: 'Buscar...',
                          hintStyle: TextStyle(color: Colors.white)),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    );
                  } else {
                    this.cusIcon = Icon(Icons.search);
                    this.cusSearchBar = Text('Categorias');
                  }
                });
              },
              child: SizedBox(
                width: 20.0,
                child: cusIcon,
              ),
            ),
            PopupMenuButton(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((
                    choice,
                  ) {
                    return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: TextStyle(color: Colors.black),
                        ));
                  }).toList();
                })
          ],
          title: cusSearchBar,
        ),
        drawer: DrawerCustom(),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemBuilder: (context, index) {
            return _listItem(index);
          },
          itemCount: _categoriasMostrar.length,
        ));
  }

  _listItem(int index) {
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
                      _categoriasMostrar[index],
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Total servicios: ${_categoriasDisponibles.where((cd) => cd.split(" - ")[0] == _categoriasMostrar[index]).length}',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold),
                    ),
                    //loop por cada carrier

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listaSet(_categoriasMostrar[index])
                          .map((e) => Text(
                              '$e: ${_categoriaServicio.where((a) => a.nombre == _categoriasMostrar[index] && a.descripcion == e).length}',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade600)))
                          .toList(),
                    )

                    // Text(
                    //   'Monto: ${_categoriasMostrar[index].split(" - ")[2]}',
                    //   style:
                    //       TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    // ),
                    // Text(
                    //   'Codigo: ${_categoriasMostrar[index].split(" - ")[3]}',
                    //   style:
                    //       TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    // ),
                  ],
                ),
              ],
            ),
            // Row(
            //   children: <Widget>[
            //     GestureDetector(
            //       onTap: () {
            //         editServicio(context, _categoriasMostrar[index]);
            //       },
            //       child: Icon(
            //         Icons.edit,
            //         size: 30,
            //         color: Colors.grey[800],
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         deleteServicio(context, _categoriasMostrar[index]);
            //       },
            //       child: Icon(
            //         Icons.delete,
            //         size: 30,
            //         color: Colors.grey[800],
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

//FUNCION PARA EDITAR SERVICIO
Future editServicio(BuildContext context, Catalogo catalogoServicio) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text("Ingrese la siguiente info:"),
        content: FormServicioAdmin(
          catalogoServicio: catalogoServicio,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "CANCELAR",
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Container(
            width: 100,
            color: Colors.blueAccent,
            child: TextButton(
              child: Text(
                "EDITAR",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}

//FUNCION PARA CONFIRMAR ELIMINACION DE SERVICIO
Future deleteServicio(BuildContext context, Catalogo catalogoServicio) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text("Ingrese la siguiente info:"),
        content: Text(
          '¿Esta seguro que desea eliminar el servicio: ${catalogoServicio.nombre}?',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "CANCELAR",
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Container(
            width: 100,
            color: Colors.blueAccent,
            child: TextButton(
              child: Text(
                "ELIMINAR",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
