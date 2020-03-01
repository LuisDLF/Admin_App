import 'dart:convert';

class AuthModel {
  int idAdmin;
  String nombre;
  String contrasena;

  AuthModel({
    this.idAdmin,
    this.nombre,
    this.contrasena,
  });

  AuthModel copyWith({
    int idAdmin,
    String nombre,
    String contrasena,
  }) =>
      AuthModel(
        idAdmin: idAdmin ?? this.idAdmin,
        nombre: nombre ?? this.nombre,
        contrasena: contrasena ?? this.contrasena,
      );

  factory AuthModel.fromJson(String str) => AuthModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
    idAdmin: json["Id_Admin"] == null ? null : (json["Id_Admin"] is String) ? int.parse(json["Id_Admin"]) : json["Id_Admin"],
    nombre: json["Nombre"] == null ? null : json["Nombre"],
    contrasena: json["Contrasena"] == null ? null : json["Contrasena"],
  );

  Map<String, dynamic> toMap() => {
    "Id_Admin": idAdmin == null ? null : idAdmin,
    "Nombre": nombre == null ? null : nombre,
    "Contrasena": contrasena == null ? null : contrasena,
  };
}
