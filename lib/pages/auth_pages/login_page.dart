import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/types/exception/AmplifyException.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_writer_v04/services/analytics/analytics_events.dart';
import 'package:project_writer_v04/services/analytics/analytics_service.dart';
import 'package:project_writer_v04/services/controller/auth_credentials.dart';
import 'package:project_writer_v04/services/controller/auth_bloc.dart';

import 'parts/auth_source.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<LoginCredentials> didProvideCredentials;
  final VoidCallback shouldShowSignUp;

  LoginPage({Key key, this.shouldShowSignUp, this.didProvideCredentials}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userEmailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AuthButton googleLoginButton = AuthButton();
  AuthButton facebookButton = AuthButton();

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  void signInGoogle() async {
    try {
      await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }

  void signInFacebook() async {
    try {
      await Amplify.Auth.signInWithWebUI(provider: AuthProvider.facebook);
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    googleLoginButton = AuthButton(
      icon: FontAwesomeIcons.google,
      onPressed: signInGoogle,
    );

    facebookButton = AuthButton(
      icon: FontAwesomeIcons.facebook,
      onPressed: signInFacebook,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: _loginForm(),
                  ),
                ),
                isKeyboardVisible
                    ? SizedBox(
                        height: 10.0,
                      )
                    : Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              googleLoginButton,
                              facebookButton,
                            ],
                          ),
                        ),
                      ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      TextButton(
                        style: raisedButtonStyle,
                        //height: 40.0,
                        //minWidth: MediaQuery.of(context).size.width * 0.65,
                        onPressed: _login,
                        child: Text('로그인'),
                        //color: Theme.of(context).buttonColor,
                      ),
                      TextButton(
                        onPressed: widget.shouldShowSignUp,
                        child: Text(
                          '회원이 아니신가요? 회원가입',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BorderLineForm(
            controller: _userEmailController,
            icons: Icons.email_outlined,
            hintText: 'ex)example@example.com',
            labelText: '이메일',
            validator: (text) {
              if (text.isNotEmpty) {
                if (EmailValidator.validate(text)) {
                  return null;
                } else {
                  return '이메일 형식에 맞지 않습니다';
                }
              } else {
                return '이메일은 반드시 입력해야 합니다';
              }
            },
          ),
          BorderLineForm(
            controller: _passwordController,
            icons: Icons.lock_outlined,
            obscureText: true,
            hintText: '••••••••',
            labelText: '비밀번호',
            validator: (text) {
              if (text.length >= 8) {
                return null;
              } else {
                return '비밀번호는 8자리 이상이어야 합니다';
              }
            },
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      final username = _userEmailController.text.trim();
      final password = _passwordController.text.trim();

      final credentials = LoginCredentials(userName: username, password: password);
      widget.didProvideCredentials(credentials);

      if (AuthService.check == AuthCheckStatus.error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert();
          },
        );
      } else if (AuthService.check == AuthCheckStatus.notConfirm) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog();
            });
      }

      AnalyticsService.log(LoginEvent());
    }
  }
}

class AdvanceCustomAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Color(0xFF252a34),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      '로그인에 실패했습니다 :(',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '아이디와 비밀번호를 확인해주세요',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      //color: Colors.redAccent,
                      child: Text(
                        '확 인',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -40,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 30,
                  child: Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                )),
          ],
        ));
  }
}
