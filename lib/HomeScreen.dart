import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/screens/listscreen/BoyScreen.dart';
import 'package:wallpaper_app/screens/listscreen/GirlScreen.dart';
import 'package:wallpaper_app/screens/listscreen/LoverScreen.dart';
import 'package:wallpaper_app/screens/listscreen/OtherScreen.dart';
import 'package:wallpaper_app/screens/listscreen/WallpaperScreen.dart';
import 'package:wallpaper_app/screens/widget/BottomNavBarProvider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _layoutPage = [
    WallpaperScreen(),
    AnimeBoysScreen(),
    GirlsScreen(),
    LoverScreen(),
    OtherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavBarProvider bottomNavBarProvider =
        Provider.of<BottomNavBarProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              //child: _layoutPage.elementAt(bottomNavBarProvider.page),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.92,
                child: _layoutPage.elementAt(bottomNavBarProvider.page),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavyBarPage(),
      ),
    );
  }
}

class BottomNavyBarPage extends StatefulWidget {
  @override
  _BottomNavyBarState createState() => _BottomNavyBarState();
}

class _BottomNavyBarState extends State<BottomNavyBarPage> {
  int selectedIndex = 0;

  List<NavigationItem> items = [
    NavigationItem(
      Text(
        'Wallpapers',
        style: TextStyle(color: Colors.white, fontSize: 12.0),
      ),
      WallpaperScreen(),
    ),
    NavigationItem(
      Text(
        'Boys',
        style: TextStyle(color: Colors.white, fontSize: 12.0),
      ),
      AnimeBoysScreen(),
    ),
    NavigationItem(
      Text(
        'Girls',
        style: TextStyle(color: Colors.white, fontSize: 12.0),
      ),
     GirlsScreen(),
    ),
    NavigationItem(
      Text(
        'Lovers',
        style: TextStyle(color: Colors.white, fontSize: 12.0),
      ),
      LoverScreen(),
    ),
    NavigationItem(
      Text(
        'Other',
        style: TextStyle(color: Colors.white, fontSize: 12.0),
      ),
      OtherScreen(),
    )
  ];
  Widget _buildItem(NavigationItem item, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white),
      ),
      width: MediaQuery.of(context).size.width * 0.18,
      child: Center(
        child: item.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavBarProvider bottomNavBarProvider =
        Provider.of<BottomNavBarProvider>(context);
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.02,
        right: MediaQuery.of(context).size.width * 0.02,
        top: MediaQuery.of(context).size.width * 0.02,
        bottom: MediaQuery.of(context).size.width * 0.02,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg3.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                bottomNavBarProvider.page = itemIndex;
              });
            },
            child: _buildItem(item, bottomNavBarProvider.page == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Text title;
  final Widget layout;
  NavigationItem(this.title, this.layout);
}
