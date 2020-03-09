import 'dart:convert';

import 'package:admin_app/src/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskProvider {
  static final TaskProvider service = TaskProvider._();

  TaskProvider._();

  Future<bool> register(TaskModel model) async {
    if (model.nombre == null) {
      return false;
    }
    final dataRaw = await http.post('http://sotepsa.com/services/Tarea_Upload.php', body: {
      'Nombre': model.nombre,
      'rango': model.rango.toString(),
      'hora_entrada': model.horaEntrada,
      'hora_salida': model.horaSalida,
      'Lat': model.lat.toString(),
      'Lon': model.lon.toString(),
      'Tel': model.telefono,
      'Id_Dispositivo': model.idDispositivo.toString(),
    });
    final data = json.decode(dataRaw.body);
    return (data == 1) ? true : false;
  }

  Future<List<TaskModel>> getAllTaskByDispositivoId(int id) async {
    final dataRaw = await http.get('http://sotepsa.com/services/Tareas_read.php?Id_Dispositivo=' + id.toString());
    final data = json.decode(dataRaw.body);
    List<TaskModel> list = [];

    for (var item in data) {
      print(item);
      list.add(TaskModel.fromMap(item));
    }

    return list;
  }

  Future<bool> update(TaskModel model) async {
    final dataRaw = await http.post('http://sotepsa.com/services/Update_Tarea.php', body: {
      'Nombre': model.nombre,
      'rango': model.rango.toString(),
      'hora_entrada': model.horaEntrada,
      'hora_salida': model.horaSalida,
      'Lat': model.lat.toString(),
      'Lon': model.lon.toString(),
      'Tel': model.telefono,
      'Id_Tarea': model.idTarea.toString(),
    });
    print(dataRaw.body);
    print(dataRaw.statusCode);

    final data = json.decode(dataRaw.body);
    return (data == 1) ? true : false;
  }

  Future<bool> delete(int id) async {
    final dataRaw = await http.post('http://sotepsa.com/services/Delete_Tarea.php', body: {'Id_Tarea': id.toString()});
    print(dataRaw.body);
    final data = json.decode(dataRaw.body);
    return (data == 1) ? true : false;
  }
}
