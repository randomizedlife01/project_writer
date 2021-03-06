import 'package:flutter/material.dart';
import 'package:project_writer_v04/landing_page.dart';
import 'package:project_writer_v04/models/CharacterData.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/auth_pages/login_page.dart';
import 'package:project_writer_v04/pages/auth_pages/signup_page.dart';
import 'package:project_writer_v04/pages/auth_pages/verification_page.dart';
import 'package:project_writer_v04/pages/document/character_page/character_page.dart';
import 'package:project_writer_v04/pages/document/character_page/character_write_page.dart';
import 'package:project_writer_v04/pages/document/free_write_page/free_write_page.dart';
import 'package:project_writer_v04/pages/document/import_page/import_page.dart';
import 'package:project_writer_v04/pages/document/intro_page/intro_page.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/my_life_write_page.dart';
import 'package:project_writer_v04/pages/document/story_page/story_detail_page.dart';
import 'package:project_writer_v04/pages/instruction_page/instruction_page.dart';
import 'package:project_writer_v04/services/controller/auth_bloc.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/my_life_page.dart';
import 'package:project_writer_v04/pages/document/story_page/story_page.dart';

class ScreenArguments {
  final String documentId;
  final String docName;

  ScreenArguments(this.documentId, this.docName);
}

class CharacterArgument {
  final CharacterData characterData;

  CharacterArgument(this.characterData);
}

class MyLifeStoryArgument {
  final MyLifeStory myLifeStory;

  MyLifeStoryArgument(this.myLifeStory);
}

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
            appBarTitle: '???????????? ??????',
          ),
        );
        break;
      case '/character_page':
        return MaterialPageRoute(builder: (_) => CharactersPage());
        break;
      case '/character_write_page':
        final CharacterData args = routeSettings.arguments as CharacterData;
        return MaterialPageRoute(builder: (_) => CharacterWritePage(characterData: args));
        break;
      case '/import_page':
        return MaterialPageRoute(builder: (_) => ImportPage());
        break;
      case '/story_detail_page':
        return MaterialPageRoute(builder: (_) => StoryDetailPage());
        break;
      case '/my_life_detail_page':
        final MyLifeStory args = routeSettings.arguments as MyLifeStory;
        return MaterialPageRoute(builder: (_) => MyLifeDetailPage(myLifeStory: args));
        break;
      case '/instruction_page':
        return MaterialPageRoute(builder: (_) => InstructionPage());
        break;
      default:
        return null;
        break;
    }
  }
}
