class ModelApi {
  String id;
  String nombre;
  String contenido;

  ModelApi({required this.id, required this.nombre, required this.contenido});

  factory ModelApi.fromMap(Map<String, dynamic> json) => ModelApi(
      id: json["Id"], nombre: json["nombre"], contenido: json["contenido"]);
}
