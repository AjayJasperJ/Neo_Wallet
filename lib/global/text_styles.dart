import 'package:flutter/material.dart';
import 'package:neo_pay/main.dart';

class CustomTextStyler {
  TextStyle styler(
      {num? size, String? type, Color? color, String? decoration}) {
    FontWeight fontWeight;
    FontStyle fontStyle = FontStyle.normal;
    TextDecoration textDecoration = TextDecoration.none;

    switch (type) {
      case 'B':
        fontWeight = FontWeight.w700;
        break;
      case 'M':
        fontWeight = FontWeight.w500;
        break;
      case 'R':
        fontWeight = FontWeight.w400;
        break;
      case 'L':
        fontWeight = FontWeight.w300;
        break;
      case 'S':
        fontWeight = FontWeight.w600;
        break;
      case 'I':
        fontWeight = FontWeight.w400;
        fontStyle = FontStyle.italic;
        break;
      case 'BI':
        fontWeight = FontWeight.w700;
        fontStyle = FontStyle.italic;
        break;
      default:
        fontWeight = FontWeight.w400;
    }
    switch (decoration) {
      case 'U':
        textDecoration = TextDecoration.underline;
        break;
      case 'O':
        textDecoration = TextDecoration.overline;
        break;
      case 'LT':
        textDecoration = TextDecoration.lineThrough;
        break;
      default:
        textDecoration = TextDecoration.none;
    }

    return TextStyle(
      fontSize: displaysize.height * size!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      decoration: textDecoration,
    );
  }
}
