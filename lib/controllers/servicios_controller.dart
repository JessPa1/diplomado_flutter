import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';
import '../models/data_container.dart';

final serviciosUsuarioDB =
    FirebaseFirestore.instance.collection('serviciosUsuario');

final historialPagosUsuarioDB =
    FirebaseFirestore.instance.collection('historialPagos');

class ServicioController {
//constructor
  ServicioController();

  //TRAER SERVICIOS DE USUARIO
  Stream<QuerySnapshot> getServiciosUsuario(String correo) {
    var stream =
        serviciosUsuarioDB.where("usuario", isEqualTo: correo).snapshots();
    Stream<QuerySnapshot> snapshotUsuario = stream;

    return snapshotUsuario;
  }

  //TRAER TODOS LOS SERVICIOS USUARIO
  void getAllServiciosUsuario() {
    var stream = serviciosUsuarioDB
        .where("tipoUsuario", isEqualTo: 'cliente')
        .snapshots();
    Stream<QuerySnapshot> snapshotUsuario = stream;
  }

//AGREGAR O ACTUALIZAR SERIVCIO DEPENDIENDO EL ID
  void addUpdateServicio(BuildContext context, String id, String nombre,
      int fechaPago, String codigoProducto) {
    var arreglo = nombre.split(" - ");
    String nombreCorto = arreglo[0];
    String categoria = arreglo[1];
    double cantidad = double.parse(arreglo[2]);
    try {
      if (id != null) {
        //ACTUALIZAR
        serviciosUsuarioDB.doc(id).update({
          'nombre': nombreCorto,
          'categoria': categoria,
          'cantidad': cantidad,
          'fechaPago': fechaPago,
          'codigoProducto': codigoProducto
        }).then((value) {
          Navigator.of(context).pop();
          ErrorDialogs.confirmationMessage(
              context, "200", 'El servicio fue actualizado correctamente');
        });
      } else {
        //AGREGAR SERVICIO NUEVO
        serviciosUsuarioDB.doc().set({
          'nombre': nombreCorto,
          'categoria': categoria,
          'cantidad': cantidad,
          'fechaPago': fechaPago,
          'usuario': DataContainer.usuario.correo,
          'codigoProducto': codigoProducto
        }).then((value) {
          Navigator.of(context).pop();
          ErrorDialogs.confirmationMessage(
              context, "200", 'El servicio fue agregado correctamente');
        });
      }
    } on Exception catch (e) {
      Navigator.of(context).pop();
      ErrorDialogs.confirmationMessage(
          context, "400", 'Por el momento no se pueden registrar su usuario');
    }
  }

  // //REGISTRAR HISTORIAL PAGO
  // void addReciboPago(String servicio, String numTrans, int fechaPago) {
  //   try {
  //     //AGREGAR SERVICIO NUEVO
  //     serviciosUsuarioDB.doc().set({
  //       'servicio': servicio,
  //       'numTrans': numTrans,
  //       'fechaPago': fechaPago,
  //       'usuario': DataContainer.usuario.correo,
  //     }).then((value) => print("Se guardo recibo"));
  //   } on Exception catch (e) {}
  // }

  //ELIMINAR UN SERVICIO DE USUARIO
  void deleteServicioUsuario(BuildContext context, String id) {
    try {
      historialPagosUsuarioDB.doc(id).delete().then((value) {
        Navigator.of(context).pop();
        ErrorDialogs.confirmationMessage(
            context, "200", 'El servicio fue eliminado correctamente');
      });
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  //PAGAR UN SERVICIO

}
