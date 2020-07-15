import 'package:flutter/material.dart';

Container cardLayout(bool horizontal, Container content, double height) {
  return  new Container(
      //alignment: Alignment.centerLeft,
      child: content,
      height: height,
      margin: horizontal
          ? new EdgeInsets.only(left: 0)
          : new EdgeInsets.only(top: 144.0),
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
