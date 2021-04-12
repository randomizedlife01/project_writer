import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//기본 메뉴 버튼
class BasicMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String buttonText;

  const BasicMenuButton({Key key, this.onPressed, this.icon, this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0.0),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(12.0, 12.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: 18.0,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

//기본 앱 바
class BasicAppBar extends StatelessWidget {
  final String appBarTitle;

  const BasicAppBar({Key key, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        appBarTitle,
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w200, fontSize: 20.0),
      ),
    );
  }
}

//기본 우하단 플로팅 버튼
class BasicFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const BasicFloatingButton({Key key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Center(
          child: Container(
            width: 45,
            height: 45,
            child: Icon(
              icon,
              size: 25.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF3b4445),
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF181c1c),
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Color(0xFF596769),
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
    );
  }
}

//버튼 가로 리스트 나눌 때 선
class BasicVerticalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      indent: 40.0,
      endIndent: 40.0,
      color: Color(0xFFc4d6cb),
      width: 8.0,
    );
  }
}

class DocInputForm extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool autoFocus;
  final VoidCallback onTap;
  final Function validator;

  const DocInputForm({
    Key key,
    this.hintText,
    this.labelText,
    this.controller,
    this.autoFocus = true,
    this.onTap,
    this.validator,
  }) : super(key: key);

  Widget inputForm({String hintText, String labelText, TextEditingController controller}) {
    return TextFormField(
      maxLines: null,
      controller: controller,
      keyboardType: TextInputType.multiline,
      style: TextStyle(
        fontSize: 12.0,
        fontFamily: 'GothicA1',
        color: Color(0xFF252a34),
        fontWeight: FontWeight.w600,
      ),
      onTap: onTap,
      autofocus: autoFocus,
      autocorrect: false,
      validator: validator,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFe23e57),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFe23e57),
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12.0,
          fontFamily: 'GothicA1',
          color: Color(0xff8785a2),
          fontWeight: FontWeight.w600,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 12.0,
          fontFamily: 'GothicA1',
          color: Color(0xFFc06c84),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return inputForm(hintText: hintText, labelText: labelText, controller: controller);
  }
}
