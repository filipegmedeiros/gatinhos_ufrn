import 'package:flutter/material.dart';

enum Sexo { Feminino, Masculino }

class RegisterCat extends StatefulWidget {
  static const routeName = '/RegisterCat';
  @override
  _RegisterCatState createState() => _RegisterCatState();
}

class _RegisterCatState extends State<RegisterCat> {
  // input textfield controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // radio button option
  Sexo _sexo = Sexo.Feminino;

  // checkbox options
  bool _castradoChecked = false;
  bool _vacinasChecked = false;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro"),
          centerTitle: true,
          backgroundColor: Color(0xff3700b3),
        ),
        body: Container(
            child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(child: _inputName()),
                      SizedBox(
                        width: 15.0,
                      ),
                      Flexible(child: _inputAge())
                    ],
                  ),
                  Divider(),
                  _inputDescription(),
                  Divider(),
                  _inputSexo(),
                  Divider(),
                  _inputSaude(),
                  Divider(),
                  ElevatedButton(
                    child: Text(
                      'CADASTRAR',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff6200ee),
                      padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () => {},
                  )
                ],
              )),
        )));
  }

  _inputName() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Nome",
        labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
        border: const UnderlineInputBorder(),
        filled: true,
        fillColor: Color(0xfff3f3f3),
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      controller: nameController,
    );
  }

  _inputAge() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Idade",
        labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
        border: const UnderlineInputBorder(),
        filled: true,
        fillColor: Color(0xfff3f3f3),
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      controller: ageController,
    );
  }

  _inputDescription() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Descrição",
        labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
        border: const UnderlineInputBorder(),
        filled: true,
        fillColor: Color(0xfff3f3f3),
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      maxLength: 500,
      minLines: 4,
      maxLines: 8,
      controller: descriptionController,
    );
  }

  _inputSexo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Sexo"),
        ListTile(
          title: const Text("Feminino"),
          leading: Radio<Sexo>(
            value: Sexo.Feminino,
            groupValue: _sexo,
            onChanged: (Sexo value) {
              setState(() {
                _sexo = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text("Masculino"),
          leading: Radio<Sexo>(
            value: Sexo.Masculino,
            groupValue: _sexo,
            onChanged: (Sexo value) {
              setState(() {
                _sexo = value;
              });
            },
          ),
        ),
      ],
    );
  }

  _inputSaude() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Saúde"),
        CheckboxListTile(
            title: Text("Castrado(a)"),
            controlAffinity: ListTileControlAffinity.leading,
            value: _castradoChecked,
            onChanged: (bool value) {
              setState(() {
                _castradoChecked = value;
              });
            }),
        CheckboxListTile(
            title: Text("Vacinado(a)"),
            controlAffinity: ListTileControlAffinity.leading,
            value: _vacinasChecked,
            onChanged: (bool value) {
              setState(() {
                _vacinasChecked = value;
              });
            }),
      ],
    );
  }
}
