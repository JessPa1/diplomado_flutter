// To parse this JSON data, do
//
//     final genericResponseProducts = genericResponseProductsFromJson(jsonString);

import 'dart:convert';

GenericResponseProducts genericResponseProductsFromJson(String str) =>
    GenericResponseProducts.fromJson(json.decode(str));

String genericResponseProductsToJson(GenericResponseProducts data) =>
    json.encode(data.toJson());

class GenericResponseProducts {
  GenericResponseProducts({
    this.success,
    this.error,
    this.message,
    this.data,
    this.extra,
  });

  bool success;
  int error;
  String message;
  Data data;
  dynamic extra;

  factory GenericResponseProducts.fromJson(Map<String, dynamic> json) =>
      GenericResponseProducts(
        success: json["success"],
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        extra: json["extra"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "message": message,
        "data": data.toJson(),
        "extra": extra,
      };
}

class Data {
  Data({
    this.bolsas,
    this.categorias,
    this.comisionTipo,
    this.carriersTipo,
    this.formatoCampos,
    this.carriers,
    this.productos,
  });

  List<Bolsa> bolsas;
  List<CategoriaElement> categorias;
  List<Bolsa> comisionTipo;
  List<CarriersTipo> carriersTipo;
  List<Bolsa> formatoCampos;
  List<Carrier> carriers;
  List<Producto> productos;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bolsas: List<Bolsa>.from(json["bolsas"].map((x) => Bolsa.fromJson(x))),
        categorias: List<CategoriaElement>.from(
            json["categorias"].map((x) => CategoriaElement.fromJson(x))),
        comisionTipo: List<Bolsa>.from(
            json["comisionTipo"].map((x) => Bolsa.fromJson(x))),
        carriersTipo: List<CarriersTipo>.from(
            json["carriersTipo"].map((x) => CarriersTipo.fromJson(x))),
        formatoCampos: List<Bolsa>.from(
            json["formatoCampos"].map((x) => Bolsa.fromJson(x))),
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
        "formatoCampos":
            List<dynamic>.from(formatoCampos.map((x) => x.toJson())),
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
    this.getSaldo,
    this.comision,
    this.campos,
  });

  String id;
  String nombre;
  String logotipo;
  String bolsaId;
  CategoriaEnum categoria;
  String categoriaId;
  String tipo;
  String promos;
  String getSaldo;
  Comision comision;
  List<CampoElement> campos;

  factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
        id: json["ID"],
        nombre: json["Nombre"],
        logotipo: json["Logotipo"],
        bolsaId: json["BolsaID"],
        categoria: categoriaEnumValues.map[json["Categoria"]],
        categoriaId: json["CategoriaID"],
        tipo: json["Tipo"],
        promos: json["Promos"],
        getSaldo: json["getSaldo"],
        comision: Comision.fromJson(json["Comision"]),
        campos: List<CampoElement>.from(
            json["Campos"].map((x) => CampoElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Nombre": nombre,
        "Logotipo": logotipo,
        "BolsaID": bolsaId,
        "Categoria": categoriaEnumValues.reverse[categoria],
        "CategoriaID": categoriaId,
        "Tipo": tipo,
        "Promos": promos,
        "getSaldo": getSaldo,
        "Comision": comision.toJson(),
        "Campos": List<dynamic>.from(campos.map((x) => x.toJson())),
      };
}

class CampoElement {
  CampoElement({
    this.nombre,
    this.campo,
    this.min,
    this.max,
    this.formato,
    this.confirmar,
    this.obligatorio,
    this.iniCero,
  });

  String nombre;
  CampoEnum campo;
  String min;
  String max;
  String formato;
  String confirmar;
  String obligatorio;
  String iniCero;

  factory CampoElement.fromJson(Map<String, dynamic> json) => CampoElement(
        nombre: json["Nombre"],
        campo: campoEnumValues.map[json["Campo"]],
        min: json["Min"],
        max: json["Max"],
        formato: json["Formato"],
        confirmar: json["Confirmar"],
        obligatorio: json["Obligatorio"],
        iniCero: json["iniCero"],
      );

  Map<String, dynamic> toJson() => {
        "Nombre": nombre,
        "Campo": campoEnumValues.reverse[campo],
        "Min": min,
        "Max": max,
        "Formato": formato,
        "Confirmar": confirmar,
        "Obligatorio": obligatorio,
        "iniCero": iniCero,
      };
}

enum CampoEnum { REFERENCIA }

final campoEnumValues = EnumValues({"referencia": CampoEnum.REFERENCIA});

enum CategoriaEnum { TIEMPO_AIRE, PAQUETES, SERVICIOS, GIFT_CARDS }

final categoriaEnumValues = EnumValues({
  "GiftCards": CategoriaEnum.GIFT_CARDS,
  "Paquetes": CategoriaEnum.PAQUETES,
  "Servicios": CategoriaEnum.SERVICIOS,
  "Tiempo Aire": CategoriaEnum.TIEMPO_AIRE
});

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

class CarriersTipo {
  CarriersTipo({
    this.id,
    this.nombre,
    this.descripcion,
  });

  String id;
  String nombre;
  String descripcion;

