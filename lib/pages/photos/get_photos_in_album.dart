import 'package:ankev928/models/photo_album.dart';
import 'package:ankev928/shared/helpers/api_call.dart';

Future<PhotoAlbumWithPhotos> getPhotosInAlbum(int id, String url,
    {noAuthPresentOk = false}) async {
  Map<String, dynamic> photoAlbumPhotos =
      await doApiGetRequestAuthenticate(url + id.toString(), noAuthPresentOk: noAuthPresentOk);
  List<Photo> photos = [];
  for (int i = 0; i < photoAlbumPhotos["photos"].length; i++) {
    dynamic photo = photoAlbumPhotos["photos"][i];
    photos.add(new Photo(photo["id"], photo["url"]));
  }

  return new PhotoAlbumWithPhotos(
      albumID: int.parse(photoAlbumPhotos["album_id"]),
      albumName: photoAlbumPhotos["album_title"],
      albumThumbnail: photoAlbumPhotos["thumb"],
      photos: photos);
}
