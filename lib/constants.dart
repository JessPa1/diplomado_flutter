import 'package:flutter/material.dart';
import 'package:pago_servicios/screens/reset_password.dart';
import 'package:pago_servicios/screens/welcome_screen.dart';

class Constants {
  static const String reset = 'Resetear contraseña';
  static const String logout = 'Cerrar Sesión';

  //TIPO USUARIO
  static const String admin = 'admin';
  static const String cliente = 'cliente';

  static const List<String> choices = <String>[reset, logout];

  static AppBar buildAppBar(BuildContext context, String title) {
    void choiceAction(String choice) {
      if (choice == Constants.reset) {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, ResetPassword.id);
      } else if (choice == Constants.logout) {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, WelcomeScreen.id);
      } else {
        Navigator.of(context).pop();
      }
    }

    return AppBar(
      actions: <Widget>[
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
        // IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
      ],
      title: Text(title),
    );
  }
}

class APIInfo {
  static const String key = 'ef8daab0154efcc9bc128889c7bc1156';
  static const String nip = 'cd48668567ea4831b2feb75b5475ef02';
  static const String url = 'taecel.com';
  static const String getProducts = '/app/api/getProducts';
  static const String requestTXN = '/app/api/RequestTXN';
}

class HTTPResponse {
  static const int okCode = 200;
  static const int badRequestCode = 400;
  static const int unAuthorizedCode = 401;
  static const int notFoundCode = 404;

  static const String ok = '¡EXITO!';
  static const String badRequest = '¡ERROR!';
  static const String notFound = '¡NO SE ENCONTRO LA INFORMACIÓN!';
  static const String unAuthorized = 'NO AUTORIZADO';

  static const Map<int, String> httpMapResponse = {
    okCode: ok,
    badRequestCode: badRequest,
    unAuthorizedCode: unAuthorized,
    notFoundCode: notFound
  };
}

class ErrorDialogs {
//FUNCION PARA CONFIRMAR ELIMINACION DE SERVICIO
  static Future confirmationMessage(
      BuildContext context, String code, String mensaje) {
    const kErrorTextStyle =
        TextStyle(fontSize: 25.0, fontFamily: 'Spartan MB', color: Colors.red);
    const kSuccessTextStyle = TextStyle(
        fontSize: 25.0, fontFamily: 'Spartan MB', color: Colors.green);

    String title =
        int.parse(code) == HTTPResponse.okCode ? '¡EXITO!' : '!ERROR!';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(
            child: Text(title,
                style: int.parse(code) == HTTPResponse.okCode
                    ? kSuccessTextStyle
                    : kErrorTextStyle),
          ),
          content: Text(
            mensaje,
            style: int.parse(code) == HTTPResponse.okCode
                ? kSuccessTextStyle
                : kErrorTextStyle,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "ACEPTAR",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
