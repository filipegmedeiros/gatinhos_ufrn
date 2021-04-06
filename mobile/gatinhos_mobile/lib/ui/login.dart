import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gatinhos_mobile/ui/homePage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const routeName = '/LoginPage';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String userName, password;

  // Alternar visibilidade da senha
  bool _hidePassword = true;
  void _toggleVisibilityPasswd() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        backgroundColor: Color(0xff3700b3),
      ),
      backgroundColor: Color(0xff8ee0ea),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  "images/LogoGatinhos.png",
                  fit: BoxFit.fitWidth,
                  height: 220.0,
                ),
                Divider(
                  height: 55,
                ),
                _inputUserName(),
                Divider(),
                _inputPassword(),
                Divider(),
                ElevatedButton(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff6200ee),
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () async {
                    ScaffoldMessengerState scaffoldMessenger =
                        ScaffoldMessenger.of(context);

                    // Validate returns true if the form is valid, or false otherwise
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a status snackbar
                      scaffoldMessenger.showSnackBar(const SnackBar(
                        content: Text('Verificando login...'),
                        duration: Duration(seconds: 1),
                      ));

                      // save login
                      _formKey.currentState.save();

                      // send authentication to server
                      _signIn(userName, password);

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String token = prefs.getString('token');

                      if (token != null) {
                        Navigator.pushNamed(context, Home.routeName);
                        scaffoldMessenger.removeCurrentSnackBar();
                        scaffoldMessenger.showSnackBar(SnackBar(
                          content: Text('Login bem sucedido!'),
                          duration: Duration(seconds: 1),
                        ));
                      } else {
                        scaffoldMessenger.removeCurrentSnackBar();
                        scaffoldMessenger.showSnackBar(SnackBar(
                          content: Text('Login ou senha inválidos.'),
                          duration: Duration(seconds: 1),
                        ));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// form field widgets
  _inputUserName() {
    return TextFormField(
      keyboardType: TextInputType.name, // nome ou email ???
      decoration: InputDecoration(
        labelText: "Usuário",
        labelStyle: TextStyle(color: Colors.grey[700], fontSize: 20),
        border: const UnderlineInputBorder(),
        filled: true,
        fillColor: Color(0xffb9ecf2),
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
      controller: usuarioController,
      validator: validateUser,
      onSaved: (str) {
        userName = str;
      },
    );
  }

  _inputPassword() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: _hidePassword,
      decoration: InputDecoration(
          labelText: "Senha",
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontSize: 20,
          ),
          border: const UnderlineInputBorder(),
          filled: true,
          fillColor: Color(0xffb9ecf2),
          suffixIcon: GestureDetector(
            onTap: () {
              _toggleVisibilityPasswd();
            },
            child: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey),
          )),
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
      controller: senhaController,
      validator: validatePassword,
      onSaved: (str) {
        password = str;
      },
    );
  }

  /// Field validators
  String validateUser(String value) {
    if (value == null || value.isEmpty) {
      return "Por favor, insira o seu nome de usuário.";
    }
    return null;
  }

  String validatePassword(String value) {
    if (value == null || value.isEmpty) {
      return "Por favor, insira sua senha.";
    } else if (value.length < 4) {
      return "Senha deve ter pelo menos 4 caracteres.";
    }
    return null;
  }

  /// server authentication
  void _signIn(String userName, String password) async {
    var url = 'http://localhost:3001/auth/sign_in';
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': userName,
        'password': password,
      }),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    print("resposta servidor: " + response.body);

    // saving token in the device
    await prefs.setString('token', parse["token"]);

    // to retrieve token:
    // String token = prefs.getString('token');
    //print(token);
  }
}
