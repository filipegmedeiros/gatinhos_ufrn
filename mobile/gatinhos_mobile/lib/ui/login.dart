import 'package:flutter/material.dart';

class Login extends StatefulWidget {
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
                    onPressed: _sendToServer,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff6200ee),
                      padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    )),
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

  /// submit button onPressed function
  void _sendToServer() {
    // Validate returns true if the form is valid, or false otherwise
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a status snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Verificando login...')));

      // save login
      _formKey.currentState.save();
    }
  }
}
