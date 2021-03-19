import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/auth_pages/parts/auth_source.dart';
import 'package:project_writer_v04/services/analytics/analytics_events.dart';
import 'package:project_writer_v04/services/analytics/analytics_service.dart';

class VerificationPage extends StatefulWidget {
  final ValueChanged<String> didProvideVerificationCode;

  VerificationPage({Key key, this.didProvideVerificationCode}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: _verificationForm(),
      ),
    );
  }

  Widget _verificationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Verification Code TextField
        BorderLineForm(
          controller: _verificationCodeController,
          icons: Icons.confirmation_number,
          labelText: '코드 입력',
        ),
        SizedBox(
          height: 30.0,
        ),
        TextButton(
          //height: 40.0,
          //minWidth: MediaQuery.of(context).size.width * 0.65,
          onPressed: _verify,
          child: Text('인증하기'),
          //color: Theme.of(context).buttonColor,
        ),
      ],
    );
  }

  void _verify() {
    final verificationCode = _verificationCodeController.text.trim();
    widget.didProvideVerificationCode(verificationCode);

    AnalyticsService.log(VerificationEvent());
  }
}
