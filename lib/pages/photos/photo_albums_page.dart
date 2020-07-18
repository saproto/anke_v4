import 'package:ankev928/services/user_info_service.dart';
import 'package:ankev928/shared/styling/show_information_widget.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/shared/styling/block.dart';
import 'package:ankev928/shared/styling/block_content.dart';

import 'package:ankev928/pages/photos/photos_page.dart';
import 'package:ankev928/pages/photos/get_photo_albums.dart';

import 'package:ankev928/models/photo_album.dart';
import 'package:get_it/get_it.dart';

class PhotoAlbumsPage extends StatefulWidget {
  @override
  _PhotoAlbumsPage createState() => _PhotoAlbumsPage();
}

GetIt getIt = GetIt.instance;

class _PhotoAlbumsPage extends State<PhotoAlbumsPage> {
  Future<List<PhotoAlbum>> _futurePhotoAlbum;
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();

  @override
  void initState() {
    super.initState();
      }

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _widthColumn = getBlockWidth();
    int _amountColumns = _widthScreen ~/ _widthColumn;

    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto Photos', style: Style.headerPageTextStyle),
        ),
        drawer: DefaultDrawer(),
        body: StreamBuilder(
            stream: _userInfoService.stream$,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Future<List<PhotoAlbum>> photoAlbums;
              if (snapshot.hasData && snapshot.data.isLoggedIn) {
                photoAlbums = getPhotoAlbums('photos/photos_api');
              } else {
                photoAlbums = getPhotoAlbums('photos/photos', noAuthPresentOk: true);
              }
              return FutureBuilder(
                future: photoAlbums,
                builder: (BuildContext context, AsyncSnapshot snap) {
                  bool isUserLoggedIn = false;
                  if(snapshot.hasData) {
                    isUserLoggedIn = snapshot.data.isLoggedIn;

                    return GridView.count(
                      padding: new EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                      crossAxisCount: _amountColumns,
                      children: _getBlocks(context, snap, isUserLoggedIn),
                    );
                  } else {
                    return showInformationOnScreen("Loading albums");
                  }
                },
              );
            }));
  }
}

List<Widget> _getBlocks(BuildContext context, AsyncSnapshot snapshot, bool isUserLoggedIn) {
  final List<Widget> tiles = <Widget>[];
  if (snapshot.data != null) {
    for (int i = 0; i < snapshot.data.length; i++) {
      tiles.add(new GridTile(
          child: new GestureDetector(
        onTap: (() {
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new PhotoPage(snapshot.data[i], isUserLoggedIn)));
        }),
        child: block(blockContent(
            title: snapshot.data[i].name,
            date: snapshot.data[i].albumDate,
            maxlines: 2)),
      )));
    }
  }
  return tiles;
}
