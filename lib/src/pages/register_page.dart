import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

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
                  colors: [Colors.blue, Colors.white])),
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
              Text('Registarme', style: TextStyle(color: Colors.white, fontSize: 30),),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Cuenta',
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Validar contraseña',
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
                      onPressed: () {
                        Navigator.pushNamed(context, 'dispositivo_list');
                      },
                    ),
                    CupertinoButton(
                      child: Text('Ya tengo cuenta'),
                      onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
