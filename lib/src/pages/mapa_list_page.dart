import 'dart:async';
import 'dart:io';

import 'package:admin_app/src/blocs/dispositivo_bloc.dart';
import 'package:admin_app/src/models/auth_model.dart';
import 'package:admin_app/src/models/dispositivo_model.dart';
import 'package:flutter/material.dart';

class MapaListPage extends StatefulWidget {
  @override
  _MapaListPageState createState() => _MapaListPageState();
}

class _MapaListPageState extends State<MapaListPage> {
  bool isClose = false;
  final dispositivosBloc = DispositivoBloc();
  AuthModel model;

  @override
  void dispose() {
    this.isClose = true;
  }

  @override
  Widget build(BuildContext context) {
    this.model = ModalRoute.of(context).settings.arguments;
    this.dispositivosBloc.getAllDispositivos(model.idAdmin);

    Timer.periodic(Duration(seconds: 10), (t) {
      print('Timer');
      this.dispositivosBloc.getAllDispositivos(model.idAdmin);
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de dispositivos'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'device_register');
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            this.dispositivosBloc.getAllDispositivos(model.idAdmin);
            setState(() {});
          },
        ),
        body: StreamBuilder(
          stream: this.dispositivosBloc.dispositivosStream,
          builder: (BuildContext ctx, AsyncSnapshot<List<DispositivoModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text('No hay dispositivos registrados'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, i) => Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (dir) {},
                    child: ListTile(
                      leading: Icon(
                        Icons.map,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Nombre: ' + snapshot.data[i].nombre),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            child: Text('Rutinas'),
                            onPressed: () {
                              Navigator.pushNamed(context, 'routines_list');
                            },
                          )
                        ],
                      ),
                      subtitle: Text('Lat: ' + snapshot.data[i].latitud + ' Lng: ' + snapshot.data[i].longitud),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, 'maps', arguments: snapshot.data[i]);
                      },
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
