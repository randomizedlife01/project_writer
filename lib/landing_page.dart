import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/auth_pages/login_page.dart';
import 'package:project_writer_v04/pages/auth_pages/signup_page.dart';
import 'package:project_writer_v04/pages/auth_pages/verification_page.dart';
import 'package:project_writer_v04/pages/document/intro_page/intro_page.dart';
import 'package:project_writer_v04/pages/auth_pages/bloc/auth_bloc.dart';

// 1
class LandingPage extends StatelessWidget {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    _authService.checkAuthStatus();
    return StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
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
        });
  }
}
