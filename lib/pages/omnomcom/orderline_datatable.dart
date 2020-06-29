import 'dart:ui';

import 'package:ankev928/models/orderline.dart';
import 'package:ankev928/shared/styling/separator.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/pages/omnomcom/getOrderlines.dart';
import 'package:intl/intl.dart';

class OrderlineDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOrders(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            List<List<Orderline>> seperatedOrderlines =
                getListOfOrderlines(snapshot.data);
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0,),
                    constraints: new BoxConstraints.expand(),
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
                    child: ListView.builder(
                        itemCount: seperatedOrderlines.length,
                        itemBuilder: (BuildContext context, int index) {
                          return getTableOfOrderline(
                              seperatedOrderlines[index], context);
                        }))));
          }
          return Text("loading");
        });
  }
}

Container getTableOfOrderline(
    List<Orderline> _orderlines, BuildContext context) {
  return Container(
    margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(children: <Widget>[
          Text(_getCorrectFormatDate(_orderlines[0].purchaseDate),
              style: Style.headerTextStyle.copyWith(color: const Color(0xff6c757d)))
        ]),
        Separator(),
        for (int i = 0; i < _orderlines.length; i++)
          getDataForOneRow(_orderlines[i], context)
      ],
    ),
  );
}

Row getDataForOneRow(Orderline orderline, BuildContext context) {
  final formatCurrency =
      new NumberFormat.currency(locale: "en_US", symbol: "€");
  final widthColumns = MediaQuery.of(context).size.width / 6;
  return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 2,
    fit: FlexFit.tight,
          child: new Container(
            width: widthColumns,
            child: new Text('${formatCurrency.format(orderline.totalPrice)}',),
          ),
        ),
        Flexible(
          flex: 1 ,
        fit: FlexFit.tight,
          child: new Container(
            width: widthColumns / 2,
            child: new Text(orderline.units.toString() + 'x',
            style: Style.commonTextStyleGreyColor.copyWith(fontWeight: FontWeight.w100) ,),
          ),
        ),
        Flexible(
          flex: 6,
          fit: FlexFit.loose,
          child: new Container(
            width: widthColumns * 100,
            child: new Text(
              orderline.productName.toString(),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Container(
            width: widthColumns,
            child: new Text(
              _getTime(orderline.purchaseDate),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ]);
}

List<List<Orderline>> getListOfOrderlines(List<Orderline> _orderlines) {
  List<List<Orderline>> _orderlinesPerDay = [];
  for (int i = 0; i < _orderlines.length; i++) {
    DateTime currentOrderline =
        stripTimeFromDateTime(_orderlines[i].purchaseDate);
    if (i == 0) {
      _orderlinesPerDay
          .add(orderLinesForCertainDate(_orderlines, currentOrderline));
    } else {
      DateTime previousOrderline =
          stripTimeFromDateTime(_orderlines[i - 1].purchaseDate);
      if (currentOrderline != previousOrderline) {
        _orderlinesPerDay
            .add(orderLinesForCertainDate(_orderlines, currentOrderline));
      }
    }
  }
  return _orderlinesPerDay;
}

List<Orderline> orderLinesForCertainDate(
    List<Orderline> _orderlines, DateTime dayDate) {
  List<Orderline> todaysOrderlines = [];
  for (int i = 0; i < _orderlines.length; i++) {
    if (stripTimeFromDateTime(_orderlines[i].purchaseDate) == dayDate) {
      todaysOrderlines.add(_orderlines[i]);
    }
  }
  return todaysOrderlines;
}

DateTime stripTimeFromDateTime(DateTime date) {
  final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
  final String formatted = serverFormater.format(date);
  final DateTime onlyDate = DateTime.parse(formatted);
  return onlyDate;
}

String _getCorrectFormatDate(DateTime date) {
  var formatDate = new DateFormat('EEE, d MMM yyyy');
  return formatDate.format(date);
}

String _getTime(DateTime date) {
  var formatDate = new DateFormat('HH:mm');
  return formatDate.format(date);
}
