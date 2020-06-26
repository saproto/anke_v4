import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';



class OmnomcomPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto'),
        ),
        drawer: DefaultDrawer(),
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text("op profilepage"),

            ])));
  }
}
