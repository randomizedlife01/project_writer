import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:project_writer_v04/pages/auth_pages/login_page.dart';
import 'package:project_writer_v04/pages/auth_pages/signup_page.dart';
import 'package:project_writer_v04/pages/auth_pages/verification_page.dart';
import 'package:project_writer_v04/services/controller/my_life_controller.dart';
import 'package:project_writer_v04/services/controller/character_controller.dart';
import 'package:project_writer_v04/services/controller/free_write_controller.dart';
import 'package:project_writer_v04/pages/document/intro_page/intro_page.dart';
import 'package:project_writer_v04/services/controller/auth_bloc.dart';
import 'package:project_writer_v04/services/controller/intro_page_controller.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';
import 'package:project_writer_v04/services/route/app_route.dart';
import 'package:project_writer_v04/amplifyconfiguration.dart';

import 'models/ModelProvider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _appRouter = AppRouter();

  final _authService = AuthService();
  final _amplify = Amplify;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _authService.checkAuthStatus();

    Get.put(FreeWriteController());
    Get.put(CharactersController());
    Get.put(IntroDocumentController());
    Get.put(MyLifeStoryController());
    Get.put(StorySummaryController());
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
    _authService.checkAuthStatus();
    return StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              onGenerateRoute: _appRouter.onGeneratorRoute,
              pages: [
                if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(
                      name: '/login_page',
                      child: LoginPage(
                        shouldShowSignUp: _authService.showSignUp,
                        didProvideCredentials: _authService.loginWithCredentials,
                      )),
                if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(
                      name: '/signup_page',
                      child: SignUpPage(
                        shouldShowLogin: _authService.showLogin,
                        didProvideCredentials: _authService.signUpWithCredentials,
                      )),
                if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(
                    name: '/verify_page',
                    child: VerificationPage(didProvideVerificationCode: _authService.verifyCode),
                  ),
                if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                  MaterialPage(
                    name: '/intro_page',
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
        });
  }
}
