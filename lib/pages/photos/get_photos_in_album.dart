import 'package:ankev928/models/photo_album.dart';
import 'package:ankev928/shared/api_call.dart';

Future<PhotoAlbumWithPhotos> getPhotosInAlbum(int id) async {
  Map<String, dynamic> photoAlbumPhotos =
      await requestApiCallResult('photos/photos_api/' + id.toString());
  print('hosadfopja');
  //Map<String, dynamic>  photosInAlbum = [][];
  List<Photo> photos = [];
  for (int i = 0; i < photoAlbumPhotos["photos"].length; i++) {
    dynamic photo = photoAlbumPhotos["photos"][i];
    photos.add(new Photo(photo["id"], photo["url"]));
//    Photos photoAlbum = Photos(
//      id: photoAlbumPhotos[i]["id"],
//      name: photoAlbumPhotos[i]["id"],
//     // photos: i["photos"]
//    );
//    photosInAlbum.addEntries(photoAlbum);
  }

  return new PhotoAlbumWithPhotos(albumID: int.parse(photoAlbumPhotos["album_id"]),
      albumName: photoAlbumPhotos["album_title"],
      albumThumbnail: photoAlbumPhotos["thumb"],
      photos: photos);
}
