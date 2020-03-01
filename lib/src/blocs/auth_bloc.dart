import 'dart:async';

import 'package:admin_app/src/models/auth_model.dart';

class AuthBloc {
  static final AuthBloc _authBloc = AuthBloc._();

  factory AuthBloc() {
    return _authBloc;
  }

  AuthBloc._();

  final _streamController = StreamController<AuthModel>.broadcast();

  Stream<AuthModel> get dispositivosStream => this._streamController.stream;

  setUserData(AuthModel model) {
    this._streamController.add(model);
  }

  dispose() {
    this._streamController?.close();
  }
}
