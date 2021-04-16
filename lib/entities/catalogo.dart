import 'package:cloud_firestore/cloud_firestore.dart';

class Catalogo {
  String id;
  String nombre;
  String descripcion;

  Catalogo(this.nombre, this.descripcion);

  Catalogo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.id;
    this.nombre = documentSnapshot.data()['nombre'];
    this.descripcion = documentSnapshot.data()["descripcion"];
  }

  void setNombre(String nombre) {
    this.nombre = nombre;
  }

  void setDescripcion(String descripcion) {
    this.descripcion = descripcion;
  }

  String getNombre() {
    return this.nombre;
  }

  String getDescripcion() {
    return this.descripcion;
  }
}
