import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/ui/login.dart';

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
        // TODO: verificar se não é melhor por uma SliverAppBar no lugar da AppBar
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: () {
                // change app to login page
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                // change app to home page
                //Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
          ],
        ),
      ),
      body: Container(), // TODO: criar pagina com listagem de anúncios
    );
  }
}
