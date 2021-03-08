import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
                  height: 200.0,
                ),
                Divider(),
                TextFormField(
                  keyboardType: TextInputType.name, // nome ou email ???
                  decoration: InputDecoration(
                    labelText: "Usuário",
                    labelStyle:
                        TextStyle(color: Colors.grey[700], fontSize: 20),
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
                  validator: (value) {
                    if (value.isEmpty) return "Isira o seu nome de usuário!";
                  },
                ),
                Divider(),
                TextFormField(
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
                        child: Icon(
                            _hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey),
                      )),
                  textAlign: TextAlign.left,
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
        ),
      ),
    );
  }
}
