import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
      ),
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                "images/LogoGatinhos.png",
                fit: BoxFit.fitWidth,
                height: 200.0,
              ),
              Divider(),
              TextFormField(
                keyboardType: TextInputType.name, // nome ou email ???
                decoration: InputDecoration(
                  labelText: "Usuário ",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                controller: usuarioController,
                validator: (value) {
                  if (value.isEmpty) return "Isira o seu nome de usuário!";
                },
              ),
              Divider(),
              TextFormField(
                keyboardType: TextInputType
                    .visiblePassword, // TODO: colocar opção de esconder password
                decoration: InputDecoration(
                  labelText: "Senha ",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                controller: senhaController,
                validator: (value) {
                  if (value.isEmpty) return "Isira sua senha!";
                },
              ),
            ],
          ),
        ),
      ), // TODO: criar pagina com login
    );
  }
}
