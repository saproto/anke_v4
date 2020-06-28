import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:ankev928/models/information_alfred.dart';
import 'package:ankev928/shared/styling/block.dart';
import 'package:ankev928/shared/styling/block_content.dart';
import 'package:ankev928/shared/styling/block_content_widgets.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/helpers/api_call.dart';

class IsAlfredThere extends StatelessWidget {
  final DateTime date = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getInformationOnAlfred(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data.status == "there") {
            return block(blockContentWidgets(
              title: "Alfred?",
              icon: "assets/img/there.png",
              secondText: "is there!",
            ));
          } else {
            String dateBack = getFormatDate(snapshot.data.dateBack);
            return block(blockContentWidgets(
              title: "Alfred?",
              icon: "assets/img/not_there.png",
              secondText: "is back at: \n$dateBack",
            ));
          }
        } else {
          return block(blockContent(title: "loading", date: date, maxlines: 2));
        }
      },
    );
  }
}

String getFormatDate(DateTime date){
  var formatDate = new DateFormat('EEE, d MMM  HH:mm');
  return formatDate.format(date);
}

Future<InformationAlfred> _getInformationOnAlfred() async {
  var _infoOnAlfred = await requestApiCallResult('isalfredthere');
  DateTime dateBack;
  if (_infoOnAlfred["back"] != null) {
    dateBack =
        DateTime.fromMillisecondsSinceEpoch(_infoOnAlfred["backunix"] * 1000);
  }
  return new InformationAlfred(
    status: _infoOnAlfred["status"],
    dateBack: dateBack,
  );
}
