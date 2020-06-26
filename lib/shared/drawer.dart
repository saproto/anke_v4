import 'package:ankev928/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefaultDrawer extends StatefulWidget {
  _DefaultDrawer createState() => _DefaultDrawer();
}

class _DefaultDrawer extends State<DefaultDrawer> {
  bool _showAccountMenu = false;

  void _toggleAccountMenu() {
    setState(() {
      _showAccountMenu = !_showAccountMenu;
    });
  }
//  List menuItems= [
//    {
//      'icon':Icon(Icons.home),
//      'Name': 'Home',
//      'route':'/home',
//    },
//    {
//      'icon':Icon(Icons.calendar_today),
//      'Name': 'Calendar',
//      'route':'/calendar',
//    },{
//      'icon':FaIcon(FontAwesomeIcons.newspaper),
//      'Name': 'News',
//      'route':'/news',
//    },{
//      'icon':FaIcon(FontAwesomeIcons.cookieBite),
//      'Name': 'Omnomcom',
//      'route':'/omnomcom',
//    },{
//      'icon':FaIcon(FontAwesomeIcons.camera),
//      'Name': 'Photos',
//      'route':'/photos',
//    },
//    {
//      'icon':FaIcon(FontAwesomeIcons.comments),
//      'Name': 'Quote Corner',
//      'route':'/quote',
//    },
//  ];
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(UserInfoInheritedWidget
                .of(context)
                .userInfo
                .getUserAttribute('display_name') ??
                'Not logged in'),
            accountEmail: Text(UserInfoInheritedWidget
                .of(context)
                .userInfo
                .getUserAttribute('email') ??
                ''),
            currentAccountPicture: _getPhotoThumbnail(context),
            onDetailsPressed: () {
              _toggleAccountMenu();
            },
          ),
          Visibility(
            visible: _showAccountMenu,
            child: new  Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
              child:  ListTile(
                leading: Icon(Icons.home),
                title: Text('Profile'),
                onTap: () {
                  _navigateTo('/profile', context);
                },
              ),
            ),
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
            leading: FaIcon(FontAwesomeIcons.newspaper),
            title: Text('News'),
            onTap: () {
              _navigateTo('/news', context);
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.cookieBite),
            title: Text('Omnomcom'),
            onTap: () {
              _navigateTo('/omnomcom', context);
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.camera),
            title: Text('Photos'),
            onTap: () {
              _navigateTo('/photos', context);
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.comments),
            title: Text('Quote Corner'),
            onTap: () {
              _navigateTo('/quote', context);
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
    //Navigator.of(context).pushNamedAndRemoveUntil(route, ModalRoute.withName('/home'));
  }

 static Icon _getIconLoginLogout(BuildContext context) {
    if (UserInfoInheritedWidget
        .of(context)
        .userInfo
        .getUserAttribute('is_logged_in')) {
      return Icon(Icons.lock);
    } else
      return Icon(Icons.lock_open);
  }

  String _checkLoginLogout(BuildContext context) {
    if (UserInfoInheritedWidget
        .of(context)
        .userInfo
        .getUserAttribute('is_logged_in')) {
      return 'logout';
    } else {
      return 'login';
    }
  }

  CircleAvatar _getPhotoThumbnail(BuildContext context) {
    dynamic isLoggedIn = UserInfoInheritedWidget
        .of(context)
        .userInfo
        .getUserAttribute('is_logged_in');
    if (isLoggedIn != null && isLoggedIn == true) {
      return new CircleAvatar(
          backgroundImage: NetworkImage(UserInfoInheritedWidget
              .of(context)
              .userInfo
              .getUserAttribute('photo_url')));
    } else {
      return new CircleAvatar();
    }
  }
}
