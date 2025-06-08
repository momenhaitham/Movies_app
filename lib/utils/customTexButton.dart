import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class Customtextbutton extends StatelessWidget {
  Customtextbutton({
    super.key,
    required this.onpressed,
    required this.text,
    this.style,
  });
  final Function onpressed;
  final String text;
  TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onpressed();
      },
      child: Text(text, style: style ?? TextStyle(color: appColors.primary)),
    );
  }
}
