import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class tematicaWidget extends StatefulWidget {
  final IconData icon;
  final String name;
  bool isSelected;

  tematicaWidget(
      {Key? key,
      required this.icon,
      required this.name,
      required this.isSelected})
      : super(key: key);

  @override
  State<tematicaWidget> createState() =>
      _tematicaWidgetState(icon, name, isSelected);
}

class _tematicaWidgetState extends State<tematicaWidget> {
  final IconData icon;
  final String name;
  bool isSelected;
  _tematicaWidgetState(this.icon, this.name, this.isSelected);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // print('${ categoria.name }');
              isSelected = !isSelected;
              setState(() {});
            },
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppTheme.primary : Colors.grey[300],
                  border: Border()),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppTheme.primary,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(name, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
