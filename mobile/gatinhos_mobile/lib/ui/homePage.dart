import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:gatinhos_mobile/domain/catAd.dart';
import 'package:gatinhos_mobile/ui/adoptionRequests.dart';
import 'package:gatinhos_mobile/ui/login.dart';
import 'package:gatinhos_mobile/ui/registerCat.dart';

class Home extends StatefulWidget {
  static const String routeName = "/HomePage";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CatAd> catAdoptionAds = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    // update cat adoption ad list
    updateAdList();
  }

  Future<void> updateAdList() async {
    // TODO get adList from database
    catAdoptionAds.add(CatAd());
    catAdoptionAds.add(CatAd());

    var url = "http://localhost:3001/api/v1/gatinho/";
    final adList = await http.get(Uri.parse(url));

    print("Resposta do post de criação de ad: ");
    print(adList.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: verificar se não é melhor por uma SliverAppBar no lugar da AppBar
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Color(0xff3700b3),
      ),
      drawer: _homeDrawer(),
      floatingActionButton: FloatingActionButton(
        // TODO position
        child: Icon(Icons.add),
        backgroundColor: Color(0xff5600e8),
        onPressed: () {
          _showRegisterCatPage();
        },
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(5.0),
          itemCount: catAdoptionAds.length,
          itemBuilder: (context, index) {
            return _catAdCard(context, index);
          }),
    );
  }

  void _showRegisterCatPage({CatAd ad}) async {
    // change to registerCat page
    CatAd adRet = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterCat(catAd: ad)));

    if (adRet != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      print("token lido para acesso ao cadastro: " + token);

      if (adRet.id == null) {
        // salve on database
        print("salvar contato");
        //var url = "http://10.0.2.2:3001/api/v1/gatinho/";
        var url = "http://localhost:3001/api/v1/gatinho/";
        final response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'x-access-token': token,
          },
          body: jsonEncode(<String, String>{
            'name': adRet.catName,
            'description': adRet.description,
            //'rescueDate': "2021-05-17T16:57:48.073+00:00", // TODO
            'gender': adRet.sex,
            'vaccines': adRet.healthTags.contains("Vacinado(a)").toString(),
            'castrate': adRet.healthTags.contains("Castrado(a)").toString(),
          }),
        );

        print("Resposta do post de criação de ad: ");
        print(response.body);

        // TODO 'image': adRet.img, enviar imagem por multipart

      } else {
        // update database
        print("atualizar contato");
      }
      // atualizar lista de ads
    }
  }

  // Widget
  _homeDrawer() {
    return Drawer(
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
            leading: Icon(Icons.edit),
            title: Text("Editar"),
            onTap: () {
              _showRegisterCatPage();
            },
          ),
          ListTile(
            leading: Icon(Icons.read_more),
            title: Text("Pedidos de adoção"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdoptionRequests()));
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
    );
  }

  Widget _catAdCard(BuildContext context, int index) {
    return Card(
      elevation: 2,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          // TODO open cat ad page
          print("cat ad tapped.");
        },
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Text("cat Ad"), // TODO put ad info
        ),
      ),
    );
  }
}
