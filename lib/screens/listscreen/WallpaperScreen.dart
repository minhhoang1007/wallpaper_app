import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants/ApiConstants.dart';
import 'package:wallpaper_app/screens/widget/CustomDialog.dart';
import 'package:wallpaper_app/screens/widget/ItemPhoto.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'MobileId';

class WallpaperScreen extends StatefulWidget {
  WallpaperScreen({Key key}) : super(key: key);

  @override
  _WallpaperScreenState createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  List<String> items = [
    "assets/wallpapers/anime_wallpaper_01.jpg",
    "assets/wallpapers/anime_wallpaper_02.jpg",
    "assets/wallpapers/anime_wallpaper_03.jpg",
    "assets/wallpapers/anime_wallpaper_04.jpg",
    "assets/wallpapers/anime_wallpaper_05.jpg",
    "assets/wallpapers/anime_wallpaper_06.jpg",
    "assets/wallpapers/anime_wallpaper_07.jpg",
    "assets/wallpapers/anime_wallpaper_08.png",
    "assets/wallpapers/anime_wallpaper_09.jpg",
    "assets/wallpapers/anime_wallpaper_10.jpg",
    "assets/wallpapers/anime_wallpaper_11.jpg",
    "assets/wallpapers/anime_wallpaper_12.jpg",
    "assets/wallpapers/anime_wallpaper_13.jpg",
    "assets/wallpapers/anime_wallpaper_14.jpg",
    "assets/wallpapers/anime_wallpaper_15.jpg",
    "assets/wallpapers/anime_wallpaper_16.jpg",
    "assets/wallpapers/anime_wallpaper_17.jpg",
    "assets/wallpapers/anime_wallpaper_18.jpg",
    "assets/wallpapers/anime_wallpaper_19.jpg",
    "assets/wallpapers/anime_wallpaper_20.jpg",
    "assets/wallpapers/anime_wallpaper_21.jpg",
    "assets/wallpapers/anime_wallpaper_22.jpg",
    "assets/wallpapers/anime_wallpaper_23.jpg",
    "assets/wallpapers/anime_wallpaper_24.jpg",
    "assets/wallpapers/anime_wallpaper_25.jpg",
    "assets/wallpapers/anime_wallpaper_26.jpg",
    "assets/wallpapers/anime_wallpaper_27.jpg",
    "assets/wallpapers/anime_wallpaper_28.jpg",
    "assets/wallpapers/anime_wallpaper_29.jpg",
    "assets/wallpapers/anime_wallpaper_30.jpg",
    "assets/wallpapers/anime_wallpaper_31.png",
    "assets/wallpapers/anime_wallpaper_32.jpg",
    "assets/wallpapers/anime_wallpaper_33.jpg",
    "assets/wallpapers/anime_wallpaper_34.jpg",
    "assets/wallpapers/anime_wallpaper_35.jpg",
    "assets/wallpapers/anime_wallpaper_36.jpg",
    "assets/wallpapers/anime_wallpaper_37.jpg",
    "assets/wallpapers/anime_wallpaper_38.jpg",
    "assets/wallpapers/anime_wallpaper_39.jpg",
    "assets/wallpapers/anime_wallpaper_40.jpg",
    "assets/wallpapers/anime_wallpaper_41.jpg",
    "assets/wallpapers/anime_wallpaper_42.jpeg",
    "assets/wallpapers/anime_wallpaper_43.jpg",
    "assets/wallpapers/anime_wallpaper_44.jpg",
    "assets/wallpapers/anime_wallpaper_45.png",
    "assets/wallpapers/anime_wallpaper_46.jpg",
    "assets/wallpapers/anime_wallpaper_47.jpg",
    "assets/wallpapers/anime_wallpaper_48.jpg",
    "assets/wallpapers/anime_wallpaper_49.jpg",
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
  void initState() {
    FirebaseAdMob.instance.initialize(appId: ADMOB_APP_ID);
    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 1.2;
    final double itemWidth = size.width;
    return Scaffold(
      body: Stack(
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
                      child: Text('Wallpaper Offline', style: TextStyle(color: Colors.white, fontSize: 20)),
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
    );
  }
}
