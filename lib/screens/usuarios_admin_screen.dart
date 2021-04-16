import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pago_servicios/controllers/servicios_controller.dart';
import 'package:pago_servicios/controllers/usuario_controller.dart';
import 'package:pago_servicios/entities/usuario.dart';

import '../components/custom_drawer.dart';
import '../constants.dart';
import '../entities/servicio.dart';
import '../models/data_container.dart';
import 'reset_password.dart';

UsuarioController _controller = UsuarioController();
ServicioController _controllerServicio = ServicioController();

class UsuariosAdminScreen extends StatefulWidget {
  static const String id = 'usuarios_admin';
  static List<Usuario> servicios = List<Usuario>();
  @override
  _UsuariosAdminScreenState createState() => _UsuariosAdminScreenState();
}

class _UsuariosAdminScreenState extends State<UsuariosAdminScreen> {
  List<Usuario> _usuarios = List<Usuario>();
  List<Usuario> _usuariosMostrar = List<Usuario>();

  @override
  void initState() {
    super.initState();
  }

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Usuarios');
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
                        _usuariosMostrar = _usuarios.where((s) {
                          var sNombe = s.correo.toLowerCase();

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
                  this.cusSearchBar = Text('Usuarios');
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
          stream: _controller.getAllUser(),
          builder: (context, stream) {
            if (stream.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (stream.hasError) {
              return Center(child: Text(stream.error.toString()));
            }

            QuerySnapshot querySnapshot = stream.data;
            List<Usuario> usuariosLista = List();
            querySnapshot.docs.forEach((element) {
              usuariosLista.add(Usuario.fromDocumentSnapshot(element));
            });
            _usuarios = usuariosLista;
            _usuariosMostrar = usuariosLista;

            if (usuariosLista.length == 0) {
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
                  Usuario.fromDocumentSnapshot(querySnapshot.docs[index])),
            );
          }),
    );
  }

  _listItem(Usuario usuario) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 32, bottom: 32, left: 16.0, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        usuario.correo,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),

                      //MONSTRAR INFO DE CADA USER
                      StreamBuilder<QuerySnapshot>(
                          stream: _controllerServicio
                              .getServiciosUsuario(usuario.correo),
                          builder: (context, stream) {
                            if (stream.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (stream.hasError) {
                              return Center(
                                  child: Text(stream.error.toString()));
                            }

                            QuerySnapshot querySnapshot = stream.data;
                            List<Servicio> servicios = List();
                            querySnapshot.docs.forEach((element) {
                              servicios
                                  .add(Servicio.fromDocumentSnapshot(element));
                            });

                            if (servicios.length == 0) {
                              return Text('El usuario aun no agrega servicios',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 16));
                            }

                            return ServiciosUsuario(servicios: servicios);
                          })
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ServiciosUsuario extends StatelessWidget {
  final List<Servicio> servicios;

  List<String> listaSet() {
    List<String> list = servicios.map((e) => e.categoria).toSet().toList();
    return list;
  }

  const ServiciosUsuario({Key key, @required this.servicios}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total de Servicios: ${servicios.length}',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600),
          ),
          SingleChildScrollView(
            child: Column(
                children: listaSet()
                    .map(
                      (e) => Text(
                        '$e: ${servicios.where((d) => d.categoria == e).length}',
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade600),
                      ),
                    )
                    .toList()),
          )
        ],
      ),
    );
  }
}
