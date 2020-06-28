import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/shared/styling/block.dart';
import 'package:ankev928/shared/styling/block_content.dart';

import 'package:ankev928/pages/photos/photos_page.dart';
import 'package:ankev928/pages/photos/get_photo_albums.dart';

import 'package:ankev928/models/photo_album.dart';


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
        child: block(blockContent(
            title: snapshot.data[i].name,
            date: snapshot.data[i].albumDate,
            maxlines: 2)),


      )));
    }
  }
  return tiles;
}
