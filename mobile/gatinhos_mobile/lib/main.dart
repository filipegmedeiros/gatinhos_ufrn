import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/ui/login.dart';
import 'package:gatinhos_mobile/ui/HomePage.dart';
import 'package:gatinhos_mobile/ui/registerCat.dart';

void main() {
  runApp(MaterialApp(
    title: "Gatinhos UFRN",
    home: Home(),
    theme: ThemeData(
      hintColor: Color(0xff3700b3),
      primaryColor: Color(0xff3700b3),
    ),
    routes: {
      Login.routeName: (context) => Login(),
      Home.routeName: (context) => Home(),
      RegisterCat.routeName: (context) => RegisterCat(),
    },
  ));
}
