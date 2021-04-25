import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalyzeAdoption extends StatefulWidget {
  final adoptionDetail;
  AnalyzeAdoption({this.adoptionDetail});
  @override
  _AnalyzeAdoptionState createState() => _AnalyzeAdoptionState();
}

class _AnalyzeAdoptionState extends State<AnalyzeAdoption> {
  void _sendAnalyzeRequest(String badge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var url = "http://10.0.2.2:3001/api/v1/adocao/" + widget.adoptionDetail.id;
    // var url = "http://localhost:3001/api/v1/adocao/" + widget.adoptionDetail.id;
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'x-access-token': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'validateBadge': badge,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Analisar pedido"),
          centerTitle: true,
          backgroundColor: Color(0xff3700b3),
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Nome: ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        widget.adoptionDetail.name,
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text("Telefone: ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        widget.adoptionDetail.phone,
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text("Residência: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                              widget.adoptionDetail.isHouse == true
                                  ? "Casa"
                                  : "Apartamento",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text("Possui telas de proteção: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                              widget.adoptionDetail.safeGuard == true
                                  ? "Sim"
                                  : "Não",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text("Possui animais de estimação: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                              widget.adoptionDetail.animals == true
                                  ? "Sim"
                                  : "Não",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('RECUSAR',
                            style: TextStyle(fontSize: 18)),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(
                              right: 20, left: 20, top: 10, bottom: 10),
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () => _sendAnalyzeRequest('recusado'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        child: const Text('ACEITAR',
                            style: TextStyle(fontSize: 18)),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(
                              right: 20, left: 20, top: 10, bottom: 10),
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () => _sendAnalyzeRequest('aceito'),
                      ),
                    ],
                  )
                ],
              ))
        ]))));
  }
}
