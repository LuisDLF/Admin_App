import 'dart:convert';

import 'package:admin_app/src/blocs/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:admin_app/src/models/auth_model.dart';

class AuthProvider {
  static final AuthProvider service = AuthProvider._();

  AuthProvider._();

  Future<bool> register(String name, String email, String password) async {
    final dataRaw = await http.post('http://sotepsa.com/services/Register_Admin.php',
        body: {'Nombre': name, 'Correo': email, 'Contrasena': password});
    final data = json.decode(dataRaw.body);
    print(data);
    return (data == 1) ? true : false;
  }

  Future<AuthModel> login(AuthModel model) async {
    if (model.nombre == null || model.contrasena == null) {
      return null;
    }
    final dataRaw = await http.post('http://sotepsa.com/services/Login_Admin.php',
        body: {'Nombre': model.nombre, 'Contrasena': model.contrasena});
    final List raw = json.decode(dataRaw.body);
    if (raw.length == 0) {
      return null;
    } else {
      final data = AuthModel.fromMap(raw[0]);
      AuthBloc().setUserData(data);
      return data;
    }
  }
}
