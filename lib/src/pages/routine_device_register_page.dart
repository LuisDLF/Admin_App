import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutineDeviceRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text('Registrar nueva rutina'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              width: size.width,
              height: size.height,
              child: Column(
                children: <Widget>[
                  this._form(context),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _form(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Nombre de la rutina',
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Rango (en metros)',
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Hora de llegada',
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Hora de salida',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {},
                ),
              )
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
                    child: Text('Registrar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                      child: Text('Cancelar registro'),
                      onPressed: () => Navigator.pop(context)
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}
