import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum FormFormat { email, password }

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const AuthButton({Key key, this.onPressed, this.icon}) : super(key: key);

  Widget circleButton() {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      fillColor: Color(0xFF252a34),
      child: FaIcon(
        icon,
        color: Color(0xFF8785a2),
        size: 17.0,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(
        side: BorderSide(
          color: Color(0xFF8785a2),
          width: 0.7,
          style: BorderStyle.solid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return circleButton();
  }
}

class BorderLineForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconData icons;
  final bool obscureText;
  final Function(String) validator;

  const BorderLineForm({
    Key key,
    this.controller,
    this.hintText,
    this.labelText,
    this.icons,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText2,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        icon: Icon(
          icons,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      validator: validator,
    );
  }
}
