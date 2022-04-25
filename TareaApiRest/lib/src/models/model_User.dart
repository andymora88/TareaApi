import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class modelUser {
  String id;
  String name;
  String password;

  CollectionReference users = FirebaseFirestore.instance.collection("User");
  //init firebase

  modelUser({required this.id, required this.name, required this.password});
  //construct empty
  factory modelUser.fromJson(Map<String, dynamic> json) =>
      modelUser(id: json["id"], name: json["name"], password: json["password"]);

  modelUser.fromMap(Map<String, dynamic> data, String id)
      : this(id: id, name: data['name'], password: data['password']);

  get getId => id;
  get getName => name;
  get getPassword => password;
  set setId(String id) => this.id = id;
  set setName(String name) => this.name = name;
  set setPassword(String password) => this.password = password;

  // return map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
    };
  }

  // save user future<void>
  Future<void> saveUser() async {
    await users.doc().set(toMap());
  }

  // search user future<void> using where
  Future<void> searchUser(modelUser user) async {
    await users.where("name", isEqualTo: user.name).get().then((value) {
      print(value.docs[0]["name"]);
      print(value.docs[0]["password"]);
      //print id cloud firebase
      print(value.docs[0].id);
    }).catchError((error) {
      print(error);
    });
  }

  // delete user future<void>
  Future<void> deleteUser(String id) async {
    await users.doc(id).delete();
  }

  // update user future<void>
  Future<void> updateUser(modelUser user) async {
    await users.doc(user.id).update(toMap());
  }

  Future<void> updateonedocumentUser(modelUser user) async {
    await users.doc(user.id).update({'name': user.name});
  }

  // add new space in user collection by id
  Future<void> addSpace(String id, String space) async {
    await users.doc(id).set(
      {'nuevo': space},
      SetOptions(merge: true),
    );
  }

  // get user
  Future<QuerySnapshot> getUser() async {
    return await users.get();
  }

  Future<List<modelUser>> listUsers() async {
    List<modelUser> lusers = [];

    await users.get().then((value) {
      value.docs.forEach((element) {
        modelUser m = modelUser(id: "1", name: "juan", password: "123");
        m.setId = element.id;
        m.setName = element['name'];
        m.setPassword = element['password'];
        lusers.add(m);
      });
    });
    return lusers;
  }

  //foreach QuerySnapshot
  Future<void> foreachUser() async {
    await users.get().then((value) {
      value.docs.forEach((element) {
        print(element.data);
      });
    });
  }

  // get user by id
  Future<DocumentSnapshot> getUserById(String id) async {
    return await users.doc(id).get();
  }

  // get user by name
  Future<QuerySnapshot> getUserByName(String name) async {
    return await users.where("name", isEqualTo: name).get();
  }

  // get user by password
  Future<QuerySnapshot> getUserByPassword(String password) async {
    return await users.where("password", isEqualTo: password).get();
  }

  // get user by name and password
  Future<QuerySnapshot> getUserByNameAndPassword(
      String name, String password) async {
    return await users
        .where("name", isEqualTo: name)
        .where("password", isEqualTo: password)
        .get();
  }
}
