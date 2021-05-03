import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project_writer_v04/landing_page.dart';
import 'package:project_writer_v04/theme/new_light_theme.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white));
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(MyApp());
}

Future<void> configureAmplify() async {
  AmplifyDataStore dataStorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
  AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
  AmplifyAnalyticsPinpoint analyticsPinpoint = AmplifyAnalyticsPinpoint();
  Amplify.addPlugins([authPlugin, dataStorePlugin, analyticsPinpoint]);

  if (!Amplify.isConfigured) {
    try {
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print(e);
      print("Tried to reconfigure Amplify");
    }
  }
}

// 1
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project Writer v04',
        theme: NewLightThemeData.data,
        home: LandingPage(),
      ),
    );
  }
}
