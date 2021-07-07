import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class FloatingButton extends StatelessWidget {
  VoidCallback onPress;
  FloatingButton({Key key,this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 35,
        height: 35,
        child: FloatingActionButton(
          onPressed: onPress,
          child: const FaIcon(
            FontAwesomeIcons.plus,
            size: 14,
          ),
          backgroundColor: Colors.blue,
        ));;
  }
}
