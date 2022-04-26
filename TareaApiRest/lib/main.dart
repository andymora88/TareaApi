import 'package:flutter/material.dart';
import 'package:proyecfire2/src/services/service_Api.dart';

void main() {
  runApp(const MyApp());
}

TextEditingController _ControllerNombre = TextEditingController();
TextEditingController _ControllerContenido = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }

  @override
  void dispose() {
    _ControllerNombre.dispose();
    _ControllerContenido.dispose();
  }

  @override
  void initState() {
    _ControllerNombre.text = "";
    _ControllerContenido.text = "";
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void addNote() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ServiceApi serviceApi = ServiceApi();
    serviceApi.listaNotas();
    return Scaffold(
      body: FutureBuilder(
        future: serviceApi.listaNotas(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) => Column(
                      children: <Widget>[
                        Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            color: Colors.red,
                          ),
                          onDismissed: (direction) async {
                            bool dato = await serviceApi
                                .deleteNote(snapshot.data[index].id);
                            if (dato) {
                              snapshot.data.removeAt(index);
                              setState(() {});
                            }
                          },
                          child: ListTile(
                            title: Text(snapshot.data[index].nombre),
                            subtitle: Text(snapshot.data[index].contenido),
                          ),
                        ),
                        Divider(),
                      ],
                    ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            //  showModalBottomSheet
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _ControllerNombre,
                          decoration: const InputDecoration(
                            labelText: "Nombre",
                          ),
                        ),
                        TextField(
                          controller: _ControllerContenido,
                          decoration: const InputDecoration(
                            labelText: "Contenido",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            bool dato = await serviceApi.addNote(
                                _ControllerNombre.text,
                                _ControllerContenido.text);
                            if (dato) {
                              setState(() {});
                            }
                            _ControllerNombre.text = "";
                            _ControllerContenido.text = "";
                            Navigator.of(context).pop();
                          },
                          child: const Text("Agregar"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancelar"),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.add)),
    );
  }
}
