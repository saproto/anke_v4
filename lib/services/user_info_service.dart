import 'package:ankev928/models/user_info.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserInfoService {
  BehaviorSubject _userInfo = BehaviorSubject.seeded(new UserInfo(isLoggedIn: false));

  Stream get stream$ => _userInfo.stream;

  UserInfo get current => _userInfo.value;

  update(UserInfo _updatedUserInfo) {
    _userInfo.add(_updatedUserInfo);
  }

  Future readFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    update(new UserInfo(
      isLoggedIn: prefs.getBool("isLoggedIn") ?? false,
      displayName: prefs.getString("displayName") ?? null,
      userName: prefs.getString("userName") ?? null,
      email: prefs.getString("email") ?? null,
      photoUrl: prefs.getString("photoUrl") ?? null,
      id: prefs.getInt("id") ?? null,
      welcomeMessage: prefs.getString("welcomeMessage") ?? null,
    ));
  }

  void writeToSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", current.isLoggedIn);
    prefs.setString("displayName", current.displayName);
    prefs.setString("userName", current.userName);
    prefs.setString("email", current.email);
    prefs.setString("photoUrl", current.photoUrl);
    prefs.setInt("id", current.id);
    prefs.setString("welcomeMessage", current.welcomeMessage);
  }

  void updateFromJson(Map<String, dynamic> json) {
    update(new UserInfo(
      isLoggedIn: true,
      displayName: json['calling_name'],
      userName: json['username'],
      email: json['email'],
      photoUrl: json['photo_preview'],
      id: json['id'],
      welcomeMessage: json['welcome_message'],
    ));
    writeToSharedPrefs();
  }

  void reset() {
    update(new UserInfo(
      isLoggedIn: false,
      displayName: null,
      userName: null,
      email: null,
      photoUrl: null,
      id: null,
      welcomeMessage: null,
    ));
  }

  Future resetAndWriteToSharedPrefs() async {
    reset();
    writeToSharedPrefs();
  }
}
