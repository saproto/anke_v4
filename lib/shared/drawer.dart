import 'package:ankev928/models/user_info.dart';
import 'package:flutter/material.dart';

class DefaultDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(UserInfoInheritedWidget.of(context)
                    .userInfo
                    .getUserAttribute('display_name') ??
                'Not logged in'),
            accountEmail: Text(UserInfoInheritedWidget.of(context)
                    .userInfo
                    .getUserAttribute('email') ??
                ''),
            currentAccountPicture: _getPhotoThumbnail(context),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              _navigateTo('/home', context);
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calendar'),
            onTap: () {
              _navigateTo('/calendar', context);
            },
          ),
          ListTile(
            leading: Icon(Icons.format_align_justify),
            title: Text('News'),
            onTap: () {
              _navigateTo('/news', context);
            },
          ),
          ListTile(
            leading: _getIconLoginLogout(context),
            title: Text(_checkLoginLogout(context)),
            onTap: () {
              _navigateTo('/' + _checkLoginLogout(context), context);
            },
          ),
        ],
      ),
    );
  }

  void _navigateTo(String route, BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed(route);
  }

  Icon _getIconLoginLogout(BuildContext context){
    if (UserInfoInheritedWidget.of(context)
        .userInfo
        .getUserAttribute('is_logged_in')) {
     return Icon(Icons.lock);
    } else return Icon(Icons.lock_open);
  }

  String _checkLoginLogout(BuildContext context) {
    if (UserInfoInheritedWidget.of(context)
        .userInfo
        .getUserAttribute('is_logged_in')) {
      return 'logout';
    } else {
      return 'login';
    }
  }

  CircleAvatar _getPhotoThumbnail(BuildContext context) {
    dynamic isLoggedIn = UserInfoInheritedWidget.of(context)
        .userInfo
        .getUserAttribute('is_logged_in');
    if (isLoggedIn != null && isLoggedIn == true) {
      return new CircleAvatar(
          backgroundImage: NetworkImage(UserInfoInheritedWidget.of(context)
              .userInfo
              .getUserAttribute('photo_url')));
    } else {
      return new CircleAvatar();
    }
  }
}
