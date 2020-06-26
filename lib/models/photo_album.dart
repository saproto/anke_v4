class PhotoAlbum {
  final int id;
  final String name;
  final DateTime albumDate;

  PhotoAlbum({this.id, this.name, this.albumDate});
}

class  PhotoAlbumWithPhotos{
  final int albumID;
  final String albumName;
  final String albumThumbnail;
  List<Photo> photos = [];

  PhotoAlbumWithPhotos({this.albumID, this.albumName,this.albumThumbnail, this.photos});
 }


 class Photo{
  final int photoID;
  final String photoURL;

  Photo(this.photoID, this.photoURL);

 }
