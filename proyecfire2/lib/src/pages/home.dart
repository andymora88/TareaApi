//import mateial
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_element, prefer_final_fields

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecfire2/src/pages/actividades.dart';
import 'package:proyecfire2/src/pages/categorias.dart';
import 'package:proyecfire2/src/services/service_User.dart';

//create widget
class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();

    @override
    void initState() {
      final _serviceUser = Provider.of<serviceUser>(context);
    }

    @override
    void dispose() {
      final _serviceUser = Provider.of<serviceUser>(context);
    }

    return ChangeNotifierProvider(
      create: (context) => _NavegacionModel(),
      child: Scaffold(
        body: _Pages(),
        // ignore: prefer_const_literals_to_create_immutables
        bottomNavigationBar: Navegacion(),
      ),
    );
  }
}

class Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
        currentIndex: navegacionModel.pageActual,
        onTap: (i) => navegacionModel.pageActual = i,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Actividades',
          ),
        ]);
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    final _serviceUser = Provider.of<serviceUser>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        ActivityPage(title: 'Actividades'),
        categoryPage(title: 'Categorias'),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _pageActual = 0;
  PageController _pageController = new PageController();

  int get pageActual => _pageActual;

  set pageActual(int value) {
    _pageActual = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
