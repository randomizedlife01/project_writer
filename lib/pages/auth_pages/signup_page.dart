import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/auth_pages/parts/auth_source.dart';
import 'package:project_writer_v04/services/analytics/analytics_events.dart';
import 'package:project_writer_v04/services/analytics/analytics_service.dart';
import 'package:project_writer_v04/services/controller/auth_credentials.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials> didProvideCredentials;
  final VoidCallback shouldShowLogin;

  SignUpPage({Key key, this.shouldShowLogin, this.didProvideCredentials}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _userEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: _signUpForm(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  TextButton(
                    //minWidth: MediaQuery.of(context).size.width * 0.65,
                    onPressed: _signUp,
                    child: Text('회원가입'),
                    //color: Theme.of(context).buttonColor,
                  ),
                  TextButton(
                    onPressed: widget.shouldShowLogin,
                    child: Text(
                      '계정이 있으신가요? 로그인',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                BorderLineForm(
                  controller: _userEmailController,
                  icons: Icons.email_outlined,
                  hintText: 'ex)example@example.com',
                  labelText: '이메일',
                  validator: (text) {
                    if (text.length > 0) {
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
                BorderLineForm(
                  controller: _passwordConfirmController,
                  icons: Icons.lock,
                  obscureText: true,
                  hintText: '••••••••',
                  labelText: '비밀번호 확인',
                  validator: (text) {
                    if (text == _passwordController.text) {
                      return null;
                    } else {
                      return '비밀번호가 일치하지 않습니다';
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState.validate()) {
      final userEmailName = _userEmailController.text.trim();
      final password = _passwordController.text.trim();

      final credentials = SignUpCredentials(userName: userEmailName, password: password, email: userEmailName);
      widget.didProvideCredentials(credentials);

      AnalyticsService.log(SignUpEvent());
    }
  }
}
