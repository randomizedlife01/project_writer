import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:project_writer_v04/landing_page.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/auth_pages/bloc/auth_bloc.dart';
import 'package:project_writer_v04/services/route/app_route.dart';
import 'amplifyconfiguration.dart';
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
