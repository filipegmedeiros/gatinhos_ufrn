import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/models/AdoptionRequestModel.dart';
import 'package:gatinhos_mobile/ui/makeAdoptionRequest.dart';

class CatDetail extends StatelessWidget {
  final gatinhoDetail;
  CatDetail({this.gatinhoDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gatinhoDetail.name),
        centerTitle: true,
        backgroundColor: Color(0xff3700b3),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/cat2.jpg')),
                  ),
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(gatinhoDetail.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 8.0,
                              color: Colors.grey[700],
                            )
                          ]))),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(gatinhoDetail.description,
                          textAlign: TextAlign.justify,
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.5)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          gatinhoDetail.vac == true
                              ? Chip(
                                  label: Text('Vacinado(a)',
                                      style: TextStyle(fontSize: 16)),
                                  backgroundColor: Colors.green[50],
                                )
                              : SizedBox(),
                          SizedBox(width: 10),
                          gatinhoDetail.cast == true
                              ? Chip(
                                  label: Text(
                                    'Castrado(a)',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  backgroundColor: Colors.green[50],
                                )
                              : SizedBox()
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('RESGATAR',
                                style: TextStyle(fontSize: 18)),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, top: 10, bottom: 10),
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              var catData = AdoptionRequestModel(
                                  id: gatinhoDetail.id,
                                  name: gatinhoDetail.name);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MakeAdoptionRequest(
                                          catData: catData)));
                            },
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
