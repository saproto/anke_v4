import 'package:ankev928/services/user_info_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class DefaultDrawer extends StatefulWidget {
  _DefaultDrawer createState() => _DefaultDrawer();
}

class _DefaultDrawer extends State<DefaultDrawer> {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();


  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: StreamBuilder(
          stream: _userInfoService.stream$,
          builder: (BuildContext context, AsyncSnapshot snap) {
            return new ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: getName(snap),
                  accountEmail: getEmail(snap),
                  currentAccountPicture: _getPhotoThumbnail(snap),
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
                  leading: _getIconLoginLogout(snap),
                  title: Text(_checkLoginLogout(snap)),
                  onTap: () {
                    _navigateTo('/' + _checkLoginLogout(snap), context);
                  },
                ),
              ],
            );
          }),
//
    );
  }


  Text getName(AsyncSnapshot snap){
    if(snap.data != null){
      return new Text(snap.data.displayName );
    } else {
      return new Text('Not logged in');
    }
  }

  Text getEmail(AsyncSnapshot snap){
    if(snap.data != null){
      return new Text(snap.data.email );
    } else {
      return new Text('');
    }
  }

  void _navigateTo(String route, BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed(route);
    //Navigator.of(context).pushNamedAndRemoveUntil(route, ModalRoute.withName('/home'));
  }

  Icon _getIconLoginLogout(AsyncSnapshot snap) {
    if (snap.data != null && snap.data.isLoggedIn) {
      return Icon(Icons.lock);
    } else
      return Icon(Icons.lock_open);
  }

  String _checkLoginLogout(AsyncSnapshot snap) {
    if (snap.data != null && snap.data.isLoggedIn) {
      return 'logout';
    } else {
      return 'login';
    }
  }

  CircleAvatar _getPhotoThumbnail(AsyncSnapshot snap) {

    if (snap.data != null && snap.data.isLoggedIn == true) {
      return new CircleAvatar(
          backgroundImage:
              NetworkImage(snap.data.photoUrl));
    } else {
      return new CircleAvatar();
    }
  }
}
