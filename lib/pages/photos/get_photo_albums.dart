import 'package:ankev928/models/photo_album.dart';
import 'package:ankev928/shared/helpers/api_call.dart';



Future<List<PhotoAlbum>> getPhotoAlbums(String url,
    {noAuthPresentOk = false}) async {
  List<dynamic> photoAlbumsInfo =
  await doApiGetRequestAuthenticate(url, noAuthPresentOk: noAuthPresentOk);
  List<PhotoAlbum> photoAlbums = [];
  for (var i in photoAlbumsInfo) {
    DateTime photoAlbumDate;
    if( i["date_taken"]!= null){
      photoAlbumDate = DateTime.fromMillisecondsSinceEpoch(i["date_taken"] * 1000);
    }

    PhotoAlbum photoAlbum = PhotoAlbum(
      id: i["id"],
      name: i["name"],
      albumDate: photoAlbumDate,
    );
    photoAlbums.add(photoAlbum);
  }

  return photoAlbums;
}
