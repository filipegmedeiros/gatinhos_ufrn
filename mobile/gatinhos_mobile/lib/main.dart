import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/ui/adoptionRequests.dart';
import 'package:gatinhos_mobile/ui/login.dart';

void main() {
  runApp(MaterialApp(
    title: "Gatinhos UFRN",
    home: Home(),
    theme: ThemeData(
      hintColor: Color(0xff3700b3),
      primaryColor: Color(0xff3700b3), // TODO: importar tema do Figma
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
        backgroundColor: Color(0xff3700b3),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 110,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff3700b3),
                ),
                child: Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
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
              leading: Icon(Icons.read_more),
              title: Text("Pedidos de adoção"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdoptionRequests()));
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
