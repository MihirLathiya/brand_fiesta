import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? color;
  final double? fontSize, height, letterSpacing, wordSpacing;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLine;
  const CommonText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.overflow,
    this.height,
    this.letterSpacing,
    this.wordSpacing,
    this.fontFamily = 'roboto',
    this.maxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 812;
    final size = MediaQuery.of(context).size.height / baseWidth;
    double font = size * 0.97;
    return Text(
      text,
      maxLines: maxLine,
      style: TextStyle(
        color: color,
        fontSize: fontSize! * font,
        fontWeight: fontWeight,
        overflow: overflow,
        height: height,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        fontFamily: fontFamily,
      ),
    );
  }
}
