
import 'package:admin_app/src/pages/home_page.dart';
import 'package:admin_app/src/pages/mapa_list_page.dart';
import 'package:admin_app/src/pages/maps_page.dart';
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
        'dispositivo_list': (BuildContext ctx) => MapaListPage(),
        'maps': (BuildContext ctx) => MapsPage(),
      },
    );
  }
}
