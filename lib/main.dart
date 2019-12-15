import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/HomeScreen.dart';
import 'package:wallpaper_app/screens/widget/BottomNavBarProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
