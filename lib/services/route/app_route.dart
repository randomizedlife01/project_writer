import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/landing_page.dart';
import 'package:project_writer_v04/pages/auth_pages/login_page.dart';
import 'package:project_writer_v04/pages/auth_pages/signup_page.dart';
import 'package:project_writer_v04/pages/auth_pages/verification_page.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_cubit.dart';
import 'package:project_writer_v04/pages/document/intro_page/intro_page.dart';
import 'package:project_writer_v04/pages/auth_pages/bloc/auth_bloc.dart';

class AppRouter {
  final _authService = AuthService();
  final _freeWriteCubit = FreeWriteCubit();

  Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => LandingPage(),
        );
        break;
      case '/login_page':
        return MaterialPageRoute(
            builder: (_) => LoginPage(
                  shouldShowSignUp: _authService.showSignUp,
                  didProvideCredentials: _authService.loginWithCredentials,
                ));
        break;
      case '/signup_page':
        return MaterialPageRoute(
            builder: (_) => SignUpPage(
                  shouldShowLogin: _authService.showLogin,
                  didProvideCredentials: _authService.signUpWithCredentials,
                ));
        break;
      case '/verify_page':
        return MaterialPageRoute(
            builder: (_) => VerificationPage(
                  didProvideVerificationCode: _authService.verifyCode,
                ));
        break;
      case '/intro_page':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _freeWriteCubit,
            child: IntroPage(
              shouldLogOut: _authService.logOut,
            ),
          ),
        );
        break;
      default:
        return null;
        break;
    }
  }

  void dispose() {
    _freeWriteCubit.close();
  }
}
