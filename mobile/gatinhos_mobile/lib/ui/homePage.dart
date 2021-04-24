import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/ui/catDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:gatinhos_mobile/domain/catAd.dart';
import 'package:gatinhos_mobile/ui/adoptionRequests.dart';
import 'package:gatinhos_mobile/ui/login.dart';
import 'package:gatinhos_mobile/ui/registerCat.dart';

import 'package:gatinhos_mobile/models/CatDetailModel.dart';

class Home extends StatefulWidget {
  static const String routeName = "/HomePage";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CatAd> catAdoptionAds = List.empty(growable: true);

  Future<List<CatAd>> getAdList() async {
    var url = "http://10.0.2.2:3001/api/v1/gatinhos/";
    final adList = await http.get(Uri.parse(url));

    var jsonList = jsonDecode(adList.body);
    return (jsonList as List).map((data) => new CatAd.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: FutureBuilder<List<CatAd>>(
        future: getAdList(),
        builder: (BuildContext context, AsyncSnapshot<List<CatAd>> snapshot) {
          if (snapshot.hasData) {
            catAdoptionAds = snapshot.data;
            return ListView.builder(
                padding: EdgeInsets.all(5),
                itemCount: catAdoptionAds.length,
                itemBuilder: (context, index) {
                  return _catAdCard(context, index);
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Carregando...'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showRegisterCatPage({CatAd ad}) async {
    // change to registerCat page
    CatAd adRet = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterCat(catAd: ad)));

    if (adRet != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      var url;
      if (adRet.id == null) {
        // salve on database
        //var url = "http://10.0.2.2:3001/api/v1/gatinhos/";
        url = "http://10.0.2.2:3001/api/v1/gatinhos/";
      } else {
        // update database
        url = "http://10.0.2.2:3001/api/v1/gatinhos/" + adRet.id;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'x-access-token': token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': adRet.catName,
          'description': adRet.description,
          'rescueDate': adRet.rescueDate.toString(),
          'gender': adRet.gender,
          'vaccines': adRet.healthTags.contains("Vacinado(a)").toString(),
          'castrate': adRet.healthTags.contains("Castrado(a)").toString(),
        }),
      );

      //print("Resposta do post de criação de ad: ");
      //print(response.body);

      // TODO 'image': adRet.img, enviar imagem por multipart

      // atualiza lista de ads
      setState(() {});
    }
  }

  _deleteCat(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var url = "http://10.0.2.2:3001/api/v1/gatinhos/" + id;
    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'x-access-token': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // atualiza lista de ads
    setState(() {});
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
      padding: EdgeInsets.all(5),
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
                        _deleteCat(catAdoptionAds.elementAt(index).id);
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
                        fontSize: 16,
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
                      var gatinhoDetail = CatDetailModel(
                          id: catAdoptionAds.elementAt(index).id,
                          name: catAdoptionAds.elementAt(index).catName,
                          description:
                              catAdoptionAds.elementAt(index).description,
                          vac: catAdoptionAds
                              .elementAt(index)
                              .healthTags
                              .contains("Vacinado(a)"),
                          cast: catAdoptionAds
                              .elementAt(index)
                              .healthTags
                              .contains("Castrado(a)"));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CatDetail(gatinhoDetail: gatinhoDetail)));
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
