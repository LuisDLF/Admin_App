import 'dart:convert';

class TaskModel {
  int idTarea;
  String nombre;
  String telefono;
  int rango;
  String horaEntrada;
  String horaSalida;
  double lat;
  double lon;
  int idDispositivo;

  TaskModel({
    this.idTarea,
    this.nombre,
    this.telefono,
    this.rango,
    this.horaEntrada,
    this.horaSalida,
    this.lat,
    this.lon,
    this.idDispositivo,
  });

  TaskModel copyWith({
    int idTarea,
    String nombre,
    String telefono,
    int rango,
    String horaEntrada,
    String horaSalida,
    double lat,
    double lon,
    int idDispositivo,
  }) =>
      TaskModel(
        idTarea: idTarea ?? this.idTarea,
        nombre: nombre ?? this.nombre,
        telefono: telefono ?? this.telefono,
        rango: rango ?? this.rango,
        horaEntrada: horaEntrada ?? this.horaEntrada,
        horaSalida: horaSalida ?? this.horaSalida,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        idDispositivo: idDispositivo ?? this.idDispositivo,
      );

  factory TaskModel.fromJson(String str) => TaskModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        idTarea: json["Id_Tarea"] == null ? null : json["Id_Tarea"],
        nombre: json["Nombre_tarea"] == null ? null : json["Nombre_tarea"],
        telefono: json["Tel"] == null ? null : json["Tel"],
        rango: json["rango"] == null ? null : (json["rango"] is String) ? int.parse(json["rango"]) : null,
        horaEntrada: json["hora_entrada"] == null ? null : json["hora_entrada"],
        horaSalida: json["hora_salida"] == null ? null : json["hora_salida"],
        lat: json["latitud"] == null ? null : (json["latitud"] is String) ? double.parse(json["latitud"]) : null,
        lon: json["longitud"] == null ? null : (json["longitud"] is String) ? double.parse(json["longitud"]) : null,
        idDispositivo: json["Id_Dispositivo"] == null ? null : json["Id_Dispositivo"],
      );

  Map<String, dynamic> toMap() => {
        "Id_Tarea": idTarea == null ? null : idTarea,
        "Nombre": nombre == null ? null : nombre,
        "Tel": telefono == null ? null : telefono,
        "rango": rango == null ? null : rango,
        "hora_entrada": horaEntrada == null ? null : horaEntrada,
        "hora_salida": horaSalida == null ? null : horaSalida,
        "Lat": lat == null ? null : lat,
        "Lon": lon == null ? null : lon,
        "Id_Dispositivo": idDispositivo == null ? null : idDispositivo,
      };
}
