import 'package:ankev928/models/photo_album.dart';
import 'package:ankev928/pages/photos/photo_scroll_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/pages/photos/get_photos_in_album.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    print("joi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_photoAlbum.name),
        ),
        body: FutureBuilder(
            future: getPhotosInAlbum(_photoAlbum.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return new StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: snapshot.data.photos.length,
                  padding: new EdgeInsets.fromLTRB(10, 10, 10, 10),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  itemBuilder: (BuildContext context, int index) =>
                      new _Tile(index, snapshot.data.photos),
                  staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Loading pictures',
                        style: TextStyle(fontSize: 35),
                      )
                    ],
                  ),
                );
              }
            }));
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.photos);
  final int index;
  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Center(
                  child:
//                new CachedNetworkImage(
//        imageUrl: photo.photoURL,
//        placeholder: (context, url) => CircularProgressIndicator(),   ),
                  new FadeInImage.assetNetwork(
                      placeholder: 'assets/img/loading.gif',
                      image: photos[index].photoURL),
                )
              ],
            )
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(new PageRouteBuilder (
        pageBuilder: (_,__, ___) => new PhotoScrollPage(photos, index),
      )),
    );
  }
}