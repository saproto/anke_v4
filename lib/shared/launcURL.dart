import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

launchURL(url) async {
  if (await urlLauncher.canLaunch(url)) {
    await urlLauncher.launch(url);
  } else {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Something went wrong. Could not launch $url."),
    ));
  }
}