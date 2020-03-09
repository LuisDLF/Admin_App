import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:admin_app/src/models/dispositivo_model.dart';

class DispositivosProvider {
  static final DispositivosProvider service = DispositivosProvider._();

  DispositivosProvider._();

  Future<bool> register(DispositivoModel model) async {
    if (model.nombre == null || model.contrasena == null) {
      return false;
    }
    final dataRaw = await http.post('http://sotepsa.com/services/Registro_Dispositivo.php',
        body: {'Nombre': model.nombre, 'Contrasena': model.contrasena, 'Id_Admin': model.idAdmin.toString()});
    final data = json.decode(dataRaw.body);
    return (data == 1) ? true : false;
  }

  Future<List<DispositivoModel>> getAllDispositivos(int id) async {
    final dataRaw = await http.get('http://sotepsa.com/services/Gps_read.php?Id_Admin=' + id.toString());
    final data = json.decode(dataRaw.body);
    List<DispositivoModel> list = [];

    for (var item in data) {
      list.add(DispositivoModel.fromMap(item));
    }

    return list;
  }

  Future<bool> delete(int id) async {
    final dataRaw = await http.post('http://sotepsa.com/services/Delete_Dispositivo.php', body: {'Id_Dispositivo': id.toString()});
    final data = json.decode(dataRaw.body);
    return (data == 1) ? true : false;
  }
}
