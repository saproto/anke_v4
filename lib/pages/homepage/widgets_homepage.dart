import 'package:ankev928/shared/styling/block.dart';
import 'package:ankev928/shared/styling/block_content.dart';
import 'package:ankev928/shared/styling/block_content_widgets.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
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
        IsAlfredThere(),
        onmomcomScanner(context),
        addQuoteToQuoteCorner(),
        //  newsItem(),
      ],
    );
  }
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


GestureDetector addQuoteToQuoteCorner(){
  return new GestureDetector(
    child:block(blockContentWidgets(
      title: "Quotes",
      icon: "assets/img/quotes.png",
      secondText: "add quote"
    ))
  );
}
