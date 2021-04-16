import 'package:flutter/material.dart';
import 'package:flutter/src/animation/curves.dart';
import 'package:pago_servicios/components/rounded_button.dart';
import 'package:pago_servicios/screens/registration_screen.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  //declarar variable estatica para el welcomeScreen id
  //

  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('images/credit-card.png'),
                  height: 100,
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 190,
                  child: Text('APP PAGOS SERVICIOS',
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black)),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              title: 'Iniciar Sesión',
            ),
            RoundedButton(
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              title: 'Registrar cuenta',
            ),
          ],
        ),
      ),
    );
  }
}
