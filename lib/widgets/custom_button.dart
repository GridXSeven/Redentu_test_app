import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    @required this.color,
    @required this.text,
    @required this.onTap,
  });
  final Color color;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      onPressed: onTap,
      child: Text(
        text,
      ),
    );
  }
}
