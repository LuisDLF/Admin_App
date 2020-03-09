import 'package:admin_app/src/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  String name;
  String email;
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
              children: <Widget>[this._registerForm(context)],
            ),
          ),
        )
      ]),
    );
  }

  register(BuildContext context) async {
    if ((this.name != null && this.email != null && this.password != null) &&
        await AuthProvider.service.register(this.name, this.email, this.password)) {
      Fluttertoast.showToast(
          msg: "Se a registrado correctamente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pushReplacementNamed('home');
    } else {
      Fluttertoast.showToast(
          msg: "La inforamcio es incorrecta por favor vuelva a intetar",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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
                'Registarme',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                onChanged: (val) => this.name = val,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              TextFormField(
                onChanged: (val) => this.email = val,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
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
                        child: Text('Registrarme'),
                        onPressed: () => this.register(context),
                      ),
                      CupertinoButton(
                        child: Text(
                          'Ya tengo cuenta',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
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
