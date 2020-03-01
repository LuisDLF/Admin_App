import 'package:admin_app/src/blocs/dispositivo_bloc.dart';
import 'package:admin_app/src/models/auth_model.dart';
import 'package:admin_app/src/models/dispositivo_model.dart';
import 'package:admin_app/src/providers/dispositivo_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeviceRegisterPage extends StatefulWidget {
  @override
  _DeviceRegisterPageState createState() => _DeviceRegisterPageState();
}

class _DeviceRegisterPageState extends State<DeviceRegisterPage> {
  final formKey = GlobalKey<FormState>();
  AuthModel auth;
  String name;
  String password;

  @override
  Widget build(BuildContext context) {
    this.auth = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromRGBO(27, 109, 193, 1), Color.fromRGBO(27, 109, 193, 1)])),
        ),
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[this._registerForm(context)],
            ),
          ),
        )
      ]),
    );
  }

  Future<int> registerDevice(String name, String password) async {
    DispositivoModel model = DispositivoModel();
    model.idAdmin = this.auth.idAdmin;
    model.nombre = name;
    model.contrasena = password;
    final bool resp = await DispositivosProvider.service.register(model);
    if (resp) {
      Fluttertoast.showToast(
          msg: "El dispocitivo se registro correctamente.",
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
    return 0;
  }

  Widget _registerForm(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: this.formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(image: AssetImage('assets/imgs/walk_safe.png'))),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Registrar dispositivo',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                onChanged: (val) => this.name = val,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Nombre del dispositivo',
                ),
              ),
              TextFormField(
                onChanged: (val) => this.password = val,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.white,
                        child: Text('Registrar'),
                        onPressed: () {
                          this.registerDevice(this.name, this.password);
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoButton(
                          child: Text(
                            'Cancelar registro',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => Navigator.pop(context))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
