import 'package:ankev928/pages/photos/photos_page.dart';
import 'package:ankev928/shared/separator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/shared/block.dart';

import 'package:ankev928/models/photo_album.dart';
import 'package:ankev928/pages/photos/get_photo_albums.dart';
import 'package:intl/intl.dart';

import 'package:ankev928/shared/textstyle.dart';

class PhotoAlbumsPage extends StatefulWidget {
  @override
  _PhotoAlbumsPage createState() => _PhotoAlbumsPage();
}

class _PhotoAlbumsPage extends State<PhotoAlbumsPage> {
  Future<List<PhotoAlbum>> _futurePhotoAlbum;

  @override
  void initState() {
    super.initState();
    _futurePhotoAlbum = getPhotoAlbums();
  }

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _widthColumn = getBlockWidth();
    int _amountColumns = _widthScreen ~/ _widthColumn;
    print(_amountColumns);
    return Scaffold(
      appBar: AppBar(
        title: Text('S.A. Proto Photos'),
      ),
      drawer: DefaultDrawer(),
      body: FutureBuilder(
          future: _futurePhotoAlbum,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return GridView.count(
              padding: new EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
              crossAxisCount: _amountColumns,
              children: _getBlocks(context, snapshot),
            );
          }),
    );
  }
}

List<Widget> _getBlocks(BuildContext context, AsyncSnapshot snapshot) {
  final List<Widget> tiles = <Widget>[];
  if (snapshot.data != null) {
    for (int i = 0; i < snapshot.data.length; i++) {
      tiles.add(new GridTile(
          child: new GestureDetector(
        onTap: (() {
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new PhotoPage(snapshot.data[i])));
        }),
        child: block(blockContent(snapshot.data[i])),

//              new Stack(
//                children: <Widget>[
//                  block(),
//                  //blockContent(snapshot.data[i]),
//                ],
//              )
      )));
    }
  }
  return tiles;
}

Container blockContent(PhotoAlbum photoAlbum) {
  return new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Text(
              photoAlbum.name,
              style: Style.headerTextStyle.copyWith(color: Color(0xff6c757d)),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
          Flexible(
              flex: 0,
              fit: FlexFit.tight,
              child: new Container(
                height: 2.0,
              )),
          Separator(),
          Flexible(
              flex: 0,
              fit: FlexFit.tight,
              child: new Container(
                height: 2.0,
              )),
          Flexible(
            flex: 1,
            child: Text(
              _getCorrectFormatDate(photoAlbum.albumDate),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          )
          ,
        ],
      ));
}

String _getCorrectFormatDate(DateTime date) {
  var formatDate = new DateFormat('EEE, d MMM yyyy');
  return formatDate.format(date);
}
