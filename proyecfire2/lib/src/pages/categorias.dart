// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecfire2/src/models/model_User.dart';
import 'package:proyecfire2/src/services/service_User.dart';

//create widget
class categoryPage extends StatelessWidget {
  categoryPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    final _serviceUser = Provider.of<serviceUser>(context);
    Future<List<modelUser>> _users = Future.value([]);
    _users = _serviceUser.getUsers();
    @override
    void initState() {
      final _serviceUser = Provider.of<serviceUser>(context);
    }

    @override
    void dispose() {
      final _serviceUser = Provider.of<serviceUser>(context);
    }

    return Scaffold(
      body: FutureBuilder(
        future: _users,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(snapshot.data[index].name),
                subtitle: Text(snapshot.data[index].password),

                leading: CircleAvatar(
                  //random image
                  backgroundImage:
                      NetworkImage('https://picsum.photos/250?image=10'),
                ),
                //show button
                //add to option button to add image
                trailing: Icon(Icons.keyboard_arrow_right),

                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('User'),
                        content: Text(snapshot.data[index].name),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
            //add child

          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      //create button text
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _serviceUser.getUsers();
        },
      ),
    );
  }
}
