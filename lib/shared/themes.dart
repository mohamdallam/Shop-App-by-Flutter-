import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: HexColor('333739'),
  // ################# FloatingActionButtonTheme
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.red),
  // ################# AppBarTheme
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backgroundColor: HexColor('333739'),
    elevation: 0,
    //Text Style
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),

    //Status Bar Colors
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
      //End Status Bar
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  // ################# BottomNavigationBar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  // ################# Text Theme
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.white,
  //  ############## FloatingActionButtonTheme
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.red),
  //  ############## bottomNavigationBar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 0.0,
    backgroundColor: Colors.white,
  ),
  //  ############## AppBar
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backgroundColor: Colors.white,
    elevation: 0,
    //Text Style
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    //End Text Style
    //Status Bar Colors
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      //End Status Bar
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  //  ############## Text Theme
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);
