import 'package:ankev928/shared/styling/block.dart';
import 'package:ankev928/shared/styling/block_content.dart';
import 'package:ankev928/shared/styling/block_content_widgets.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ankev928/pages/homepage/is_alfred_there.dart';

class WidgetsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        isAlfredThereGestureDetector(context),
        onmomcomScanner(context),
        addQuoteToQuoteCorner(context),
        //  newsItem(),
      ],
    );
  }
}

GestureDetector isAlfredThereGestureDetector(BuildContext context){
  return new GestureDetector(
    onTap: ((){
      Flushbar(
        message: "What do you want us to do? Summon Alfred?",
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 5),
        isDismissible: true,
      )..show(context);
    }),
    child: IsAlfredThere(),
  );
}


GestureDetector onmomcomScanner(BuildContext context) {
  return new GestureDetector(
    onTap: (() {Navigator.of(context).pushNamed('/qrscanner');}),
   child: block(blockContentWidgets(
     title: "Omnomcom",
     icon: "assets/img/qrscanner.png",
     secondText: "scanner"
   )));
}


GestureDetector addQuoteToQuoteCorner(BuildContext context){
  return new GestureDetector(
      onTap: (() {Navigator.of(context).pushNamed('/addQuote');}),
    child:block(blockContentWidgets(
      title: "Quotes",
      icon: "assets/img/quotes.png",
      secondText: "add quote"
    ))
  );
}
