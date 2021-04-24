import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gatinhos_mobile/domain/catAd.dart';
import 'package:image_picker/image_picker.dart';

enum Sexo { Feminino, Masculino }

class RegisterCat extends StatefulWidget {
  static const routeName = '/RegisterCat';

  CatAd catAd;

  // Constructor that initialize the CatAd
  // Between braces because it is optional
  RegisterCat({this.catAd});

  @override
  _RegisterCatState createState() => _RegisterCatState();
}

class _RegisterCatState extends State<RegisterCat> {
  CatAd _editedCatAd;
  bool _userEdited = false;

  // input textfield controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController rescueDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // keep datePicker return
  DateTime selectedDate = DateTime.now();

  // radio button option
  Sexo _gender = Sexo.Feminino;

  // checkbox options
  bool _castradoChecked = false;
  bool _vacinasChecked = false;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // acessando o ad definido no widget(registerCat)
    if (widget.catAd == null) {
      _editedCatAd = CatAd();
      _editedCatAd.gender = "Feminino"; // default gender
    } else {
      _editedCatAd = widget.catAd;

      nameController.text = _editedCatAd.catName;
      var date =
          "${_editedCatAd.rescueDate.toLocal().day}/${_editedCatAd.rescueDate.toLocal().month}/${_editedCatAd.rescueDate.toLocal().year}";
      rescueDateController.text = date;
      descriptionController.text = _editedCatAd.description;
      _gender =
          _editedCatAd.gender == "Feminino" ? Sexo.Feminino : Sexo.Masculino;
      _castradoChecked = _editedCatAd.healthTags.contains("Castrado(a)");
      _vacinasChecked = _editedCatAd.healthTags.contains("Vacinado(a)");
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
          title: Text(_editedCatAd.catName == null
              ? "Cadastro"
              : "Editar " + _editedCatAd.catName),
          centerTitle: true,
          backgroundColor: Color(0xff3700b3),
        ),
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Selecione uma imagem",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 215,
                    child: _inputImage(),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(child: _inputName()),
                      SizedBox(
                        width: 15.0,
                      ),
                      Flexible(child: _inputRescueDate())
                    ],
                  ),
                  Divider(),
                  _inputDescription(),
                  Divider(),
                  _inputSexo(),
                  Divider(),
                  _inputSaude(),
                  Divider(),
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
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // save form
                            _formKey.currentState.save();

                            Navigator.pop(context, _editedCatAd);
                          }
                        },
                      ),
                    ],
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
        _catImage(_editedCatAd),
        Positioned(
            right: 10,
            bottom: 0,
            child: SizedBox(
              width: 70.0,
              height: 70.0,
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
                        _editedCatAd.img = file.path;
                      });
                    }
                  });
                },
              ),
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
      onSaved: (text) {
        _editedCatAd.catName = text;
      },
    );
  }

  _inputRescueDate() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            labelText: "Data do resgate",
            labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
            border: const UnderlineInputBorder(),
            filled: true,
            fillColor: Color(0xfff3f3f3),
            icon: Icon(Icons.calendar_today),
          ),
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          controller: rescueDateController,
          onChanged: (text) {
            _userEdited = true;
          },
          validator: _rescueDateValidator,
          onSaved: (val) {
            _editedCatAd.rescueDate = selectedDate;
          },
        ),
      ),
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
      validator: _descriptionValidator,
      onSaved: (text) {
        _editedCatAd.description = text;
      },
    );
  }

  _inputSexo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Sexo"),
        RadioListTile(
          title: const Text("Feminino"),
          value: Sexo.Feminino,
          groupValue: _gender,
          onChanged: (Sexo value) {
            _userEdited = true;
            _editedCatAd.gender = "Feminino";
            setState(() {
              _gender = value;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile(
          title: const Text("Masculino"),
          value: Sexo.Masculino,
          groupValue: _gender,
          onChanged: (Sexo value) {
            _userEdited = true;
            _editedCatAd.gender = "Masculino";
            setState(() {
              _gender = value;
            });
          },
          contentPadding: EdgeInsets.zero,
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
                ? _editedCatAd.healthTags.add("Castrado(a)")
                : _editedCatAd.healthTags.remove("Castrado(a)");
          },
          contentPadding: EdgeInsets.zero,
        ),
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
                ? _editedCatAd.healthTags.add("Vacinado(a)")
                : _editedCatAd.healthTags.remove("Vacinado(a)");
          },
          contentPadding: EdgeInsets.all(0),
        ),
      ],
    );
  }

  /// Field validators
  String _descriptionValidator(String value) {
    if (value == null || value.isEmpty) {
      return "Por favor, insira uma descrição do gato.";
    }
    return null;
  }

  String _rescueDateValidator(String value) {
    if (value == null || value.isEmpty) {
      return "Por favor, insira a data do resgate.";
    }
    return null;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        rescueDateController.text = date;
      });
    }
  }
}

_catImage(CatAd cat) {
  Widget imgRet;

  if (cat.img == null) {
    imgRet = Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/defaultCat.png"),
        ),
      ),
    );
  } else {
    //imgRet = Image.network("http://10.0.2.2:3001/api/v1/image/" + cat.id); // android
    imgRet =
        Image.network("http://localhost:3001/api/v1/image/" + cat.id); // ios
  }
  return imgRet;
}
