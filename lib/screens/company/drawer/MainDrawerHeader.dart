import 'package:flutter/material.dart';
class MainDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        child: Image.asset('assets/images/fixauto_logo.png'),
        decoration: BoxDecoration(
          color: Colors.white
        ),
    );
  }
}
