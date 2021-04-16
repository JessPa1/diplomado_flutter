import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pago_servicios/components/form_servicio_pago.dart';

import '../components/custom_drawer.dart';
import '../constants.dart';
import '../controllers/servicios_controller.dart';
import '../entities/servicio.dart';
import '../models/data_container.dart';
import 'reset_password.dart';

final serviciosUsuarioDB =
    FirebaseFirestore.instance.collection('serviciosUsuario');

ServicioController _controller = ServicioController();
CollectionReference dbInstance =
    FirebaseFirestore.instance.collection('serviciosUsuario');

class ServicioScreen extends StatefulWidget {
  static const String id = 'servicio_screen';
  static List<Servicio> servicios = List<Servicio>();
  @override
  _ServicioScreenState createState() => _ServicioScreenState();
}

class _ServicioScreenState extends State<ServicioScreen> {
  List<Servicio> _servicios = List<Servicio>();
  List<Servicio> _serviciosMostrar = List<Servicio>();

  @override
  void initState() {
    super.initState();
  }

  void serviciosVarios(Servicio servicio) {
    setState(() {
      _serviciosMostrar.add(servicio);
      _servicios.add(servicio);
      _listItem(servicio);
    });
  }

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Servicios');
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
                        _serviciosMostrar = _servicios.where((s) {
                          var sNombe = s.nombre.toLowerCase();

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
                  this.cusSearchBar = Text('Servicios');
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _controller.getServiciosUsuario(DataContainer.usuario.correo),
          builder: (context, stream) {
            if (stream.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (stream.hasError) {
              return Center(child: Text(stream.error.toString()));
            }

            QuerySnapshot querySnapshot = stream.data;
            List<Servicio> serviciosLista = List();
            querySnapshot.docs.forEach((element) {
              serviciosLista.add(Servicio.fromDocumentSnapshot(element));
            });
            _servicios = serviciosLista;
            _serviciosMostrar = serviciosLista;
            DataContainer.serviciosUsuario = serviciosLista;

            if (serviciosLista.length == 0) {
              return Center(
                  child: Container(
                padding: EdgeInsets.all(40),
                child: Text('Aun no se agregan servicios',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ));
            }

            return ListView.builder(
              //length of my list
              itemCount: querySnapshot.size,
              //metodo responsable de crear los widgets
              itemBuilder: (context, index) => _listItem(
                  Servicio.fromDocumentSnapshot(querySnapshot.docs[index])),
            );
          }),
    );
  }

  _listItem(Servicio servicio) {
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
                      'Categoría: ${servicio.categoria}',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                    Text(
                      'Fecha Pago: ${DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(servicio.fechaPago))}',
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
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    editServicio(context, servicio);
                  },
                  child: Icon(
                    Icons.edit,
                    size: 30,
                    color: Colors.grey[800],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    deleteServicio(context, servicio);
                  },
                  child: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.grey[800],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//FUNCION PARA EDITAR SERVICIO
Future editServicio(BuildContext context, Servicio servicio) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text("Ingrese la siguiente info:"),
        content: FormServicioPago(
          servicio: servicio,
          textoBoton: 'Editar',
        ),
      );
    },
  );
}

//FUNCION PARA CONFIRMAR ELIMINACION DE SERVICIO
Future deleteServicio(BuildContext context, Servicio servicio) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text("Ingrese la siguiente info:"),
        content: Text(
          '¿Esta seguro que desea eliminar el servicio: ${servicio.nombre}?',
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
                _controller.deleteServicioUsuario(context, servicio.id);
              },
            ),
          ),
        ],
      );
    },
  );
}
