import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants/ApiConstants.dart';
import 'package:wallpaper_app/screens/widget/CustomDialog.dart';
import 'package:wallpaper_app/screens/widget/ItemPhoto.dart';

const String testDevice = 'MobileId';

class OtherScreen extends StatefulWidget {
  OtherScreen({Key key}) : super(key: key);

  @override
  _OtherScreenState createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  List<String> items = [
    "assets/other/other1.jpg",
    "assets/other/other2.jpg",
    "assets/other/other3.jpg",
    "assets/other/other4.jpg",
    "assets/other/other5.jpg",
    "assets/other/other6.jpg",
    "assets/other/other7.jpg",
    "assets/other/other8.jpg",
    "assets/other/other9.jpg",
    "assets/other/other10.jpg",
    "assets/other/other11.jpg",
    "assets/other/other12.jpg",
  ];
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  bool abc = false;
  bool isLoad = false;
  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: ADMOB_BANNER_ID,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  void getAd(item) async {
    setState(() {
      isLoad = true;
    });
    _interstitialAd = InterstitialAd(
      adUnitId: ADMOB_INTERSTITIAL_ID,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.closed) {
          _interstitialAd.load();
        }
        handEvent(event, item);
      },
    );
    _interstitialAd.load();
  }

  void handEvent(MobileAdEvent event, item) {
    switch (event) {
      case MobileAdEvent.loaded:
        //if (!c) {
        _interstitialAd.show();
        //c = true;
        //}
        break;
      case MobileAdEvent.opened:
        break;
      case MobileAdEvent.closed:
        isLoad = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemPhotoScreen(
              img: item,
            ),
          ),
        );
        break;
      case MobileAdEvent.failedToLoad:
        isLoad = false;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemPhotoScreen(
              img: item,
            ),
          ),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 1.2;
    final double itemWidth = size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg3.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                          child: Text('Other Online', style: TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Share.text(
                                    'Anime Wallpaper - Wallpaper Master',
                                    'https://play.google.com/store/apps/details?id=com.anime.master.wallpapers',
                                    'text/plain');
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  "assets/icons/share.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(context: context, builder: (BuildContext context) => CustomDialog());
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  "assets/icons/love.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: (itemWidth / itemHeight),
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            getAd(items[index]);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ItemPhotoScreen(
                            //       img: items[index],
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(8.0),
                              child: Image.asset(
                                items[index],
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              isLoad
                  ? Positioned(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    )
            ],
          ),
        ],
      ),
    );
  }
}
