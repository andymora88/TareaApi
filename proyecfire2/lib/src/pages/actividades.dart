// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecfire2/src/services/service_User.dart';

//create widget
class ActivityPage extends StatelessWidget {
  ActivityPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    final _serviceUser = Provider.of<serviceUser>(context);

    @override
    void initState() {
      final _serviceUser = Provider.of<serviceUser>(context);
    }

    @override
    void dispose() {
      final _serviceUser = Provider.of<serviceUser>(context);
    }

    return Scaffold(
      body: Center(
        child: Text(
          'Activity',
          style: TextStyle(
            fontSize: 30,
            color: Colors.blue,
          ),
        ),
      ),
      //create button text
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _serviceUser.cargardoUsers();
        },
      ),
    );
  }
}
