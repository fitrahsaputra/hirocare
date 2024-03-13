import "package:flutter/material.dart";

class TextWidget extends StatelessWidget {
  final String params;
  final double fontSize;
  final TextAlign? textAlign;

  const TextWidget({super.key, required this.params, required this.fontSize, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(params,
        style: TextStyle(fontSize: fontSize), textAlign: textAlign);
  }
}
