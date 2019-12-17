import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/widget/CustomDialog.dart';
import 'package:wallpaper_app/screens/widget/ItemPhoto.dart';

const String testDevice = 'MobileId';

class GirlsScreen extends StatefulWidget {
  GirlsScreen({Key key}) : super(key: key);

  @override
  _GirlsScreenState createState() => _GirlsScreenState();
}

class _GirlsScreenState extends State<GirlsScreen> {
  List<String> items = [
    "assets/girls/girl1.jpg",
    "assets/girls/girl2.jpg",
    "assets/girls/girl3.jpg",
    "assets/girls/girl4.jpg",
    "assets/girls/girl5.jpg",
    "assets/girls/girl6.png",
    "assets/girls/girl7.jpg",
    "assets/girls/girl8.png",
    "assets/girls/girl9.jpg",
    "assets/girls/girl10.jpg",
    "assets/girls/girl11.png",
    "assets/girls/girl12.jpg",
    "assets/girls/girl13.jpg",
    "assets/girls/girl14.jpg",
    "assets/girls/girl15.jpg",
    "assets/girls/girl16.jpg",
    "assets/girls/girl17.jpg",
    "assets/girls/girl18.jpg",
    "assets/girls/girl19.jpg",
    "assets/girls/girl20.jpg",
    "assets/girls/girl21.jpg",
    "assets/girls/girl22.jpg",
    "assets/girls/girl23.jpg",
    "assets/girls/girl24.jpg",
    "assets/girls/girl25.jpg",
    "assets/girls/girl26.jpg",
    "assets/girls/girl27.jpg",
    "assets/girls/girl28.jpg",
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
        adUnitId: BannerAd.testAdUnitId,
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
      adUnitId: InterstitialAd.testAdUnitId,
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
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
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
    final double itemHeight = size.height / 1.3;
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
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03),
                      child: Text('Anime Girls Online',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Share.text(
                                'my text title',
                                'This is my text to share with other applications.',
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
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomDialog());
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
                        height: MediaQuery.of(context).size.height * 0.3,
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
