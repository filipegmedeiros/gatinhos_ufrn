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
        body: (Padding(
            padding: EdgeInsets.all(5),
            child: ListView(
              children: [
                Card(
                  elevation: 2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Container(
                              width: 120,
                              height: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('images/cat1.jpg')),
                              ))),
                      Expanded(
                        flex: 7,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(children: <Widget>[
                                        Text("Pedido de adoção #1",
                                            style: TextStyle(fontSize: 20)),
                                      ]),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text("Feito por Sara Beatriz",
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 14))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text('VER MAIS'),
                                      onPressed: () {/* ... */},
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Container(
                              width: 120,
                              height: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('images/cat2.jpg')),
                              ))),
                      Expanded(
                        flex: 7,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(children: <Widget>[
                                        Text("Pedido de adoção #1",
                                            style: TextStyle(fontSize: 20)),
                                      ]),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text("Feito por Sara Beatriz",
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 14))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text('VER MAIS'),
                                      onPressed: () {/* ... */},
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))));
  }
}
