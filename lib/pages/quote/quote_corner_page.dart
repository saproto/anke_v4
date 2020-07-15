//import 'dart:html'

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/pages/quote/quote_list_tile.dart';

import 'package:ankev928/pages/quote/quotes_stream.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'add_quote_page.dart';

class QuoteCornerPage extends StatefulWidget {
  const QuoteCornerPage({
    Key key,
  }) : super(key: key);

  @override
  _QuoteCornerPage createState() => _QuoteCornerPage();
}

class _QuoteCornerPage extends State<QuoteCornerPage> {
  final scrollController = ScrollController();
  QuotesStream quotes;

  @override
  void initState() {
    quotes = QuotesStream();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        quotes.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S.A. Proto Quotes '),
      ),
      drawer: DefaultDrawer(),
      body: StreamBuilder(
        stream: quotes.stream,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.data != null) {
            return
              RefreshIndicator(
                onRefresh: quotes.refresh,
                child: Stack(
                    children: <Widget>[
                ListView.builder(
                controller: scrollController,
                    itemCount: snap.data.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < snap.data.length) {
                        return new QuoteListTile(snap.data[index]);
                      } else if (quotes.hasMore) {
                        return Padding(
                          padding: new EdgeInsets.fromLTRB(
                              32.0, 16.0, 32.0, 80.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return Padding(
                          padding: new EdgeInsets.fromLTRB(
                              32.0, 16.0, 32.0, 80.0),
                          child: Center(
                              child: Text(
                                  'You wasted so much time scrolling to the bottom of the quote corner!')),
                        );
                      }
                    }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 8, 15),
                    child: RawMaterialButton(
                      elevation: 2.0,
                      fillColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.all(10),
                      child: FaIcon(FontAwesomeIcons.angleDoubleUp, size: 28.0,
                      color: Theme.of(context).backgroundColor,),
                      shape: CircleBorder(),
                      onPressed: ((){
                        scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }),
                  ),),
                )

                ],
              ));
          } else {
          return new Center(
          child: Text("Loading quotes"),
          );
          }
        },
      ),
      floatingActionButton:
      FloatingActionButton.extended(
          label: Text("add quote"),
          icon: FaIcon(FontAwesomeIcons.quoteRight),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          heroTag: null,
          onPressed: (() {
            Navigator.push(context,
              new MaterialPageRoute(builder: (context) => AddQuotePage()),)
                .then((value) {
              setState(() {
                quotes.refresh();
              });
            });
          })),
      //

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
