import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:proyecfire2/src/models/model_User.dart';

class serviceUser with ChangeNotifier {
  Future<List<modelUser>> _users = Future.value([]);

  serviceUser();

  cargardoUsers() {
    print("cargando users");
    modelUser m = modelUser(id: "1", name: "Jose", password: "MMM");
    m.searchUser(m);
  }

  Future<List<modelUser>> getUsers() {
    modelUser m = modelUser(id: "1", name: "juan", password: "123");

    _users = m.listUsers();

    return _users;
  }
}
