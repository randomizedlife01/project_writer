import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/landing_page.dart';
import 'package:project_writer_v04/pages/auth_pages/login_page.dart';
import 'package:project_writer_v04/pages/auth_pages/signup_page.dart';
import 'package:project_writer_v04/pages/auth_pages/verification_page.dart';
import 'package:project_writer_v04/pages/document/character_page/bloc/character_bloc.dart';
import 'package:project_writer_v04/pages/document/character_page/bloc/character_repository.dart';
import 'package:project_writer_v04/pages/document/character_page/character_page.dart';
import 'package:project_writer_v04/pages/document/character_page/character_write_page.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_bloc.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_repository.dart';
import 'package:project_writer_v04/pages/document/free_write_page/free_write_page.dart';
import 'package:project_writer_v04/pages/document/intro_page/bloc/intro_page_bloc.dart';
import 'package:project_writer_v04/pages/document/intro_page/bloc/intro_page_repository.dart';
import 'package:project_writer_v04/pages/document/intro_page/intro_page.dart';
import 'package:project_writer_v04/pages/auth_pages/bloc/auth_bloc.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/bloc/my_life_bloc.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/bloc/my_life_repository.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/my_life_page.dart';
import 'package:project_writer_v04/pages/document/story_page/story_page.dart';

class AppRouter {
  final _authService = AuthService();
  final _freeWriteCubit = FreeWriteCubit(newCombineRepository: FreeWriteRepository(), ideaMemo: [], searchHistory: []);
  final _myStoryCubit = MyLifeStoryCubit(myLifeRepository: MyLifeRepository(), myLifeStory: [], years: [], seasons: []);
  final _introDocumentCubit = IntroDocumentCubit(introDocumentRepository: IntroDocumentRepository(), document: []);
  final _charactersCubit = CharactersCubit(myCharacterRepository: CharactersRepository(), myCharacters: []);

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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _introDocumentCubit),
            ],
            child: IntroPage(
              shouldLogOut: _authService.logOut,
            ),
          ),
        );
        break;
      case '/story_page':
        //final ScreenArguments args = routeSettings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => StoryPage(),
        );
        break;
      case '/my_life_page':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _myStoryCubit,
            child: MyLifePage(),
          ),
        );
        break;
      case '/free_write_page':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _freeWriteCubit,
            child: FreeWritePage(
              appBarTitle: '자유롭게 쓰기',
            ),
          ),
        );
        break;
      case '/character_page':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _charactersCubit,
            child: CharactersPage(),
          ),
        );
        break;
      case '/character_write_page':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _charactersCubit,
            child: CharacterWritePage(),
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
    _charactersCubit.close();
    _introDocumentCubit.close();
    _myStoryCubit.close();
  }
}
