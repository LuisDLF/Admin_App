import 'dart:async';

import 'package:admin_app/src/providers/dispositivo_provider.dart';
import 'package:admin_app/src/models/dispositivo_model.dart';
import 'package:admin_app/src/blocs/dispositivo_bloc.dart';
import 'package:admin_app/src/models/auth_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class MapaListPage extends StatefulWidget {
  @override
  _MapaListPageState createState() => _MapaListPageState();
}

class _MapaListPageState extends State<MapaListPage> {
  final dispositivosBloc = DispositivoBloc();
  Timer timer;
  AuthModel model;

  @override
  void dispose() {
    this.timer.cancel();
  }

  delete(int id) async {
    if (await DispositivosProvider.service.delete(id)) {
      Fluttertoast.showToast(
          msg: "Se a eliminado correctamente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error vuelva a intentar",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    this.dispositivosBloc.getAllDispositivos(model.idAdmin);
  }

  @override
  Widget build(BuildContext context) {
    this.model = ModalRoute.of(context).settings.arguments;
    this.dispositivosBloc.getAllDispositivos(model.idAdmin);

    if (this.timer == null) {
      this.timer = Timer.periodic(Duration(seconds: 10), (t) {
        print('Timer: ' + DateTime.now().toString());
        this.dispositivosBloc.getAllDispositivos(model.idAdmin);
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de dispositivos'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'device_register', arguments: this.model);
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
                            onPressed: () => this.delete(snapshot.data[i].idDispositivo),
                          ),
                          RaisedButton(
                            child: Text('Tareas'),
                            onPressed: () {
                              Navigator.pushNamed(context, 'routines_list', arguments: snapshot.data[i]);
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
