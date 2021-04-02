import 'package:flutter/material.dart';

class StoryThemeData {
  static ThemeData data = ThemeData(
    iconTheme: IconThemeData(
      color: Color(0xFFc4d6cb),
    ),
    accentIconTheme: IconThemeData(
      color: Color(0xFFe23e57),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFffe2e2),
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFf6f6f6),
        ),
      ),
      hintStyle: TextStyle(
        fontSize: 12.0,
        color: Color(0xFFBF6C84),
      ),
      labelStyle: TextStyle(
        fontSize: 14.0,
        color: Color(0xFFBF6C84),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFe23e57),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        textStyle: TextStyle(
          fontSize: 14.0,
          color: Color(0xFFf6f6f6),
          fontFamily: 'GothicA1',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Color(0xFFf6f6f6),
        side: BorderSide(
          color: Color(0xFFe23e57),
        ),
        primary: Color(0xFFe23e57),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        textStyle: TextStyle(
          fontSize: 14.0,
          color: Color(0xFFe23e57),
          fontFamily: 'GothicA1',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    scaffoldBackgroundColor: Color(0xFF3b4445),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      overline: TextStyle(
        fontSize: 15.0,
        color: Color(0xFFf9ed69),
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w300,
      ),
      headline1: TextStyle(
        fontSize: 30.0,
        fontFamily: 'GothicA1',
        color: Color(0xFFF8FEE9),
        fontWeight: FontWeight.w700,
      ),
      headline2: TextStyle(
        fontSize: 20.0,
        fontFamily: 'GothicA1',
        color: Color(0xFFF8FEE9),
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        fontSize: 17.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w700,
        color: Color(0xFFc4d6cb),
        height: 1.5,
      ),
      bodyText2: TextStyle(
        fontSize: 13.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w500,
        color: Color(0xFF8785a2),
      ),
      caption: TextStyle(
        fontSize: 12.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w500,
        color: Color(0xFF8785a2),
      ),
      button: TextStyle(
        fontSize: 13.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w600,
        color: Color(0xFF8785a2),
      ),
      subtitle1: TextStyle(
        fontSize: 20.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w200,
        color: Color(0xFF8785a2),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFe23e57),
      foregroundColor: Color(0xFFF8FEE9),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(
        fontSize: 12.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w600,
        color: Color(0xFFffe2e2),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w600,
        color: Color(0xFF8785a2),
      ),
      selectedIconTheme: IconThemeData(
        size: 17.0,
        color: Color(0xFFffe2e2),
      ),
      unselectedIconTheme: IconThemeData(
        size: 17.0,
        color: Color(0xFF8785a2),
      ),
    ),
  );
}
