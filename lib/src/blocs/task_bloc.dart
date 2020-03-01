import 'dart:async';

import 'package:admin_app/src/models/task_model.dart';
import 'package:admin_app/src/providers/task_provider.dart';

class TaskBloc {
  static final TaskBloc _taskBloc = TaskBloc._();

  TaskBloc._();

  factory TaskBloc() {
    return _taskBloc;
  }

  final _streamController = StreamController<List<TaskModel>>.broadcast();

  Stream<List<TaskModel>> get taskStream => this._streamController.stream;

  getAllTask(int id) async {
    this._streamController.add(await TaskProvider.service.getAllTaskByDispositivoId(id));
  }

  dispose() {
    this._streamController?.close();
  }
}
