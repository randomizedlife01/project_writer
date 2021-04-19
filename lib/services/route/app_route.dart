import 'package:flutter/material.dart';
import 'package:project_writer_v04/landing_page.dart';
import 'package:project_writer_v04/pages/auth_pages/login_page.dart';
import 'package:project_writer_v04/pages/auth_pages/signup_page.dart';
import 'package:project_writer_v04/pages/auth_pages/verification_page.dart';
import 'package:project_writer_v04/pages/document/character_page/character_page.dart';
import 'package:project_writer_v04/pages/document/character_page/character_write_page.dart';
import 'package:project_writer_v04/pages/document/free_write_page/free_write_page.dart';
import 'package:project_writer_v04/pages/document/intro_page/component/intro_parts.dart';
import 'package:project_writer_v04/pages/document/intro_page/intro_page.dart';
import 'package:project_writer_v04/services/controller/auth_bloc.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/my_life_page.dart';
import 'package:project_writer_v04/pages/document/story_page/story_page.dart';

class AppRouter {
  final _authService = AuthService();

  Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LandingPage());
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
          builder: (_) => IntroPage(
            shouldLogOut: _authService.logOut,
          ),
        );
        break;
      case '/story_page':
        final ScreenArguments args = routeSettings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => StoryPage(documentId: args.documentId, documentName: args.docName),
        );
        break;
      case '/my_life_page':
        return MaterialPageRoute(builder: (_) => MyLifePage());
        break;
      case '/free_write_page':
        return MaterialPageRoute(
          builder: (_) => FreeWritePage(
            appBarTitle: '자유롭게 쓰기',
          ),
        );
        break;
      case '/character_page':
        return MaterialPageRoute(builder: (_) => CharactersPage());
        break;
      case '/character_write_page':
        return MaterialPageRoute(builder: (_) => CharacterWritePage());
        break;
      default:
        return null;
        break;
    }
  }
}
