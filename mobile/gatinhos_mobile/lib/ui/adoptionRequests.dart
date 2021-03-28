import 'package:flutter/material.dart';

class AdoptionRequests extends StatefulWidget {
  @override
  _AdoptionRequestsState createState() => _AdoptionRequestsState();
}

class _AdoptionRequestsState extends State<AdoptionRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pedidos de adoção"),
          centerTitle: true,
          backgroundColor: Color(0xff3700b3),
        ),
        body: (ListView(
          children: [
            Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/cat1.jpg')),
                      )),
                  TextButton(
                    child: const Text('Ver mais'),
                    onPressed: () {/* ... */},
                  )
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/cat2.jpg')),
                      )),
                ],
              ),
            ),
          ],
        )));
  }
}
