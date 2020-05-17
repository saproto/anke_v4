import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<UserInfoAttribute> sharedPrefAttributes = [
  new UserInfoAttribute(name: 'is_logged_in', type: bool),
  new UserInfoAttribute(name: 'display_name', type: String),
  new UserInfoAttribute(name: 'user_name', type: String),
  new UserInfoAttribute(name: 'email', type: String),
  new UserInfoAttribute(name: 'photo_url', type: String),
];

class UserInfoAttribute {
  String name;
  dynamic type;
  UserInfoAttribute({this.name, this.type});
}

class UserInfo {

  Map<String, dynamic> userInfo;

  UserInfo(){
    resetInternalUserInfo();
  }

  Future getAttributesFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(UserInfoAttribute attribute in sharedPrefAttributes){
      if(attribute.type == bool){
        userInfo[attribute.name] = prefs.getBool(attribute.name) ?? false;
      } else if(attribute.type == String){
        userInfo[attribute.name] = prefs.getString(attribute.name) ?? null;
      }
    }
  }

  void setAttributesFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(UserInfoAttribute attribute in sharedPrefAttributes){
      if(attribute.type == bool){
       prefs.setBool(attribute.name, userInfo[attribute.name]);
      } else if(attribute.type == String){
        prefs.setString(attribute.name, userInfo[attribute.name]);
      }
    }
  }

  dynamic getUserAttribute(String attribute){
    return userInfo[attribute];
  }
  

  void updateFromJson(Map<String, dynamic> json) {
    userInfo['is_logged_in'] = true;
    userInfo['display_name'] = json['calling_name'];
    userInfo['email'] = json['email'];
    userInfo['photo_url']= json['photo_preview'];
    setAttributesFromSharedPrefs();
  }

  Future resetUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(UserInfoAttribute attribute in sharedPrefAttributes){
      if(attribute.type == bool){
        prefs.setBool(attribute.name, false);
      } else if(attribute.type == String){
        prefs.setString(attribute.name, null);
      }

    }

    resetInternalUserInfo();
  }

  void resetInternalUserInfo(){
    userInfo = new Map<String, dynamic>();

    for(UserInfoAttribute attribute in sharedPrefAttributes){
      if(attribute.type == bool){
        userInfo[attribute.name] = false;
      } else if(attribute.type == String){
        userInfo[attribute.name] = null;
      }
    }
  }

}

class UserInfoInheritedWidget extends InheritedWidget {
  final UserInfo userInfo;

  UserInfoInheritedWidget({this.userInfo, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UserInfoInheritedWidget of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(UserInfoInheritedWidget);
}