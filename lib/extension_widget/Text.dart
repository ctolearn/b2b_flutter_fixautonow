import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Text('MY TEXT').setStyle(...).setFontFamily(...),
extension TextExtensions on Text {
  Text boldText() => copyWith(style: TextStyle(fontWeight: FontWeight.bold));

  Text textColor(Color colors) => copyWith(style: TextStyle(color: colors));

  Text blackColor() => copyWith(style: TextStyle(color: Colors.black54));

  Text whiteColor() => copyWith(style: TextStyle(color: Colors.white));

  /*Text setStyle(TextStyle style) => copyWith(style: style);

  Text setFontFamily(String fontFamily) =>
      copyWith(style: TextStyle(fontFamily: fontFamily));

  */
  Text copyWith(
      {Key key,
      StrutStyle strutStyle,
      TextAlign textAlign,
      TextDirection textDirection = TextDirection.ltr,
      Locale locale,
      bool softWrap,
      TextOverflow overflow,
      double textScaleFactor,
      int maxLines,
      String semanticsLabel,
      TextWidthBasis textWidthBasis,
      TextStyle style}) {
    return Text(this.data,
        key: key ?? this.key,
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection ?? this.textDirection,
        locale: locale ?? this.locale,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
        style: style != null ? this.style?.merge(style) ?? style : this.style);
  }
}
