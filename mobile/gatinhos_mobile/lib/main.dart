import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/ui/adoptionRequests.dart';
import 'package:gatinhos_mobile/ui/login.dart';
import 'package:gatinhos_mobile/ui/HomePage.dart';

void main() {
  runApp(MaterialApp(
    title: "Gatinhos UFRN",
    home: Home(),
    theme: ThemeData(
      hintColor: Color(0xff3700b3),
      primaryColor: Color(0xff3700b3), // TODO: importar tema do Figma
    ),
    routes: {
      Login.routeName: (context) => Login(),
      Home.routeName: (context) => Home(),
    },
  ));
}
