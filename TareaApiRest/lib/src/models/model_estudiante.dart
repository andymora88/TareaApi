class Estudiante {
  String nombre;
  String apellido;

  Estudiante({required this.nombre, required this.apellido});

  static List<Estudiante> estudiantes = [];

  static void addEstudiante(Estudiante estudiante) {
    estudiantes.add(estudiante);
  }

  static void rellenarEstudiantes() {
    estudiantes.add(Estudiante(nombre: 'Juan', apellido: 'Mora'));
    estudiantes.add(Estudiante(nombre: 'Pedro', apellido: 'Perez'));
    estudiantes.add(Estudiante(nombre: 'Juan', apellido: 'Perez'));
  }
}
