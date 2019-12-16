import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Common/Common.dart';
import 'package:wallpaper_app/HomeScreen.dart';
import 'package:wallpaper_app/screens/widget/BottomNavBarProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static var platform = MethodChannel(Common.CHANNEL);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
      providers: [
        ChangeNotifierProvider(
          builder: (_) => BottomNavBarProvider(),
        ),
      ],
    );
  }
}
