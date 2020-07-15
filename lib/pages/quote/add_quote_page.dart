import 'package:ankev928/services/user_info_service.dart';
import 'package:ankev928/shared/helpers/api_call.dart';
import 'package:ankev928/shared/styling/card.dart';
import 'package:ankev928/shared/styling/separator.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

GetIt getIt = GetIt.instance;

class AddQuotePage extends StatefulWidget {
  @override
  AddQuotePageState createState() => AddQuotePageState();
}

class AddQuotePageState extends State<AddQuotePage> {
  String _quote;
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _getQuoteTextField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        fillColor: Colors.red,
        hintText: "With great quotes comes great responsibility",
        border: InputBorder.none,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Quote is required";
        }
        return null;
      },
      onSaved: (String value) {
        _quote = value;
      },
    );
  }

  Widget _buildQuoteField() {
    return Container(
      margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      child: StreamBuilder(
          stream: _userInfoService.stream$,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            String userName;
            if (snapshot.hasData) {
              userName = snapshot.data.displayName;
            } else {
              userName = "";
            }
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(height: 4.0),
                  Text("Awesome quote posted by: $userName"),
                  Separator(),
            new IntrinsicHeight(
            child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: new IconTheme(
                                  data: new IconThemeData(
                                      color: const Color(0xff6c757d)),
                                  child: FaIcon(FontAwesomeIcons.quoteLeft)),
                            )),
                        Flexible(
                          flex: 14,
                          child: _getQuoteTextField(),
                        ),
            Flexible(
            flex: 2,
            child: Align(
                alignment: Alignment.bottomRight,child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: new IconTheme(
                              data: new IconThemeData(
                                  color: const Color(0xff6c757d)),
                              child: FaIcon(FontAwesomeIcons.quoteRight)),
                        ))),
                      ])),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Separator(),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        new DateFormat('EEE, d MMM yyyy').format(DateTime.now()),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic,
                          fontSize: 12.0,
                        ),
                      )),
                  new Container(
                    height: 2.0,
                  )
                ]);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Stack(children: <Widget>[
          new Container(
            decoration: BoxDecoration(color: Theme.of(context).accentColor),
            height: MediaQuery.of(context).size.height,
          ),
          getToolbar(context),
          Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Separator(),
                      new Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: new Text(
                          "Add your own quote",
                          style: Style.headerWhiteTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Separator(),
                    ]),
                cardLayout(true, _buildQuoteField(), 190.0),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  child: Text("add quote"),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (!_formkey.currentState.validate()) {
                      return;
                    }
                    _formkey.currentState.save();
                    setState(() {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      submitQuote(_quote, context);
                    });

                    print(_quote);
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

void submitQuote(String _quote, BuildContext context) async {
  Map<String, String> data = {'quote': _quote};
  var awaitResponse = await doApiPostRequest('quotes/add', data);
  if (awaitResponse["success"] == true) {
    Navigator.pop(context);
    Flushbar(
      message: "Your quote is added!",
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 10),
    )..show(context);
  } else {
    Flushbar(
      message: "Something went wrong! Please try again later",
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 10),
    )..show(context);
  }
}

Column getToolbar(BuildContext context) {
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      new Container(
        margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: new Align(
          alignment: Alignment.topLeft,
          child: new BackButton(
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}
