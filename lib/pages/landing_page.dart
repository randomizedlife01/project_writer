import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/auth_pages/login_page.dart';
import 'package:project_writer_v04/pages/auth_pages/signup_page.dart';
import 'package:project_writer_v04/pages/auth_pages/verification_page.dart';
import 'package:project_writer_v04/pages/document/intro_page/intro_page.dart';
import 'package:project_writer_v04/services/auth/auth_bloc.dart';

class LandingPage extends StatelessWidget {
  final AuthService authService;

  const LandingPage({Key key, this.authService}) : super(key: key);
  // final _authService = AuthService();
  // final _amplify = Amplify;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
        stream: authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(
                      child: LoginPage(
                    shouldShowSignUp: authService.showSignUp,
                    didProvideCredentials: authService.loginWithCredentials,
                  )),
                if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(
                      child: SignUpPage(
                    shouldShowLogin: authService.showLogin,
                    didProvideCredentials: authService.signUpWithCredentials,
                  )),
                if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(child: VerificationPage(didProvideVerificationCode: authService.verifyCode)),
                if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                  MaterialPage(
                    child: IntroPage(
                      shouldLogOut: authService.logOut,
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
