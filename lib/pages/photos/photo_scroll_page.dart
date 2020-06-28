import 'package:ankev928/models/photo_album.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoScrollPage extends StatefulWidget {
  final List<Photo> _photos;

 final int _currentPhoto;
  PhotoScrollPage(this._photos, this._currentPhoto):  _pageController = PageController(initialPage: _currentPhoto);

  final PageController _pageController;

  _PhotoScrollPage createState() => _PhotoScrollPage(this._photos, this._currentPhoto);
}

class _PhotoScrollPage  extends State<PhotoScrollPage>{
   List<Photo> _photos;

   int _currentIndex;

   _PhotoScrollPage(this._photos, this._currentIndex);
   void initState(){
     super.initState();
     _photos = widget._photos;
     _currentIndex = widget._currentPhoto;
   }

   void onPageChanged(int index){
     setState(() {
       _currentIndex = index;
     });
   }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        itemCount: _photos.length,
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(_photos[index].photoURL),
            initialScale: PhotoViewComputedScale.contained,
          );
        },
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes,
            ),
          ),
        ),
      //  backgroundDecoration: backgroundDecoration,
        pageController: widget._pageController,
      onPageChanged: onPageChanged,
      ),
    );
  }
}
