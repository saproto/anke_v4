import 'package:flutter/material.dart';

Widget block(Container content) {
  return new Container(
    child:  content,
    height: 150,
    width: getBlockWidth(),
    margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
    alignment: Alignment.center,
    decoration: new BoxDecoration(
      border: Border.all(color: Color(0xff6c757d), width: 0.5),
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  );
}

double getBlockWidth(){
  return 150;
}
