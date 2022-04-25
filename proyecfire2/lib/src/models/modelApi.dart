import 'dart:convert';
import 'package:http/http.dart';
import 'dart:async';

class ModelApi {
  String id;
  String nombre;
  String contenido;

  ModelApi({required this.id, required this.nombre, required this.contenido});

  final String apiUrl = "https://faddish-smoke.000webhostapp.com/api/";

  factory ModelApi.fromMap(Map<String, dynamic> json) => ModelApi(
      id: json["Id"], nombre: json["nombre"], contenido: json["contenido"]);
}
