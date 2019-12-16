import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:photos_saver/photos_saver.dart';
import 'package:wallpaper_app/main.dart';

class ItemPhotoScreen extends StatefulWidget {
  String img;
  ItemPhotoScreen({this.img, Key key}) : super(key: key);

  @override
  _ItemPhotoScreenState createState() => _ItemPhotoScreenState();
}

class _ItemPhotoScreenState extends State<ItemPhotoScreen> {
  //Save
  Uint8List _imageData;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Share
  Future<void> _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load(widget.img);
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadImage();
  }
  //Save
  Future<void> loadImage() async {
    var imageData = await rootBundle.load(widget.img).then((byteData) {
      return byteData.buffer.asUint8List();
    });
    if (!mounted) return;
    setState(() {
      _imageData = imageData;
    });
  }

  //Set wallpaper
  _setwallpaper(String path) {
    MyApp.platform.invokeMethod("setwallpaper", {"path": path}).then((value) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("OK"),
      ));
    }).catchError((onError) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.img),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String filePath =
                            await PhotosSaver.saveFile(fileData: _imageData);
                        // _scaffoldKey.currentState.showSnackBar(SnackBar(
                        //     duration: Duration(seconds: 5),
                        //     content: Text("Created image file at $filePath")));

                        print(filePath);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          "assets/icons/download.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        String filePath =
                            await PhotosSaver.saveFile(fileData: _imageData);
                        // _scaffoldKey.currentState.showSnackBar(SnackBar(
                        //     duration: Duration(seconds: 5),
                        //     content: Text("Created image file at $filePath")));
                        _setwallpaper(filePath);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          "assets/icons/wallpaper.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _shareImage();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          "assets/icons/share.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
