import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';


class QuoteCornerPage extends StatefulWidget {
  @override
  _QuoteCornerPage createState() => _QuoteCornerPage();
}

class _QuoteCornerPage extends State<QuoteCornerPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto'),
        ),
        drawer: DefaultDrawer(),
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text("quoteCorner"),
            ])));
  }
}
