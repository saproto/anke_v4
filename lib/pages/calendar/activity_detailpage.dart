import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ankev928/models/activity.dart';
import 'package:ankev928/pages/calendar/activity_list_view.dart';
import 'dart:convert';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import 'package:ankev928/shared/textstyle.dart';
import 'package:ankev928/shared/functions.dart';
import 'package:ankev928/shared/api_call.dart';

import 'separator.dart';

class ActivityDetailPage extends StatefulWidget {
  final Activity _activity;

  ActivityDetailPage(this._activity);

  @override
  _DetailPageState createState() => _DetailPageState(this._activity);
}

class _DetailPageState extends State<ActivityDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Activity _activity;

  _DetailPageState(this._activity);

  @override
  void initState() {
    _activity = widget._activity;
  }

  @override
  Widget build(BuildContext context) {
    Container _getBackground() {
      if (_activity.imgUrl != null) {
        return new Container(
          child: new Image.network(
            _activity.imgUrl,
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

    Container _getGradient() {
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

    Column _getToolbar(BuildContext context) {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
            margin:
                new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: new Align(
              alignment: Alignment.topLeft,
              child: new BackButton(color: Colors.black),
            ),
          )
        ],
      );
    }

    Text _userSignedUpTextField(Activity activity) {
      if (activity.userHasSignedUp) {
        return new Text(
          "You are signed up",
          style: Style.commonTextStyleGreyColor,
        );
      } else if (activity.userHasSignedUpBackUp) {
        return new Text(
          "You are placed on the back-up list",
          style: Style.commonTextStyleGreyColor,
        );
      } else {
        return new Text(
          "You are not signed up for this activity",
          style: Style.commonTextStyleGreyColor,
        );
      }
    }

    Text _hasNoShowFeeTextField(Activity activity) {
      if (activity.noShowFee != 0) {
        return new Text(
          "Not showing up can cost you: €" + activity.noShowFee.toString(),
          style: Style.commonTextStyleGreyColor,
        );
      }
      return null;
    }

    Future<void> _signUp(Activity activity, bool signup) async {
      try {
        var signUpRequest = await requestApiCallResult(
            'events/signup/' + activity.id.toString());
        var decodedSignUpRequest = jsonDecode(signUpRequest["message"]);
        if (decodedSignUpRequest.containsKey("participation_id")) {
          if (signup) {
            setState(() {
              activity.userHasSignedUp = true;
              activity.userSingUpId = decodedSignUpRequest["participation_id"];
            });
          } else {
            setState(() {
              activity.userHasSignedUpBackUp = true;
              activity.userSingUpId = decodedSignUpRequest["participation_id"];
            });
          }
        }
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(decodedSignUpRequest["message"]),
        ));
      } catch (Exception) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
              "Something went wrong during sign-up. Please restart the app and try again."),
        ));
      }
    }

    Future<void> _signOut(Activity activity) async {
      try {
        Map<String, dynamic> signOutRequest = await requestApiCallResult(
            'events/signout/' + activity.userSingUpId.toString());
        var decodedSignOutRequest = jsonDecode(signOutRequest["message"]);
        if (decodedSignOutRequest['success']) {
          setState(() {
            activity.userHasSignedUp = false;
            activity.userHasSignedUpBackUp = false;
          });
        }
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(decodedSignOutRequest["message"]),
        ));
      } catch (Exception) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
              "Something went wrong during sign-out. Please restart the app and try again."),
        ));
      }
    }

    RaisedButton _signUpBackUpListButton(Activity activity) {
      if (activity.canSignUpBackUp &&
          !activity.userHasSignedUpBackUp &&
          !activity.canSignUp) {
        return new RaisedButton(
          child: const Text("Signup closed! Put me on the back-up list."),
          onPressed: (() {
            _signUp(activity, false);
          }),
        );
      }
      return null;
    }

    RaisedButton _signUpButton(Activity activity) {
      if (activity.canSignUp && !activity.userHasSignedUp) {
        return new RaisedButton(
          child: const Text("Sign me up!"),
          onPressed: (() {
            _signUp(activity, true);
          }),
        );
      }
      return null;
    }

    RaisedButton _signOutButton(Activity activity) {
      if (activity.canSignOut && activity.userHasSignedUp) {
        return new RaisedButton(
          child: const Text("Sign me out"),
          onPressed: (() {
            _signOut(activity);
          }),
        );
      } else if (activity.userHasSignedUpBackUp) {
        return new RaisedButton(
          child: const Text("Take me off the back-up list"),
          onPressed: (() {
            _signOut(activity);
          }),
        );
      }
      return null;
    }

    Text _getAmountOfAvailablePlaces(Activity activity) {
      if (activity.availablePlaces == -1) {
        return new Text("There are unlimited places available");
      } else if (activity.availablePlaces > 0 && activity.canSignUp) {
        String availablePlaces = activity.availablePlaces.toString();
        String totalPlaces = activity.totalPlaces.toString();
        return new Text(
            "There are $availablePlaces out of $totalPlaces places available");
      } else if (activity.isFull) {
        return null;
      }
      return null;
    }

    Text _signUpInformation(Activity activity) {
      var formatDate = new DateFormat('EEE, d MMM  HH:mm');
      String startSignup = formatDate.format(activity.startSignup);
      String endSignup = formatDate.format(activity.endSignup);
      String endSignOut = formatDate.format(activity.endSignout);
      return new Text(
          "Sign up opens at: $startSignup \nand closes at: $endSignup \n"
          "It is possible to sign out till: $endSignOut");
    }

    Column _hasSignUp(Activity activity) {
      if (activity.hasSignUp) {
        return new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(10)),
              new Text(
                "Signup information".toUpperCase(),
                style: Style.headerTextStyle,
              ),
              new Separator(),
              _userSignedUpTextField(activity),
              new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
              new Text(
                "Activity Cost: €" + activity.price.toString(),
                style: Style.commonTextStyleGreyColor,
              ),
              _hasNoShowFeeTextField(activity),
              _getAmountOfAvailablePlaces(activity),
              new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
              _signUpInformation(activity),
              _signUpButton(activity),
              _signUpBackUpListButton(activity),
              _signOutButton(activity),
            ].where(notNull).toList());
      }
      return null;
    }

    _launchURL(url) async {
      if (await urlLauncher.canLaunch(url)) {
        await urlLauncher.launch(url);
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Something went wrong. Could not launch $url."),
        ));
      }
    }

    Row _getRow(var participants) {
      return new Row(children: <Widget>[]);
    }

    List<Row> _getParticipantsList(var participants) {
      List<Row> participantsList = [];
      for (int par = 0; par < participants.length; par++) {
        participantsList.add(new Row(
          children: <Widget>[
            new Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 40)),
            CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                backgroundImage: NetworkImage(participants[par]["photo"])),
            new Padding(padding: EdgeInsets.fromLTRB(0, 5, 10, 5)),
            Text(participants[par]["name"]),
          ],
        ));
      }
      return participantsList;
    }

    Column _getParticipants(List<dynamic> participants, String title) {
      if (participants != null) {
        return new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(10)),
              new Text(
                title.toUpperCase(),
                style: Style.headerTextStyle,
              ),
              new Separator(),
              ..._getParticipantsList(participants),
            ]);
      }
      return null;
    }

    Widget _getContent() {
      final _overwiewTitle = "Description".toUpperCase();
      return new ListView(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0),
        children: <Widget>[
          new Container(
            child: new Stack(
              children: <Widget>[
                _getBackground(),
                _getGradient(),
                new Column(
                  children: <Widget>[
                    new ActivityListView(_activity, horizontal: false),
                    new Container(
                      padding: new EdgeInsets.symmetric(horizontal: 32.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            _overwiewTitle,
                            style: Style.headerTextStyle,
                          ),
                          new Separator(),
                          MarkdownBody(
                            data: _activity.description,
                            onTapLink: (url) {
                              _launchURL(url);
                            },
                          ),
                          _hasSignUp(_activity),
                          _getParticipants(_activity.participants, "participants"),
                          _getParticipants(_activity.participantsBackUpList, "The back-up list")
                        ].where(notNull).toList(),
                      ),
                    ),
                  ],
                ),
                _getToolbar(context)
              ],
            ),
          )
        ],
      );
    }

    return new Scaffold(
        key: _scaffoldKey,
        body: new Container(
          color: Theme.of(context).backgroundColor,
          constraints: new BoxConstraints.expand(),
          child: new Stack(children: <Widget>[
            _getContent(),
          ]),
        ));
  }
}
