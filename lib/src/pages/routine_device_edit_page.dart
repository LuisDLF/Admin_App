import 'package:admin_app/src/models/dispositivo_model.dart';
import 'package:admin_app/src/models/task_model.dart';
import 'package:admin_app/src/providers/task_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RoutineDeviceEditPage extends StatefulWidget {
  @override
  _RoutineDeviceEditPageState createState() => _RoutineDeviceEditPageState();
}

class _RoutineDeviceEditPageState extends State<RoutineDeviceEditPage> {
  Position positionSelect;
  final _mapController = MapController();
  TaskModel model;
  String tipoMapa = 'streets';

  String name;
  String telefono;
  String rango;
  DateTime horaEntrada;
  DateTime horaSalida;
  double lat;
  double lng;

  bool isMap = false;

  Widget changePage(Size size) {
    final form = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          this._form(context),
        ],
      ),
    );
    final map = this.map(size);

    return (isMap) ? map : form;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    this.model = ModalRoute.of(context).settings.arguments;

//    if (this.positionSelect == null) {
//      this.getUserLocation();
//    }

    this.positionSelect = Position(latitude: this.model.lat, longitude: this.model.lon);

    this.horaEntrada = DateTime.parse(this.model.horaEntrada);
    this.horaSalida = DateTime.parse(this.model.horaSalida);

    this.name = model.nombre;
    this.telefono = model.telefono;
    this.rango = model.rango.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar rutina'),
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: (this.isMap) ? 0 : 40),
            width: size.width,
            height: size.height,
            child: this.changePage(size)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.gps_fixed),
        onPressed: () {
          this.getUserLocation();
        },
      ),
    );
  }

  actualizar() async {
    model.nombre = this.name;
    model.telefono = this.telefono;
    model.rango = int.parse(this.rango);
    model.lat = this.positionSelect.latitude;
    model.lon = this.positionSelect.longitude;
    model.horaEntrada = this.horaEntrada.toString();
    model.horaSalida = this.horaSalida.toString();
    final resp = await TaskProvider.service.update(model);
    if (resp) {
      Fluttertoast.showToast(
          msg: "La tarea se actualizo correctamente.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Lo sentimos algo esta mal, vuelva lo a intentar.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget _form(BuildContext context) {
    Widget latLng = Container();
    if (this.positionSelect != null) {
      latLng = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Lat: ' + this.positionSelect.latitude.toString()),
          Text('Lng: ' + this.positionSelect.longitude.toString()),
        ],
      );
    }

    if (this.horaEntrada == null) {
      this.horaEntrada = DateTime.now();
    }

    if (this.horaSalida == null) {
      this.horaSalida = DateTime.now();
    }

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            initialValue: this.model.telefono,
            onChanged: (val) => this.telefono = val,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Telefono',
            ),
          ),
          TextFormField(
            initialValue: this.model.nombre,
            onChanged: (val) => this.name = val,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Nombre de la rutina',
            ),
          ),
          TextFormField(
            initialValue: this.model.rango.toString(),
            onChanged: (val) => this.rango = val,
            style: TextStyle(color: Colors.black),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Rango (en metros)',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    this.isMap = true;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              latLng,
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cambiar hora de llegada'),
                      onPressed: () {
                        DatePicker.showTimePicker(context, locale: LocaleType.es, currentTime: this.horaEntrada,
                            onConfirm: (date) {
                          this.horaEntrada = date;
                          this.setState(() {});
                        });
                        setState(() {});
                      },
                    ),
                    Text(this.horaEntrada.hour.toString() +
                        ':' +
                        this.horaEntrada.minute.toString() +
                        ':' +
                        this.horaEntrada.second.toString()),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cambiar hora de salida'),
                      onPressed: () {
                        DatePicker.showTimePicker(context, locale: LocaleType.es, currentTime: this.horaSalida,
                            onConfirm: (date) {
                          this.horaSalida = date;
                          this.setState(() {});
                        });
                      },
                    ),
                    Text(this.horaSalida.hour.toString() +
                        ':' +
                        this.horaSalida.minute.toString() +
                        ':' +
                        this.horaSalida.second.toString()),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.white,
                    child: Text('Actualizar'),
                    onPressed: () {
                      this.actualizar();
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(child: Text('Cancelar'), onPressed: () => Navigator.pop(context))
                ],
              )),
        ],
      ),
    );
  }

  Future getUserLocation() async {
    this.positionSelect = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {});
  }

  Widget map(Size size) {
    return Stack(
      children: <Widget>[
        Container(
          child: FlutterMap(
            mapController: this._mapController,
            options: MapOptions(
              onTap: (LatLng val) {
                this.positionSelect = Position(latitude: val.latitude, longitude: val.longitude);
                setState(() {});
              },
              center: (this.positionSelect == null)
                  ? LatLng(0, 0)
                  : LatLng(this.positionSelect.latitude, this.positionSelect.longitude),
              zoom: 5,
            ),
            layers: [this._crearMapa(), this._crearMarcadores(context)],
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 80.0,
          child: Container(
            child: CupertinoButton(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              child: Text(
                'Seleccionar cordenadas',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                this.isMap = false;
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }

  TileLayerOptions _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken': 'pk.eyJ1IjoiZWxzaGVpbXVzIiwiYSI6ImNrNXBmaTl1bjA4M3Mzbm16eHRpMHp2YTkifQ.ZVkUNrlTNOXdLaRoFkUXOw',
          'id': 'mapbox.$tipoMapa'
        });
  }

  MarkerLayerOptions _crearMarcadores(BuildContext context) {
    if (this.positionSelect == null) {
      return MarkerLayerOptions();
    }

    return MarkerLayerOptions(markers: <Marker>[
      Marker(
        height: 100.0,
        width: 100.0,
        point: LatLng(this.positionSelect.latitude, this.positionSelect.longitude),
        builder: (BuildContext ctx) => Container(
            child: Icon(
          Icons.location_on,
          size: 45,
          color: Theme.of(context).primaryColor,
        )),
      )
    ]);
  }
}
