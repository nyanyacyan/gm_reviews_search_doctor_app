//? 通常のテキストwidget
//? imports ====================================================
import 'package:flutter/material.dart';
//* ------------------------------------------------------------

class BasicText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const BasicText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    this.color,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

//* ------------------------------------------------------------


class BasicTextFlexible extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const BasicTextFlexible({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    this.color,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}

//* ------------------------------------------------------------
