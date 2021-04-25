import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/ui/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MakeAdoptionRequest extends StatefulWidget {
  final catData;
  MakeAdoptionRequest({this.catData});
  @override
  _MakeAdoptionRequestState createState() => _MakeAdoptionRequestState();
}

class _MakeAdoptionRequestState extends State<MakeAdoptionRequest> {
  bool _screenGuard = false;
  bool _animals = false;
  bool _isHouse2 = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void _handleIsHouseChange(bool value) {
    setState(() {
      _isHouse2 = value;
    });
  }

  void _handleScreenGuardChange(bool value) {
    setState(() {
      _screenGuard = value;
    });
  }

  void _handleAnimalsChange(bool value) {
    setState(() {
      _animals = value;
    });
  }

  void _sendAdoptionRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var url = "http://10.0.2.2:3001/api/v1/adocao/";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'x-access-token': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': widget.catData.id,
        'animals': _animals,
        'screen_guard': _screenGuard,
        'name': nameController.text,
        'phone': phoneController.text,
        'adress': ' '
      }),
    );

    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Resgate"),
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
                children: [
                  Text(
                      "Preencha o formulário para solicitar o resgate de " +
                          widget.catData.name,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  Text(
                      "Precisamos de algumas informações para prosseguirmos com o processo de adoção! Não se preocupe com respostas certas ou erradas, apenas responda sinceramente.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black, fontSize: 18, height: 1.4)),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Seu nome completo",
                      labelStyle:
                          TextStyle(color: Colors.grey[700], fontSize: 18),
                      border: const UnderlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xfff3f3f3),
                    ),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Telefone",
                      labelStyle:
                          TextStyle(color: Colors.grey[700], fontSize: 18),
                      border: const UnderlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xfff3f3f3),
                    ),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Residência",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                      ListTile(
                        title: const Text("Casa"),
                        leading: Radio(
                          value: true,
                          groupValue: _isHouse2,
                          onChanged: _handleIsHouseChange,
                        ),
                      ),
                      ListTile(
                        title: const Text("Apartamento"),
                        leading: Radio(
                          value: false,
                          groupValue: _isHouse2,
                          onChanged: _handleIsHouseChange,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Sua residência possui telas de proteção?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                      ListTile(
                        title: const Text("Sim"),
                        leading: Radio(
                          value: true,
                          groupValue: _screenGuard,
                          onChanged: _handleScreenGuardChange,
                        ),
                      ),
                      ListTile(
                        title: const Text("Não ou só em alguns lugares"),
                        leading: Radio(
                          value: false,
                          groupValue: _screenGuard,
                          onChanged: _handleScreenGuardChange,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Possui outros animais de estimação?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                      ListTile(
                        title: const Text("Sim"),
                        leading: Radio(
                          value: true,
                          groupValue: _animals,
                          onChanged: _handleAnimalsChange,
                        ),
                      ),
                      ListTile(
                        title: const Text("Não"),
                        leading: Radio(
                          value: false,
                          groupValue: _animals,
                          onChanged: _handleAnimalsChange,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('ENVIAR',
                            style: TextStyle(fontSize: 18)),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(
                              right: 20, left: 20, top: 10, bottom: 10),
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: _sendAdoptionRequest,
                      ),
                    ],
                  )
                ],
              ))
        ]))));
  }
}
