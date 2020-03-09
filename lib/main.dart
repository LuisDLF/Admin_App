
import 'package:admin_app/src/pages/device_register_page.dart';
import 'package:admin_app/src/pages/home_page.dart';
import 'package:admin_app/src/pages/mapa_list_page.dart';
import 'package:admin_app/src/pages/maps_page.dart';
import 'package:admin_app/src/pages/register_page.dart';
import 'package:admin_app/src/pages/routine_device_edit_page.dart';
import 'package:admin_app/src/pages/routine_device_register_page.dart';
import 'package:admin_app/src/pages/routines_device_list_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: {
        'home': (BuildContext ctx) => HomePage(),
        'register': (BuildContext ctx) => RegisterPage(),
        'device_register': (BuildContext ctx) => DeviceRegisterPage(),
        'routine_register': (BuildContext ctx) => RoutineDeviceRegisterPage(),
        'routine_edit': (BuildContext ctx) => RoutineDeviceEditPage(),
        'dispositivo_list': (BuildContext ctx) => MapaListPage(),
        'routines_list': (BuildContext ctx) => RoutinesDeviceListPage(),
        'maps': (BuildContext ctx) => MapsPage(),
      },
    );
  }
}
