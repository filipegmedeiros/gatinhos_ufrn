import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/domain/adoptionReq.dart';
import 'package:gatinhos_mobile/models/AnalyzeAdoptionModel.dart';
import 'package:gatinhos_mobile/ui/analyzeAdoption.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdoptionRequests extends StatefulWidget {
  @override
  _AdoptionRequestsState createState() => _AdoptionRequestsState();
}

class _AdoptionRequestsState extends State<AdoptionRequests> {
  List<AdoptionReq> adoptionReqsList = List.empty(growable: true);

  Future<List<AdoptionReq>> getReqList() async {
    var url = "http://10.0.2.2:3001/api/v1/adocao/"; // android
    //var url = "http://localhost:3001/api/v1/adocao/"; // ios

    final adList = await http.get(Uri.parse(url));

    var jsonList = jsonDecode(adList.body);
    return (jsonList as List)
        .map((data) => new AdoptionReq.fromJson(data))
        .toList();
  }

  Widget _adoptionCard(BuildContext context, int index) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/defaultCat.png')),
                      ))),
              Expanded(
                flex: 7,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(children: <Widget>[
                                Text(
                                    "Pedido de adoção #" +
                                        (index + 1).toString(),
                                    style: TextStyle(fontSize: 20)),
                              ]),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                      "Feito por " +
                                          adoptionReqsList
                                              .elementAt(index)
                                              .personName,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 14))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextButton(
                              child: const Text('VER MAIS'),
                              onPressed: () {
                                var adoptionDetail = AnalyzeAdoptionModel(
                                    id: adoptionReqsList.elementAt(index).id,
                                    name: adoptionReqsList
                                        .elementAt(index)
                                        .personName,
                                    animals: adoptionReqsList
                                        .elementAt(index)
                                        .animals,
                                    safeGuard: adoptionReqsList
                                        .elementAt(index)
                                        .safeGuard,
                                    isHouse: adoptionReqsList
                                        .elementAt(index)
                                        .isHouse,
                                    phone: adoptionReqsList
                                        .elementAt(index)
                                        .phone);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnalyzeAdoption(
                                            adoptionDetail: adoptionDetail)));
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pedidos de adoção"),
          centerTitle: true,
          backgroundColor: Color(0xff3700b3),
        ),
        body: FutureBuilder<List<AdoptionReq>>(
            future: getReqList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<AdoptionReq>> snapshot) {
              if (snapshot.hasData) {
                adoptionReqsList = snapshot.data;
                return ListView.builder(
                    padding: EdgeInsets.all(5),
                    itemCount: adoptionReqsList.length,
                    itemBuilder: (context, index) {
                      return _adoptionCard(context, index);
                    });
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
            }));
  }
}
