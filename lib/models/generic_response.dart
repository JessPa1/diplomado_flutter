// To parse this JSON data, do
//
//     final genericResponse = genericResponseFromJson(jsonString);

import 'dart:convert';

GenericResponse genericResponseFromJson(String str) =>
    GenericResponse.fromJson(json.decode(str));

String genericResponseToJson(GenericResponse data) =>
    json.encode(data.toJson());

class GenericResponse {
  GenericResponse({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  bool success;
  int error;
  String message;
  Data data;

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      GenericResponse(
        success: json["success"],
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.bolsas,
    this.categorias,
    this.comisionTipo,
    this.carriersTipo,
    this.carriers,
    this.productos,
  });

  List<Bolsa> bolsas;
  List<Categoria> categorias;
  List<Bolsa> comisionTipo;
  List<Bolsa> carriersTipo;
  List<Carrier> carriers;
  List<Producto> productos;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bolsas: List<Bolsa>.from(json["bolsas"].map((x) => Bolsa.fromJson(x))),
        categorias: List<Categoria>.from(
            json["categorias"].map((x) => Categoria.fromJson(x))),
        comisionTipo: List<Bolsa>.from(
            json["comisionTipo"].map((x) => Bolsa.fromJson(x))),
        carriersTipo: List<Bolsa>.from(
            json["carriersTipo"].map((x) => Bolsa.fromJson(x))),
        carriers: List<Carrier>.from(
            json["carriers"].map((x) => Carrier.fromJson(x))),
        productos: List<Producto>.from(
            json["productos"].map((x) => Producto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bolsas": List<dynamic>.from(bolsas.map((x) => x.toJson())),
        "categorias": List<dynamic>.from(categorias.map((x) => x.toJson())),
        "comisionTipo": List<dynamic>.from(comisionTipo.map((x) => x.toJson())),
        "carriersTipo": List<dynamic>.from(carriersTipo.map((x) => x.toJson())),
        "carriers": List<dynamic>.from(carriers.map((x) => x.toJson())),
        "productos": List<dynamic>.from(productos.map((x) => x.toJson())),
      };
}

class Bolsa {
  Bolsa({
    this.id,
    this.nombre,
  });

  String id;
  String nombre;

  factory Bolsa.fromJson(Map<String, dynamic> json) => Bolsa(
        id: json["ID"],
        nombre: json["Nombre"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Nombre": nombre,
      };
}

class Carrier {
  Carrier({
    this.id,
    this.nombre,
    this.logotipo,
    this.bolsaId,
    this.categoria,
    this.categoriaId,
    this.tipo,
    this.promos,
    this.comision,
    this.campos,
  });

  String id;
  String nombre;
  String logotipo;
  String bolsaId;
  String categoria;
  String categoriaId;
  String tipo;
  String promos;
  List<Comision> comision;
  List<Campo> campos;

  factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
        id: json["ID"],
        nombre: json["Nombre"],
        logotipo: json["Logotipo"],
        bolsaId: json["BolsaID"],
        categoria: json["Categoria"],
        categoriaId: json["CategoriaID"],
        tipo: json["Tipo"],
        promos: json["Promos"],
        comision: List<Comision>.from(
            json["Comision"].map((x) => Comision.fromJson(x))),
        campos: List<Campo>.from(json["Campos"].map((x) => Campo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Nombre": nombre,
        "Logotipo": logotipo,
        "BolsaID": bolsaId,
        "Categoria": categoria,
        "CategoriaID": categoriaId,
        "Tipo": tipo,
        "Promos": promos,
        "Comision": List<dynamic>.from(comision.map((x) => x.toJson())),
        "Campos": List<dynamic>.from(campos.map((x) => x.toJson())),
      };
}

class Campo {
  Campo({
    this.nombre,
    this.campo,
    this.min,
    this.max,
    this.formato,
    this.confirmar,
    this.obligatorio,
  });

  String nombre;
  String campo;
  String min;
  String max;
  String formato;
  String confirmar;
  String obligatorio;

  factory Campo.fromJson(Map<String, dynamic> json) => Campo(
        nombre: json["Nombre"],
        campo: json["Campo"],
        min: json["Min"],
        max: json["Max"],
        formato: json["Formato"],
        confirmar: json["Confirmar"],
        obligatorio: json["Obligatorio"],
      );

  Map<String, dynamic> toJson() => {
        "Nombre": nombre,
        "Campo": campo,
        "Min": min,
        "Max": max,
        "Formato": formato,
        "Confirmar": confirmar,
        "Obligatorio": obligatorio,
      };
}

class Comision {
  Comision({
    this.id,
    this.cargoTrans,
    this.tipoCargo,
    this.abonoTrans,
    this.tipoAbono,
    this.comisionCliente,
    this.defCargoTrans,
    this.defAbonoTrans,
    this.status,
  });

  String id;
  String cargoTrans;
  String tipoCargo;
  String abonoTrans;
  String tipoAbono;
  String comisionCliente;
  String defCargoTrans;
  String defAbonoTrans;
  String status;

  factory Comision.fromJson(Map<String, dynamic> json) => Comision(
        id: json["ID"],
        cargoTrans: json["CargoTrans"],
        tipoCargo: json["TipoCargo"],
        abonoTrans: json["AbonoTrans"],
        tipoAbono: json["TipoAbono"],
        comisionCliente: json["ComisionCliente"],
        defCargoTrans: json["def_CargoTrans"],
        defAbonoTrans: json["def_AbonoTrans"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CargoTrans": cargoTrans,
        "TipoCargo": tipoCargo,
        "AbonoTrans": abonoTrans,
        "TipoAbono": tipoAbono,
        "ComisionCliente": comisionCliente,
        "def_CargoTrans": defCargoTrans,
        "def_AbonoTrans": defAbonoTrans,
        "Status": status,
      };
}

class Categoria {
  Categoria({
    this.id,
    this.nombre,
    this.icono,
  });

  String id;
  String nombre;
  String icono;

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["ID"],
        nombre: json["Nombre"],
        icono: json["Icono"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Nombre": nombre,
        "Icono": icono,
      };
}

class Producto {
  Producto({
    this.bolsa,
    this.categoria,
    this.categoriaId,
    this.bolsaId,
    this.carrier,
    this.carrierId,
    this.codigo,
    this.monto,
    this.unidades,
    this.vigencia,
    this.descripcion,
  });

  String bolsa;
  String categoria;
  String categoriaId;
  String bolsaId;
  String carrier;
  String carrierId;
  String codigo;
  String monto;
  String unidades;
  String vigencia;
  String descripcion;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        bolsa: json["Bolsa"],
        categoria: json["Categoria"],
        categoriaId: json["CategoriaID"],
        bolsaId: json["BolsaID"],
        carrier: json["Carrier"],
        carrierId: json["CarrierID"],
        codigo: json["Codigo"],
        monto: json["Monto"],
        unidades: json["Unidades"],
        vigencia: json["Vigencia"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Bolsa": bolsa,
        "Categoria": categoria,
        "CategoriaID": categoriaId,
        "BolsaID": bolsaId,
        "Carrier": carrier,
        "CarrierID": carrierId,
        "Codigo": codigo,
        "Monto": monto,
        "Unidades": unidades,
        "Vigencia": vigencia,
        "Descripcion": descripcion,
      };
}
