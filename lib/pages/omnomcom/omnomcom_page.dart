import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';


class OmnomcomPage extends StatefulWidget {
  @override
  _OmnomcomPage createState() => _OmnomcomPage();
}

class _OmnomcomPage extends State<OmnomcomPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto'),
        ),
        drawer: DefaultDrawer(),
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("op omnomcompage"),
              RaisedButton(
                child: const Text("go to QRScanner"),
                onPressed: (() {
                  //Navigator.pop(context);
                  Navigator.of(context).pushNamed('/qrscanner');
                }),
              )
        ])));
  }
}
