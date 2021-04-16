import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pago_servicios/screens/categorias_admin.dart';

import 'screens/agregar_servicio_screen.dart';
import 'screens/calendario_screen.dart';
import 'screens/login_screen.dart';
import 'screens/pagos_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/reset_password.dart';
import 'screens/servicio_admin_screen.dart';
import 'screens/servicio_screen.dart';
import 'screens/usuarios_admin_screen.dart';
import 'screens/welcome_screen.dart';

//void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),

        //PANTALLAS DE USUARIO
        ServicioScreen.id: (context) => ServicioScreen(),
        AgregarServicioScreen.id: (context) => AgregarServicioScreen(),
        CalendarioScreen.id: (context) => CalendarioScreen(),
        PagosScreen.id: (context) => PagosScreen(),

        //PANTALLAS DE ADMIN
        ServicioAdminScreen.id: (context) => ServicioAdminScreen(),
        CategoriasAdminScreen.id: (context) => CategoriasAdminScreen(),
        UsuariosAdminScreen.id: (context) => UsuariosAdminScreen(),

        //PAGINA PARA RESETEAR CONTRASEÑA
        ResetPassword.id: (context) => ResetPassword(),
      },
      home: WelcomeScreen(),
    );
  }
}
