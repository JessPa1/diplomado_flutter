import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pago_servicios/constants.dart';
import 'package:pago_servicios/entities/usuario.dart';
import 'package:pago_servicios/models/data_container.dart';
import 'package:pago_servicios/screens/servicio_admin_screen.dart';
import 'package:pago_servicios/screens/servicio_screen.dart';

final usuarioDB = FirebaseFirestore.instance.collection('usuarios');

class UsuarioController {
//constructor
  UsuarioController();

//VERIFICAR USUARIO
  validateUser(String correo, String password, BuildContext context) {
    usuarioDB.where("correo", isEqualTo: correo).snapshots().listen((result) {
      var resultado = result.docs[0];
      print(resultado.data());
      if (resultado.data()['password'] == password) {
        DataContainer.usuario = Usuario.fromDocumentSnapshot(resultado);
        if (resultado.data()['tipoUsuario'] == Constants.admin) {
          Navigator.pushNamed(context, ServicioAdminScreen.id);
        } else {
          Navigator.pushNamed(context, ServicioScreen.id);
        }
      } else {
        ErrorDialogs.confirmationMessage(
            context, "400", 'Contraseña o correo invalidos');
        // Navigator.of(context).pop();
      }
    });
  }

  Stream<QuerySnapshot> getAllUser() {
    var stream = usuarioDB.snapshots();
    Stream<QuerySnapshot> snapshotUsuario = stream;

    return snapshotUsuario;
  }

//REGISTRAR USUARIO
  void registrarCuenta(BuildContext context, String correo, String password) {
    try {
      usuarioDB.doc().set({
        "correo": correo,
        "password": password,
        "tipoUsuario": Constants.cliente
      }).then((value) {
        DataContainer.usuario =
            Usuario.buildUser(correo, password, Constants.cliente);

        Navigator.pushNamed(context, ServicioScreen.id);
      });
    } on Exception catch (e) {
      ErrorDialogs.confirmationMessage(
          context, "400", 'Por el momento no se pueden registrar su usuario');
      // TODO
    }
  }

//ELIMINAR UN SERVICIO DE USUARIO
  void changePassword(BuildContext context, String id, String password) {
    try {
      usuarioDB.doc(id).update({"password": password}).then((value) {
        Navigator.of(context).pop();
        ErrorDialogs.confirmationMessage(
            context, "200", 'La contraseña fue cambiada');
      });
    } on Exception catch (e) {}
  }
}
