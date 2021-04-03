import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  final _authService = AuthService();
  final _amplify = Amplify;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _authService.checkAuthStatus();
  }

  void _configureAmplify() async {
    final provider = ModelProvider();
    final datastorePlugin = AmplifyDataStore(modelProvider: provider);

    _amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAnalyticsPinpoint(),
      datastorePlugin,
    ]);
    try {
      await _amplify.configure(amplifyconfig);
      print('Successfully configured Amplify 🎉');
    } catch (e) {
      print('Could not configure Amplify ☠️');
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project Writer v04',
        theme: StoryThemeData.data,
        onGenerateRoute: _appRouter.onGeneratorRoute,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
