import 'package:cloud_firestore/cloud_firestore.dart';

class Servicio {
  String id;
  String nombre;
  int fechaPago;
  double cantidad;
  String categoria;
  String usuario;
  String codigoProducto;

  Servicio(
      this.nombre, this.fechaPago, this.cantidad, this.categoria, this.usuario);

  Servicio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.id;
    this.nombre = documentSnapshot.data()['nombre'];
    this.fechaPago = documentSnapshot.data()["fechaPago"];
    this.cantidad = documentSnapshot.data()["cantidad"].toDouble();
    this.categoria = documentSnapshot.data()["categoria"];
    this.usuario = documentSnapshot.data()["usuario"];
    this.codigoProducto = documentSnapshot.data()["codigoProducto"];
  }
}
