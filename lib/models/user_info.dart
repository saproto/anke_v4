import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserInfo extends Object {

  bool isLoggedIn;
  String displayName;
  String userName;
  String fullName;
  String email;
  String photoUrl;
  int id;
  String welcomeMessage;

  UserInfo({
    this.isLoggedIn,
    this.displayName,
    this.userName,
    this.fullName,
    this.email,
    this.photoUrl,
    this.id,
    this.welcomeMessage,
  });

}