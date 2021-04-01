import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/services/auth/auth_credentials.dart';

enum AuthFlowStatus { login, signUp, verification, session }

enum AuthCheckStatus { success, notConfirm, error }

class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({this.authFlowStatus});
}

class AuthService {
  final authStateController = StreamController<AuthState>();
  AuthCredentials _credentials;

  static AuthCheckStatus check;

  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }

  // 1
  void loginWithCredentials(AuthCredentials credentials) async {
    try {
      final result = await Amplify.Auth.signIn(username: credentials.emailName, password: credentials.password);

      if (result.isSignedIn) {
        final state = AuthState(authFlowStatus: AuthFlowStatus.session);
        authStateController.add(state);
        check = AuthCheckStatus.success;
      } else {
        check = AuthCheckStatus.notConfirm;
        print('User could not be signed in');
      }
    } on AuthException catch (authError) {
      check = AuthCheckStatus.error;
      print('Could not login - ${authError.message}');
    }
  }

  void signUpWithCredentials(SignUpCredentials credentials) async {
    try {
      final userAttributes = {'email': credentials.email};

      final result = await Amplify.Auth.signUp(
        username: credentials.emailName,
        password: credentials.password,
        options: CognitoSignUpOptions(
          userAttributes: userAttributes,
        ),
      );

      if (result.isSignUpComplete) {
        loginWithCredentials(credentials);
      } else {
        this._credentials = credentials;
        final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
        authStateController.add(state);
      }
    } on AuthException catch (authError) {
      print('Failed to sign up - ${authError.message}');
    }
  }

  // 1
  void verifyCode(String verificationCode) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(username: _credentials.emailName, confirmationCode: verificationCode);

      if (result.isSignUpComplete) {
        loginWithCredentials(_credentials);
      } else {}
    } catch (authError) {
      print('Could not verify code - ${authError.cause}');
    }
  }

  void logOut() async {
    try {
      await Amplify.Auth.signOut();
      showLogin();
    } catch (authError) {
      print('Could not log out - ${authError.cause}');
    }
  }

  void checkAuthStatus() async {
    try {
      await Amplify.Auth.fetchAuthSession();

      final state = AuthState(authFlowStatus: AuthFlowStatus.session);
      authStateController.add(state);
    } catch (_) {
      final state = AuthState(authFlowStatus: AuthFlowStatus.login);
      authStateController.add(state);
    }
  }
}
