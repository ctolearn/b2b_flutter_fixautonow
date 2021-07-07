import 'package:flutter/material.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:flutter/services.dart';

class CircularTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  String labelText;
  Color color;
  Icon icon;
  DecorationSize descorationSize;
  bool isEnabled;
  VoidCallback onTap = null;
  Function(String) onChange;
  TextInputType textInputType;
  int maxlength;
  List<TextInputFormatter> textInputFormatter;

  CircularTextField(
      {Key key,
      @required this.controller,
      this.labelText,
      this.hintText,
      this.color,
      this.icon,
      @required this.isEnabled,
      this.onTap,
      this.maxlength,
      this.onChange,
      this.textInputType,
      this.textInputFormatter,
      this.descorationSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration;
    switch (descorationSize) {
      case DecorationSize.SMALL:
        decoration = InputDecoration(
          counter: Offstage(),
          border: OutlineInputBorder(),
          hintText: hintText ?? hintText,
          isDense: true,
          // Added this
          contentPadding: EdgeInsets.all(8), // Added this
        );
        break;
      case DecorationSize.LARGE:
        decoration = InputDecoration(
          counter: Offstage(),
          border: OutlineInputBorder(),
          hintText: hintText ?? hintText,
        );
        break;
      case DecorationSize.MEDIUM:
        decoration = InputDecoration(
          counter: Offstage(),
          border: OutlineInputBorder(),
          hintText: hintText ?? hintText,
          isDense: true, // Added this
        );
        break;
      default:
    }
    return isEnabled
        ? TextField(
            onChanged: onChange == null ? null :(String val) {
              onChange(val);
            },

            controller: controller,
            decoration: decoration,
            keyboardType: textInputType,
            maxLength: maxlength,
            inputFormatters: textInputFormatter != null ? textInputFormatter : null,
          )
        : GestureDetector(
            onTap: onTap,
            child: AbsorbPointer(
                child: TextField(
              controller: controller,
              decoration: decoration,
            )));
  }

/*InputDecoration(
          fillColor: color ?? color,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
          prefixIcon: icon ?? icon,
          hintText: hintText ?? hintText,
          labelText: labelText,

            )*/
}
