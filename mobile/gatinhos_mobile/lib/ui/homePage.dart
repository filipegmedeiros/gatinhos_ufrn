import 'dart:convert';
import 'dart:math';

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
    var url = "http://localhost:3001/api/v1/gatinhos/";
    final adList = await http.get(Uri.parse(url));

    var jsonList = jsonDecode(adList.body);
    catAdoptionAds =
        (jsonList as List).map((data) => new CatAd.fromJson(data)).toList();
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
          padding: EdgeInsets.all(15.0),
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

      if (adRet.id == null) {
        // salve on database
        print("salvar contato");

        //var url = "http://10.0.2.2:3001/api/v1/gatinhos/";
        print("retorno: " + adRet.description);
        var url = "http://localhost:3001/api/v1/gatinhos/";
        final response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'x-access-token': token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'name': adRet.catName,
            'description': adRet.description,
            'rescueDate': "2021-05-17T16:57:48.073+00:00", // TODO
            'gender': adRet.gender,
            'vaccines': adRet.healthTags.contains("Vacinado(a)").toString(),
            'castrate': adRet.healthTags.contains("Castrado(a)").toString(),
          }),
        );

        //print("Resposta do post de criação de ad: ");
        //print(response.body);

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
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 2,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            // TODO open cat ad page
            print("cat ad tapped.");
          },
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  catAdoptionAds.elementAt(index).catName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  catAdoptionAds.elementAt(index).gender,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showRegisterCatPage(
                            ad: catAdoptionAds.elementAt(index));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // TODO
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 120,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center,
                          image: AssetImage("images/cat2.jpg"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(
                      catAdoptionAds.elementAt(index).description.substring(
                          0,
                          min(
                              catAdoptionAds
                                  .elementAt(index)
                                  .description
                                  .length,
                              200)),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _tag(
                      catAdoptionAds
                          .elementAt(index)
                          .healthTags
                          .contains("Castrado(a)"),
                      "Castrado(a)"),
                  _tag(
                      catAdoptionAds
                          .elementAt(index)
                          .healthTags
                          .contains("Vacinado(a)"),
                      "Vacinado(a)"),
                  TextButton(
                    onPressed: () {
                      // TODO
                    },
                    child: Text(
                      "VER MAIS",
                      style: TextStyle(color: Color(0xff751ff0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _tag(bool containsTag, String tagLabel) {
    if (containsTag) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Color(0xffe0f0f0),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
            child: Text(
              tagLabel,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
