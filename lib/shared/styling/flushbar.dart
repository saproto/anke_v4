
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Flushbar getFlushbar (BuildContext context, String message, int duration, Color color ) {
  Flushbar flush;
  return flush = Flushbar(
    message: message,
    backgroundColor: color,
    duration: Duration(seconds: duration),
    isDismissible: true,
    mainButton: FlatButton(
      onPressed: () {
        flush.dismiss(true); // result = true
      },
      child: FaIcon(FontAwesomeIcons.timesCircle, color: Colors.white,)
    )
  )..show(context);
}