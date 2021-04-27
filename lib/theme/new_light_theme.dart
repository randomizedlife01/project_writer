import 'package:flutter/material.dart';

class NewLightThemeData {
  static ThemeData data = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Color(0xFF111f4d),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontFamily: 'GothicA1',
        color: Color(0xFF020205),
        fontWeight: FontWeight.w300,
      ),
    ),
    //아이콘 색깔
    iconTheme: IconThemeData(
      color: Color(0xFF111f4d),
    ),
    //강조 아이콘 색깔
    accentIconTheme: IconThemeData(
      color: Color(0xFFe43a19),
    ),
    //아웃라인 버튼 설정
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: Color(0xFF020205),
        ),
        primary: Color(0xFF020205),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        textStyle: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF020205),
          fontFamily: 'GothicA1',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    //속이 꽉찬 버튼 설정
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF020205),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        textStyle: TextStyle(
          fontSize: 14.0,
          color: Color(0xFFf2f4f7),
          fontFamily: 'GothicA1',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    //인풋 폼 설정
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF5da0a2),
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF34495e),
        ),
      ),
      hintStyle: TextStyle(
        fontSize: 12.0,
        color: Color(0xFF5da0a2),
      ),
      labelStyle: TextStyle(
        fontSize: 14.0,
        color: Color(0xFF34495e),
      ),
    ),
    //배경색
    scaffoldBackgroundColor: Color(0xFFebe4db),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    //텍스트 테마 - 기본 사이즈 13.
    textTheme: TextTheme(
      overline: TextStyle(
        fontSize: 15.0,
        color: Color(0xFF111f4d),
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w500,
      ),
      headline1: TextStyle(
        fontSize: 30.0,
        fontFamily: 'GothicA1',
        color: Color(0xFF020205),
        fontWeight: FontWeight.w300,
      ),
      headline2: TextStyle(
        fontSize: 26.0,
        fontFamily: 'GothicA1',
        color: Color(0xFF111f4d),
        fontWeight: FontWeight.w200,
      ),
      headline3: TextStyle(
        fontSize: 22.0,
        fontFamily: 'GothicA1',
        color: Color(0xFF111f4d),
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        fontSize: 18.0,
        fontFamily: 'GothicA1',
        color: Color(0xFF111f4d),
        fontWeight: FontWeight.w400,
      ),
      //기본 텍스트
      bodyText1: TextStyle(
        fontSize: 15.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w500,
        color: Color(0xFF111f4d),
        height: 1.5,
      ),
      //본문 텍스트 - 최소
      bodyText2: TextStyle(
        fontSize: 13.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w300,
        color: Color(0xFF020205),
      ),
      caption: TextStyle(
        fontSize: 13.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w200,
        color: Color(0xFF020205),
      ),
      button: TextStyle(
        fontSize: 14.0,
        color: Color(0xFFf2f4f7),
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w500,
      ),
      subtitle1: TextStyle(
        fontSize: 15.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w200,
        color: Color(0xFF111f4d),
      ),
      subtitle2: TextStyle(
        fontSize: 12.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w200,
        color: Color(0xFF111f4d),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.transparent,
      foregroundColor: Color(0xFFe43a19),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(
        fontSize: 12.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w600,
        color: Color(0xFFe43a19),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.0,
        fontFamily: 'GothicA1',
        fontWeight: FontWeight.w600,
        color: Color(0xFF020205),
      ),
      selectedIconTheme: IconThemeData(
        size: 17.0,
        color: Color(0xFFe43a19),
      ),
      unselectedIconTheme: IconThemeData(
        size: 17.0,
        color: Color(0xFF020205),
      ),
    ),
  );
}
