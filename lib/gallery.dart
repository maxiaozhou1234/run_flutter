import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  return ImageContainer(
                    file: files[i],
                  );
//                    Container(
//                    child: Image.file(files[i]),
//                  );
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

//图片双击缩放
class ImageContainer extends StatefulWidget {
  final File file;

  ImageContainer({this.file});

  @override
  State<StatefulWidget> createState() {
    return _ImageContainerState();
  }
}

class _ImageContainerState extends State<ImageContainer> {
  double _scale = 1.0;
  bool _flag = true;

  bool _init = false;

  Widget _loadImage() {
    final Completer completer = Completer();
    var size = window.physicalSize;
    print('screen w = ${size.width},h = ${size.height}');
    final ImageStream imageStream =
        FileImage(widget.file).resolve(createLocalImageConfiguration(context));

    ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo image, bool synchronousCall) {
      var w = image.image.width;
      var h = image.image.height;

      var sw = w / size.width;
      var sh = h / size.height;
      print('picture (w = $w,h = $h),scale = $sw ,$sh');
      _scale = (sw > sh ? sw : sh) * 2;
      print("scale = $_scale");
      completer.complete();
      imageStream.removeListener(listener);
    }, onError: (dynamic exception, StackTrace stackTrace) {
      print(exception.toString());
      completer.complete();
      imageStream.removeListener(listener);
    });

    imageStream.addListener(listener);

    return FutureBuilder(
      future: completer.future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        _init = true;
        return GestureDetector(
            onDoubleTap: () {
              print("onDouble tap");
              setState(() {
                _scale = _flag ? _scale / 2.0 : _scale * 2.0;
                _flag = !_flag;
                print("onDouble: update $_scale , flag = $_flag");
              });
            },
            child: Image.file(
              widget.file,
              fit: BoxFit.none,
              scale: _scale,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _init
        ? GestureDetector(
            onDoubleTap: () {
              print("onDouble tap");
              setState(() {
                _scale = _flag ? _scale / 2.0 : _scale * 2.0;
                _flag = !_flag;
                print("onDouble: update $_scale , flag = $_flag");
              });
            },
            child: Image.file(
              widget.file,
              fit: BoxFit.none,
              scale: _scale,
            ))
        : _loadImage();
  }
}
