import 'package:ankev928/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Future didChangeDependencies() async {
    super.didChangeDependencies();
    await UserInfoInheritedWidget.of(context)
        .userInfo
        .getAttributesFromSharedPrefs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S.A. Proto'),
      ),
      drawer: DefaultDrawer(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Welcome to S.A. Proto, ' +
                  (UserInfoInheritedWidget.of(context)
                          .userInfo
                          .getUserAttribute('display_name') ??
                      'go to login' + '!'),
              style: TextStyle(fontSize: 50),
            ),
            RaisedButton(
                onPressed: () {
              print(UserInfoInheritedWidget.of(context)
                  .userInfo
                  .getUserAttribute('display_name'));
            }),
          ],
        ),
      ),
    );
  }
}