  factory CarriersTipo.fromJson(Map<String, dynamic> json) => CarriersTipo(
        id: json["ID"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}

class CategoriaElement {
  CategoriaElement({
    this.id,
    this.nombre,
    this.icono,
  });

  String id;
  CategoriaEnum nombre;
  String icono;

  factory CategoriaElement.fromJson(Map<String, dynamic> json) =>
      CategoriaElement(
        id: json["ID"],
        nombre: categoriaEnumValues.map[json["Nombre"]],
        icono: json["Icono"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Nombre": categoriaEnumValues.reverse[nombre],
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
    this.nombre,
  });

  BolsaEnum bolsa;
  CategoriaEnum categoria;
  String categoriaId;
  String bolsaId;
  String carrier;
  String carrierId;
  String codigo;
  String monto;
  String unidades;
  String vigencia;
  String descripcion;
  Nombre nombre;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        bolsa: bolsaEnumValues.map[json["Bolsa"]],
        categoria: categoriaEnumValues.map[json["Categoria"]],
        categoriaId: json["CategoriaID"],
        bolsaId: json["BolsaID"],
        carrier: json["Carrier"],
        carrierId: json["CarrierID"],
        codigo: json["Codigo"],
        monto: json["Monto"],
        unidades: json["Unidades"],
        vigencia: json["Vigencia"],
        descripcion: json["Descripcion"],
        nombre: nombreValues.map[json["Nombre"]],
      );

  Map<String, dynamic> toJson() => {
        "Bolsa": bolsaEnumValues.reverse[bolsa],
        "Categoria": categoriaEnumValues.reverse[categoria],
        "CategoriaID": categoriaId,
        "BolsaID": bolsaId,
        "Carrier": carrier,
        "CarrierID": carrierId,
        "Codigo": codigo,
        "Monto": monto,
        "Unidades": unidades,
        "Vigencia": vigencia,
        "Descripcion": descripcion,
        "Nombre": nombreValues.reverse[nombre],
      };
}

enum BolsaEnum { TIEMPO_AIRE, PAGO_DE_SERVICIOS }

final bolsaEnumValues = EnumValues({
  "Pago de Servicios": BolsaEnum.PAGO_DE_SERVICIOS,
  "Tiempo Aire": BolsaEnum.TIEMPO_AIRE
});

enum Nombre {
  EMPTY,
  PAQUETE_DE_50_TIMBRES_CFDI,
  PAQUETE_DE_100_TIMBRES_CFDI,
  PAQUETE_DE_200_TIMBRES_CFDI,
  COMPLEMENTOS_Y_ADDENDAS_20_CFDI,
  PAQUETE_DE_500_TIMBRES_CFDI,
  PAQUETE_DE_1000_TIMBRES_CFDI,
  PAQUETE_DE_2000_TIMBRES_CFDI,
  PAQUETE_DE_5000_TIMBRES_CFDI,
  PAQUETE_DE_10000_TIMBRES_CFDI,
  PAQUETE_DE_20000_TIMBRES_CFDI,
  THE_1_BOLETO_SALA_TRADICIONAL,
  COMBO_PALOMITAS_SALA_TRADICIONAL,
  COMBO_PALOMITAS_SALA_VIP,
  THE_1_BOLETO_SALA_VIP,
  THE_5_BOLETOS_SALA_TRADICIONAL
}

final nombreValues = EnumValues({
  "Combo Palomitas Sala Tradicional": Nombre.COMBO_PALOMITAS_SALA_TRADICIONAL,
  "Combo Palomitas Sala VIP": Nombre.COMBO_PALOMITAS_SALA_VIP,
  "Complementos y Addendas + 20 CFDI ": Nombre.COMPLEMENTOS_Y_ADDENDAS_20_CFDI,
  "": Nombre.EMPTY,
  "Paquete de 10,000 Timbres CFDI": Nombre.PAQUETE_DE_10000_TIMBRES_CFDI,
  "Paquete de 1,000 Timbres CFDI": Nombre.PAQUETE_DE_1000_TIMBRES_CFDI,
  "Paquete de 100 Timbres CFDI": Nombre.PAQUETE_DE_100_TIMBRES_CFDI,
  "Paquete de 20,000 Timbres CFDI": Nombre.PAQUETE_DE_20000_TIMBRES_CFDI,
  "Paquete de 2,000 Timbres CFDI": Nombre.PAQUETE_DE_2000_TIMBRES_CFDI,
  "Paquete de 200 Timbres CFDI": Nombre.PAQUETE_DE_200_TIMBRES_CFDI,
  "Paquete de 5,000 Timbres CFDI": Nombre.PAQUETE_DE_5000_TIMBRES_CFDI,
  "Paquete de 500 Timbres CFDI": Nombre.PAQUETE_DE_500_TIMBRES_CFDI,
  "Paquete de 50 Timbres CFDI": Nombre.PAQUETE_DE_50_TIMBRES_CFDI,
  "1 Boleto Sala Tradicional": Nombre.THE_1_BOLETO_SALA_TRADICIONAL,
  "1 Boleto Sala VIP": Nombre.THE_1_BOLETO_SALA_VIP,
  "5 Boletos Sala Tradicional": Nombre.THE_5_BOLETOS_SALA_TRADICIONAL
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
