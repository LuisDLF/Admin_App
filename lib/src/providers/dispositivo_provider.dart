import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:admin_app/src/models/dispositivo_model.dart';

class DispositivosProvider {
  static final DispositivosProvider service = DispositivosProvider._();

  DispositivosProvider._();

  Future<List<DispositivoModel>> getAllDispositivos(int id) async {
    final dataRaw = await http.get('http://sotepsa.com/services/Gps_read.php?Id_Admin=' + id.toString());
    final data = json.decode(dataRaw.body);
    List<DispositivoModel> list = [];

    for (var item in data) {
      list.add(DispositivoModel.fromMap(item));
    }

    return list;
  }
}
