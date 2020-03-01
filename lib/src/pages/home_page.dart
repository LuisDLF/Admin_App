import 'package:admin_app/src/models/auth_model.dart';
import 'package:admin_app/src/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthProvider provider = AuthProvider.service;
  final formKey = GlobalKey<FormState>();
  String account;
  String password;

  @override
  Widget build(BuildContext context) {
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
              children: <Widget>[this._loginForm()],
            ),
          ),
        )
      ]),
    );
  }

  login(BuildContext context) async {
    AuthModel model = AuthModel();
    model.nombre = this.account;
    model.contrasena = this.password;
    model = await provider.login(model);
    if (model == null) {
      Fluttertoast.showToast(
          msg: "La cuenta o la contraseña es incorrecta",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.pushReplacementNamed(context, 'dispositivo_list', arguments: model);
    }
  }

  Widget _loginForm() {
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
                'Entrar',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                onChanged: (val) => this.account = val,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Cuenta',
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
                        child: Text('Entrar'),
                        onPressed: () => this.login(context),
                      ),
                      CupertinoButton(
                        child: Text(
                          'Crear una cuenta',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
