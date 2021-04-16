import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pago_servicios/entities/servicio.dart';

class DataBase {
  final serviciosUsuarioDB =
      FirebaseFirestore.instance.collection('serviciosUsuario');
  final serviciosDB = FirebaseFirestore.instance.collection('servicios');

  Future<void> addServicioUsuario(Servicio servicio) async {
    try {
      await serviciosUsuarioDB.add({
        'nombre': servicio.nombre,
        'categoria': servicio.categoria,
        'cantidad': servicio.cantidad,
        'fechaPago': servicio.fechaPago,
        'usuario': servicio.usuario, 
      });
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> updateServicioUusario(Servicio servicio) async {
    try {
      await serviciosUsuarioDB.doc(servicio.id).update({
        'nombre': servicio.nombre,
        'categoria': servicio.categoria,
        'cantidad': servicio.cantidad,
        'fechaPago': servicio.fechaPago,
      });
    } catch (err) {
      print(err);
      rethrow;
    }
  }

//SOLO LOS USUARIOS FINALES PUEDEN ELIMINAR REGISTRO
  Future<void> deleteServicioUusario(Servicio servicio) async {
    try {
      await serviciosUsuarioDB.doc(servicio.id).delete();
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Stream<List<Servicio>> getServiciosUsuarios() {
    return serviciosUsuarioDB.snapshots().map((QuerySnapshot query) {
      List<Servicio> retVal = List();
      query.docs.forEach((element) {
        retVal.add(Servicio.fromDocumentSnapshot(element));
      });

      return retVal;
    });
  }
}
