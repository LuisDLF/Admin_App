import 'dart:async';

import 'package:admin_app/src/models/dispositivo_model.dart';
import 'package:admin_app/src/providers/dispositivo_provider.dart';

class DispositivoBloc {
  static final DispositivoBloc _dispositivoBloc = DispositivoBloc._();

  factory DispositivoBloc() {
    return _dispositivoBloc;
  }

  DispositivoBloc._() {
    this.getAllDispositivos();
  }

  final _streamController = StreamController<List<DispositivoModel>>.broadcast();

  Stream<List<DispositivoModel>> get dispositivosStream => this._streamController.stream;

  getAllDispositivos() async {
    this._streamController.sink.add(await DispositivosProvider.service.getAllDispositivos());
  }

  dispose() {
    this._streamController?.close();
  }
}
