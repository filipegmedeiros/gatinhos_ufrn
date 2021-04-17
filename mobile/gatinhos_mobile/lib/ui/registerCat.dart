import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/domain/AdoptionAd.dart';
import 'package:image_picker/image_picker.dart';

enum Sexo { Feminino, Masculino }

class RegisterCat extends StatefulWidget {
  static const routeName = '/RegisterCat';

  AdoptionAd adoptionAd;

  // Constructor that initialize the AdoptionAd
  // Between braces because it is optional
  RegisterCat({this.adoptionAd});

  @override
  _RegisterCatState createState() => _RegisterCatState();
}

class _RegisterCatState extends State<RegisterCat> {
  AdoptionAd _editedAdoptionAd;
  bool _userEdited = false;

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
  void initState() {
    super.initState();

    // acessando o ad definido no widget(registerCat)
    if (widget.adoptionAd == null) {
      _editedAdoptionAd = AdoptionAd();
    } else {
      _editedAdoptionAd = widget.adoptionAd; // TODO check
      nameController.text = _editedAdoptionAd.catName;
      ageController.text = _editedAdoptionAd.catAge;
      descriptionController.text = _editedAdoptionAd.description;
    }
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Abandonar alterações?"),
              content: Text("Os dados inseridos serão perdidos."),
              actions: <Widget>[
                TextButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context); // pop warning
                    }),
                TextButton(
                    child: Text("Sim"),
                    onPressed: () {
                      Navigator.pop(context); // pop warning
                      Navigator.pop(context); // pop registerCat page
                    }),
              ],
            );
          });
    } else {
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_editedAdoptionAd.catName == null
              ? "Cadastro"
              : "Editar " + _editedAdoptionAd.catName),
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
                  _inputImage(),
                  Divider(),
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // save form
                        _formKey.currentState.save();

                        Navigator.pop(context, _editedAdoptionAd);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // inputs Widget
  _inputImage() {
    // floating action button; Icons.add
    return Stack(
      children: <Widget>[
        Container(
          width: 400.0,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: _editedAdoptionAd.img != null
                  ? FileImage(File(_editedAdoptionAd.img))
                  : AssetImage("images/defaultCat.jpg"),
            ),
          ),
        ),
        Positioned(
            right: 0.0,
            bottom: 0.0,
            child: FloatingActionButton(
              child: Icon(Icons.add_a_photo_outlined),
              backgroundColor: Color(0xff5600e8),
              onPressed: () {
                ImagePicker()
                    .getImage(source: ImageSource.gallery, imageQuality: 50)
                    .then((file) {
                  if (file == null) {
                    return;
                  } else {
                    _userEdited = true;
                    setState(() {
                      _editedAdoptionAd.img = file.path;
                    });
                  }
                });
              },
            ))
      ],
    );
  }

  _inputName() {
    return TextFormField(
      keyboardType: TextInputType.text,
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
      onChanged: (text) {
        _userEdited = true;
      },
      validator: _catNameValidator,
      onSaved: (text) {
        _editedAdoptionAd.catName = text;
      },
    );
  }

  _inputAge() {
    return TextFormField(
      keyboardType: TextInputType.number,
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
      onChanged: (text) {
        _userEdited = true;
      },
      validator: _catAgeValidator,
      onSaved: (text) {
        _editedAdoptionAd.catAge = text;
      },
    );
  }

  _inputDescription() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
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
      onChanged: (text) {
        _userEdited = true;
      },
      onSaved: (text) {
        _editedAdoptionAd.description = text;
      },
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
              _userEdited = true;
              _editedAdoptionAd.sex = "Feminino";
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
              _userEdited = true;
              _editedAdoptionAd.sex = "Masculino";
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
              _userEdited = true;
              _castradoChecked
                  ? _editedAdoptionAd.healthTags.add("Castrado(a)")
                  : _editedAdoptionAd.healthTags.remove("Castrado(a)");
              //print("Checkbox castrado:" + _editedAdoptionAd.healthTags.toString());
            }),
        CheckboxListTile(
            title: Text("Vacinado(a)"),
            controlAffinity: ListTileControlAffinity.leading,
            value: _vacinasChecked,
            onChanged: (bool value) {
              setState(() {
                _vacinasChecked = value;
              });
              _userEdited = true;
              _vacinasChecked
                  ? _editedAdoptionAd.healthTags.add("Vacinado(a)")
                  : _editedAdoptionAd.healthTags.remove("Vacinado(a)");
              //print("Checkbox vacinado:" + _editedAdoptionAd.healthTags.toString());
            }),
      ],
    );
  }

  /// Field validators
  String _catNameValidator(String value) {
    if (value == null || value.isEmpty) {
      return "Por favor, insira o nome do gato.";
    }
    return null;
  }

  String _catAgeValidator(String value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    int age = int.tryParse(value);
    if (age == null || 0 > age || age > 40) {
      return "Idade inválida.";
    }

    return null;
  }
}
