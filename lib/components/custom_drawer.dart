import 'package:flutter/material.dart';
import 'package:pago_servicios/models/data_container.dart';
import 'package:pago_servicios/screens/categorias_admin.dart';

import '../models/menu_item.dart';
import '../screens/agregar_servicio_screen.dart';
import '../screens/calendario_screen.dart';
import '../screens/pagos_screen.dart';
import '../screens/servicio_admin_screen.dart';
import '../screens/servicio_screen.dart';
import '../screens/usuarios_admin_screen.dart';
import 'custom_list_tile.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({
    Key key,
  }) : super(key: key);

  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.blueAccent, Colors.lightBlue])),
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/credit-card.png',
                          width: 80, height: 80),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.01),
                    child: Text(
                      'MENU PAGO DE SERVICIOS',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          ),
          DataContainer.usuario.tipoUsuario != 'admin'
              ?
              // //MENU USUARIO
              MenuUsuario()
              :
              //MENU DE ADMIN
              MenuAdmin(),
        ],
      ),
    );
  }
}

class MenuUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //MENU USUARIO
        CustomListTile(
          option: 'SERVICIOS',
          icon: Icons.send_rounded,
          widgets: [
            MenuItem('VER LISTA', ServicioScreen.id),
            MenuItem('AGREGAR', AgregarServicioScreen.id),
          ],
        ),
        CustomListTile(
            option: 'CALENDARIO',
            icon: Icons.calendar_today,
            rutaPrincipal: CalendarioScreen.id),
        CustomListTile(
            option: 'PAGOS',
            icon: Icons.credit_card,
            rutaPrincipal: PagosScreen.id),
      ],
    );
  }
}

class MenuAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomListTile(
          option: 'SERVICIOS',
          icon: Icons.send_rounded,
          rutaPrincipal: ServicioAdminScreen.id,
        ),
        CustomListTile(
          option: 'CATEGORIAS',
          icon: Icons.category,
          rutaPrincipal: CategoriasAdminScreen.id,
        ),
        CustomListTile(
          option: 'USUARIOS',
          icon: Icons.person_search_rounded,
          rutaPrincipal: UsuariosAdminScreen.id,
        ),
      ],
    );
  }
}
