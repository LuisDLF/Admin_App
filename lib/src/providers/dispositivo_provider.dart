import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:admin_app/src/models/dispositivo_model.dart';

class DispositivosProvider {
  static final DispositivosProvider service = DispositivosProvider._();

  DispositivosProvider._();

  Future<List<DispositivoModel>> getAllDispositivos() async {
    final dataRaw = await http.get('https://sweetnightmare.xyz/services/Gps_read.php');
    final data = json.decode(dataRaw.body);
    List<DispositivoModel> list = [];

    for(var item in data) {
     list.add(DispositivoModel.fromMap(item));
    }

    return list;
  }
}
