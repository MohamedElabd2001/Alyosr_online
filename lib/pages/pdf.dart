import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyImageList(),
    );
  }
}

class MyImageList extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/EG-Bay Payment Method Page 01 Yosr.jpg',
    'assets/images/EG-Bay Payment Method Page 02 Yosr.jpg',
    'assets/images/EG-Bay Payment Method Page 03 Yosr.jpg',
    'assets/images/EG-Bay Payment Method Page 04 Yosr.jpg',
    'assets/images/EG-Bay Payment Method Page 05 Yosr.jpg',
    'assets/images/EG-Bay Payment Method Page 06 Yosr.jpg',
    // Add all your image asset paths here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قسط معانا'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Container(
            height: 300, // Adjust the height as needed
            child: PhotoViewGallery.builder(
              itemCount: 1,
              builder: (context, _) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(imagePaths[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(
                color: Colors.white24,
              ),
              pageController: PageController(),
              onPageChanged: (index) {
                // Do something when the page changes
              },
            ),
          );
        },
      ),
    );
  }
}