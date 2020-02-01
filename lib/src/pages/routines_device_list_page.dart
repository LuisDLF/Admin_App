import 'package:flutter/material.dart';

class RoutinesDeviceListPage extends StatefulWidget {
  @override
  _RoutinesDeviceListPageState createState() => _RoutinesDeviceListPageState();
}

class _RoutinesDeviceListPageState extends State<RoutinesDeviceListPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de rutinas'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'routine_register');
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {});
          },
        ),
        body: Container(
          child: Center(
            child: Text('Rutinas no disponibles en estos momentos'),
          ),
        )
    );
  }
}
