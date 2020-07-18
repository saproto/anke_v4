import 'package:ankev928/pages/omnomcom/orderline_datatable.dart';
import 'package:ankev928/shared/helpers/api_call.dart';
import 'package:ankev928/shared/styling/card.dart';
import 'package:ankev928/shared/styling/separator.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:ankev928/shared/styling/title_style.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class OmnomcomPage extends StatefulWidget {
  @override
  _OmnomcomPage createState() => _OmnomcomPage();
}

class _OmnomcomPage extends State<OmnomcomPage> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);    //_futureActivity = getActivities();
  }

  @override
  void deactivate(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.deactivate();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto Omnomcom', style: Style.headerPageTextStyle),
        ),
        drawer: DefaultDrawer(),
        body: FutureBuilder(
          future: _getTotals(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return new Column(
                children: <Widget>[
                  new Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 24.0,
                      ),
                      alignment: Alignment.centerLeft,
                      child: cardLayout(
                          true, omnomcomHeaderContent(snapshot.data), 130)),
                  getTitle("Recent purchases"),
                  OrderlineDataTable(),
                ],
              );
            } else {
              return new Center(
                child: Text("Loading omnomcom"),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: Text("scanner"),
            icon: FaIcon(FontAwesomeIcons.qrcode),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: (() {
              Navigator.of(context).pushNamed('/qrscanner');
            })),
   // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Future<List<dynamic>> _getTotals() async {
  var _nextWithdrawal =
      await doApiGetRequestAuthenticate('user/orders/next_withdrawal');
  var _totalThisMonth = await doApiGetRequestAuthenticate('user/orders/total_month');

  return [_nextWithdrawal, _totalThisMonth];
}

Container omnomcomHeaderContent(List<dynamic> _totals) {
  final formatCurrency =
      new NumberFormat.currency(locale: "en_US", symbol: "€");
  final String currentMonth = getCurrentMonth(DateTime.now());
  return new Container(
    alignment: Alignment.centerLeft,
    margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
    constraints: new BoxConstraints.expand(),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(height: 4.0),
        Flexible(
          flex: 3,
          child: new Text(
            "Next withdrawal is: " + formatCurrency.format(_totals[0]),
            style: Style.headerTextStyle,
            textAlign: TextAlign.left,
            //overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        Flexible(
            flex: 0,
            fit: FlexFit.tight,
            child: new Container(
              height: 2.0,
            )),
        Separator(),
        Flexible(
            flex: 0,
            fit: FlexFit.tight,
            child: new Container(
              height: 2.0,
            )),
        Flexible(
          flex: 3,
          child: new Text(
            "Total spend in $currentMonth is: " +
                formatCurrency.format(_totals[1]),
          ),
        ),
        // ],
        //  )
      ],
    ),
  );
}

String getCurrentMonth(DateTime date) {
  var formatDate = new DateFormat('MMMM yyyy');
  return formatDate.format(date);
}
