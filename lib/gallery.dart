import 'dart:io';

import 'package:flutter/material.dart';

//import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

//相册
class Gallery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GalleryState();
  }
}

class _GalleryState extends State<Gallery> {
  final List<File> files = <File>[];

  void _openCamera() async {
//    Fluttertoast.showToast(msg: 'open album', gravity: ToastGravity.BOTTOM);
    print('openCamera');
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    print('setState');
    if (image != null) {
      setState(() {
        files.add(image);
      });
    }
    print('end');
  }

  void _openAlbum() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null && !files.contains(image)) {
      setState(() {
        files.add(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: _openCamera,
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: _openAlbum,
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: files.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          crossAxisCount: 4,
        ),
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Container(
                    child: Image.file(files[i]),
                  );
                }));
              },
              child: Image.file(
                files[i],
                fit: BoxFit.cover,
              ));
        },
      ),
    );
  }
}
