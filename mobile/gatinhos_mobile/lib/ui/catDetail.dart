import 'package:flutter/material.dart';
import 'package:gatinhos_mobile/ui/makeAdoptionRequest.dart';

class CatDetail extends StatefulWidget {
  @override
  _CatDetailState createState() => _CatDetailState();
}

class _CatDetailState extends State<CatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gatinho"),
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
                  child: Text("Gatinho",
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
                      Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eget blandit eros, et bibendum tortor. Mauris interdum ex non nisi eleifend pellentesque. Sed et porta ligula. Quisque tincidunt tempor metus ut aliquet. Nam odio mi, cursus sed massa ut, pharetra iaculis neque. Fusce eget cursus eros. Phasellus luctus, lectus in tempus semper, mauris purus malesuada justo, vestibulum ultricies elit arcu ac tellus. Quisque lacinia tortor quis euismod porttitor. Quisque elementum metus eget urna dictum, at convallis libero dapibus. Donec laoreet quam a nisi ornare iaculis.",
                          textAlign: TextAlign.justify,
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.5)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Chip(
                            label: Text('Vacinado(a)',
                                style: TextStyle(fontSize: 16)),
                            backgroundColor: Colors.green[50],
                          ),
                          SizedBox(width: 10),
                          Chip(
                            label: Text(
                              'Castrado(a)',
                              style: TextStyle(fontSize: 16),
                            ),
                            backgroundColor: Colors.green[50],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('RESGATAR',
                                style: TextStyle(fontSize: 16)),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MakeAdoptionRequest()));
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
