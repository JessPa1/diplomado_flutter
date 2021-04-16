import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pago_servicios/entities/servicio.dart';

class Usuario {
  String id;
  String correo;
  String tipoUsuario;
  String password;
  List<Servicio> servicios;

  Usuario(this.correo, this.tipoUsuario, this.servicios);
  Usuario.buildUserAdmin(this.correo, this.tipoUsuario);
  Usuario.buildUser(this.correo, this.password, this.tipoUsuario);
  Usuario.validateUser(this.correo, this.password, this.tipoUsuario);

  Usuario.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.id;
    this.correo = documentSnapshot.data()['correo'];
    this.password = documentSnapshot.data()["password"];
    this.tipoUsuario = documentSnapshot.data()["tipoUsuario"];
  }

  String getCorreo() {
    return this.correo;
  }

  String getTipoUsuario() {
    return this.tipoUsuario;
  }

  List<Servicio> getServicios() {
    return this.servicios;
  }

  void setCorreo(String correo) {
    this.correo = correo;
  }

  void setTipoUsuario(String tipoUsuario) {
    this.tipoUsuario = tipoUsuario;
  }

  void setServicios(List<Servicio> servicios) {
    this.servicios = servicios;
  }
}
