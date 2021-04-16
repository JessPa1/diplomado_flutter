import 'package:flutter/material.dart';
import 'package:pago_servicios/components/custom_drawer.dart';
import 'package:pago_servicios/components/rounded_button.dart';
import 'package:pago_servicios/controllers/usuario_controller.dart';
import 'package:pago_servicios/models/data_container.dart';

import '../constants.dart';

UsuarioController _controller = UsuarioController();

class ResetPassword extends StatefulWidget {
  static const String id = 'reset_password';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String _password;
  String _confirmacion;
  bool _showError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.buildAppBar(context, 'Resetear Contraseña'),
      drawer: DrawerCustom(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 70, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 190.0,
                child: Image.asset('images/reset.png'),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Contraseña nueva',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    if (_password != value) {
                      _showError = !_showError;
                    } else {
                      _confirmacion = value;
                    }
                  });
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Confirmar Contraseña',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              _showError
                  ? Center(
                      child: Text(
                      'Las contraseñas no coinciden',
                      style: TextStyle(color: Colors.red),
                    ))
                  : SizedBox(),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                onPressed: () {
                  _controller.changePassword(
                      context, DataContainer.usuario.id, _password);
                },
                title: 'Resetear',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.reset) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }
}
