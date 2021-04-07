import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/ui/adoptionRequests.dart';
import 'package:gatinhos_mobile/ui/login.dart';
import 'package:gatinhos_mobile/ui/registerCat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  static const String routeName = "/HomePage";

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
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                // change app to home page
                Navigator.pushNamed(context, Home.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Cadastrar"),
              onTap: () {
                // change to registerCat page
                Navigator.pushNamed(context, RegisterCat.routeName);
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
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: () {
                // change to login page
                Navigator.pushNamed(context, Login.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () async {
                // logout
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                prefs
                    .commit(); // On iOS, synchronize is marked deprecated. On Android, we commit every set.

                // go to home
                Navigator.pushNamed(context, Home.routeName);
              },
            ),
          ],
        ),
      ),
      body: Container(), // TODO: criar pagina com listagem de anúncios
    );
  }
}
