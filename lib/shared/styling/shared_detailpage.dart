import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:ankev928/shared/helpers/launcURL.dart';


Container getBackground(BuildContext context, String imgUrl) {
  if (imgUrl != null) {
    return new Container(
      child: new Image.network(
        imgUrl,
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 300.0),
    );
  } else {
    return new Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      height: 300.0,
    );
  }
}


Container getGradient(BuildContext context) {
  return new Container(
    margin: new EdgeInsets.only(top: 190.0),
    height: 110.0,
    decoration: BoxDecoration(
      gradient: new LinearGradient(
          colors: <Color>[
            new Color(0x00ffffff),
            Theme.of(context).backgroundColor,
          ],
          stops: [
            0.0,
            0.9
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0)),
    ),
  );
}

Column getToolbar(BuildContext context) {
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      new Container(
        margin:
        new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: new Align(
          alignment: Alignment.topLeft,
          child: new BackButton(color: Colors.black,
          ),
        ),
      )
    ],
  );
}

MarkdownBody markdown(String data){
  return new MarkdownBody(
    data: data,
    onTapLink: (url){
      launchURL(url);
    }
  );
}

