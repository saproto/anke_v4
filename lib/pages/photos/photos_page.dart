import 'package:ankev928/models/photo_album.dart';
import 'package:flutter/material.dart';



class PhotoPage extends StatefulWidget {
  final PhotoAlbum _photoAlbum;

  PhotoPage(this._photoAlbum);

  @override
  _PhotoPage createState() => _PhotoPage(this._photoAlbum);
}

class _PhotoPage extends State<PhotoPage> {
  PhotoAlbum _photoAlbum;

  _PhotoPage(this._photoAlbum);

  @override
  void initState() {
    super.initState();
    _photoAlbum = widget._photoAlbum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_photoAlbum.name),
        ),
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text(_photoAlbum.name),
            ])));
  }
}
