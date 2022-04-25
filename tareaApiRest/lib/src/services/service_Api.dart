import '../models/modelApi.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'dart:async';

class ServiceApi {
  final String apiUrl = "https://faddish-smoke.000webhostapp.com/api/";

  Future<List<ModelApi>> listaNotas() async {
    List<ModelApi> lnote = [];
    try {
      Response res = await get(Uri.parse(apiUrl));
      String body = utf8.decode(res.bodyBytes);
      final j = json.decode(body);
      lnote = j.map<ModelApi>((json) => ModelApi.fromMap(json)).toList();
    } catch (e) {
      print(e);
    }
    return lnote;
  }

  Future<bool> deleteNote(String _id) async {
    try {
      final Response response = await get(
        Uri.parse(apiUrl + "?borrar=" + _id),
        headers: <String, String>{},
      );
      if (response.statusCode == 200) {
        print("Nota eliminada");
      } else {
        print("No se pudo eliminar");
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addNote(String nombre, String contenido) async {
    try {
      Map data = {'Id': "null", 'nombre': nombre, 'contenido': contenido};
      final Response response = await post(
        Uri.parse(apiUrl + "?insertar=1"),
        headers: <String, String>{},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print("Datos agregados");
      } else {
        print("No se pudo agregar");
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
