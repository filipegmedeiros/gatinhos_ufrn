import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Gatinhos UFRN",
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.deepPurple[400],
      primaryColor: Colors.deepPurple[700], // TODO: importar tema do Figma
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Container(), // TODO: criar pagina com listagem de anúncios
    );
  }
}
