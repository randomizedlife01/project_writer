import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/document/intro_page/intro_page.dart';
import 'package:project_writer_v04/services/auth/auth_bloc.dart';
import 'package:project_writer_v04/services/logic/free_write_bloc.dart';
import 'amplifyconfiguration.dart';
import 'pages/auth_pages/login_page.dart';
import 'pages/auth_pages/signup_page.dart';
import 'pages/auth_pages/verification_page.dart';
import 'theme/theme_data.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white));
  //Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

// 1
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        home: StreamBuilder<AuthState>(
            stream: _authService.authStateController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Navigator(
                  pages: [
                    if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                      MaterialPage(
                          child: LoginPage(
                        shouldShowSignUp: _authService.showSignUp,
                        didProvideCredentials: _authService.loginWithCredentials,
                      )),
                    if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                      MaterialPage(
                          child: SignUpPage(
                        shouldShowLogin: _authService.showLogin,
                        didProvideCredentials: _authService.signUpWithCredentials,
                      )),
                    if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                      MaterialPage(child: VerificationPage(didProvideVerificationCode: _authService.verifyCode)),
                    if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                      MaterialPage(
                        child: IntroPage(
                          shouldLogOut: _authService.logOut,
                        ),
                      ),
                  ],
                  onPopPage: (route, result) => route.didPop(result),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
