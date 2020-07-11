import 'package:ankev928/models/quote.dart';
import 'package:ankev928/shared/styling/card.dart';
import 'package:ankev928/shared/styling/card_autoHeight.dart';
import 'package:ankev928/shared/styling/separator.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/pages/quote/get_quotes.dart';
import 'package:intl/intl.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuoteCornerPage extends StatefulWidget {
  @override
  _QuoteCornerPage createState() => _QuoteCornerPage();
}

class _QuoteCornerPage extends State<QuoteCornerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto'),
        ),
        drawer: DefaultDrawer(),
        body: FutureBuilder(
          future: getQuotes(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (snap.data != null) {
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new QuoteListView(snap.data[index]);
                  });
            } else {
              return Text("hoi op omomcom");
            }
          },
        ));
  }
}

class QuoteListView extends StatelessWidget {
  final Quote _quote;

  QuoteListView(this._quote);

  @override
  Widget build(BuildContext context) {
    String _quotePoster = _quote.userId.toString();
 //   String _quoteDate = formatDate(_quote.created);
    final activityCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(height: 4.0),
            Text("Posted by $_quotePoster"),
            Separator(),
            new IntrinsicHeight(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: new IconTheme(
                          data:
                              new IconThemeData(color: const Color(0xff6c757d)),
                          child: FaIcon(FontAwesomeIcons.quoteLeft)),
                    )),
                Expanded(
                  child: Text(
                    _quote.quote,
                  ),
                ),
                new Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: new IconTheme(
                          data:
                              new IconThemeData(color: const Color(0xff6c757d)),
                          child: FaIcon(FontAwesomeIcons.quoteRight)),
                    )),
              ],
            )),
            Align(
              alignment: Alignment.bottomRight,
              child: Separator(),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  new DateFormat('EEE, d MMM yyyy').format(_quote.created),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                    fontSize: 12.0,
                  ),
                )),
            new Container(
              height: 2.0,
            ),
          ]),
    );

    return new GestureDetector(
      onTap: null,
      child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: cardLayoutAutoHeight(true, activityCardContent), //154.0),
        //activityThumbNail,
      ),
    );
  }
}

