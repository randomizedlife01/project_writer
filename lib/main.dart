import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:project_writer_v04/landing_page.dart';
import 'theme/theme_data.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white));
  //Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

// 1
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project Writer v04',
        theme: StoryThemeData.data,
        home: LandingPage(),
      ),
    );
  }
}
