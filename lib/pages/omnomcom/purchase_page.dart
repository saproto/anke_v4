
import 'package:ankev928/shared/styling/flushbar.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/helpers/api_call.dart';


class PurchasePage extends StatefulWidget {
  final String _qrText;

  PurchasePage(this._qrText);

  @override
  _PurchasePage createState() => _PurchasePage(this._qrText);
}

class _PurchasePage extends State<PurchasePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _qrText;
  var qrInfo;

  _PurchasePage(this._qrText);

  @override
  void initState() {
    //super.initState();
    _qrText = widget._qrText;
    getInfo(_qrText);
  //  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  String getToken(String qrString) {
    if (qrString == null) {
      throw Exception("QR value can't be null!");
    }
    List<String> splitUrl = qrString.split("/");
    return splitUrl[splitUrl.length - 1];
  }

  Future<void> getInfo(String qrString) async {
    String linkToApi = 'user/qr_auth_info/' + getToken(qrString);
    qrInfo = await doApiGetRequestAuthenticate(linkToApi);
    if (qrInfo != null) {
      setState(() {});
    }
  }

  Text getQRInfo() {
    if (qrInfo != null) {
      return Text(
        qrInfo["description"],
        style: Style.commonTextStyle.copyWith(color: Colors.white),
      );
    } else {
      return Text(
        "Loading, please wait...",
        style: Style.commonTextStyle.copyWith(color: Colors.white),
      );
    }
  }



  Future<void> _payOmnomcom() async {
    String linkToApi = "user/qr_auth_approve/" + getToken(_qrText);
    var qrPayment = await doApiGetRequestAuthenticate(linkToApi);
    if (qrPayment != null) {
      if (qrPayment["status"] == "ok") {
        Navigator.pop(context);
        Navigator.pop(context);
        getFlushbar(context, 'our payment was successful!', 10, Theme.of(context).primaryColor);
      } else {
        Navigator.pushReplacementNamed(context, '/qrscanner' );
        getFlushbar(context, "Something went wrong, please scan QR code again!", 10, Theme.of(context).errorColor);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        body: Center(
            child: Stack(children: <Widget>[
          new Container(
            decoration: BoxDecoration(color: Theme.of(context).accentColor),
            height: _height,
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.network(
              "https://www.proto.utwente.nl/images/omnomcom/cookiemonster.png",
              height: _height,
            ),
          ),
          Center(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: new Text(
                    "Would you like to approve the following:",
                    style: Style.headerWhiteTextStyle.copyWith(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: getQRInfo(),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RaisedButton(
                      child: const Text("Cancel"),
                      color:Theme.of(context).errorColor,
                      onPressed: (() {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    RaisedButton(
                      child: const Text("Approve"),
                      color: Theme.of(context).primaryColor,
                      onPressed: (() {
                        _payOmnomcom();
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ])));
  }
}
