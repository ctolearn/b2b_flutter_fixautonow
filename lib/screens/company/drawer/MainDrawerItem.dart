import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainDrawerItem extends StatelessWidget {
  final VoidCallback onTapCallback; //Add this custom onTap method
  final String name;
  final FaIcon faiIcon;
  final bool isSelected;

  MainDrawerItem(
      {this.onTapCallback, this.name, this.faiIcon, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: ListTile(
          selected: isSelected,
          dense: true,
          leading: faiIcon,
          title: Text(
            this.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: onTapCallback,
        ));
  }
}
/*

class MainDrawerItem extends StatelessWidget {

}
*/
