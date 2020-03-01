import 'package:admin_app/src/blocs/task_bloc.dart';
import 'package:admin_app/src/models/dispositivo_model.dart';
import 'package:admin_app/src/models/task_model.dart';
import 'package:flutter/material.dart';

class RoutinesDeviceListPage extends StatefulWidget {
  @override
  _RoutinesDeviceListPageState createState() => _RoutinesDeviceListPageState();
}

class _RoutinesDeviceListPageState extends State<RoutinesDeviceListPage> {
  final TaskBloc bloc = TaskBloc();
  DispositivoModel model;

  Widget build(BuildContext context) {
    this.model = ModalRoute.of(context).settings.arguments;
    this.bloc.getAllTask(this.model.idDispositivo);

    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de rutinas'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'routine_register', arguments: this.model);
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            this.bloc.getAllTask(model.idDispositivo);
            setState(() {});
          },
        ),
        body: StreamBuilder(
          stream: this.bloc.taskStream,
          builder: (BuildContext ctx, AsyncSnapshot<List<TaskModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text('No hay tareas registradas'),
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
                        Icons.assignment,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Row(
                        children: <Widget>[
                          Expanded(
                            child:
                                Text('Nombre: ' + ((snapshot.data[i].nombre == null) ? '' : snapshot.data[i].nombre)),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {},
                          )
                        ],
                      ),
                      subtitle: Column(
                        children: <Widget>[
                          Text('Rango: ' + snapshot.data[i].rango.toString() + 'M'),
                          Text('Lat: ' + snapshot.data[i].lat.toString() + ' Lng: ' + snapshot.data[i].lon.toString()),
                        ],
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
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
