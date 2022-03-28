import 'package:alejandria/provider/provider.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class tematicaWidget2 extends StatelessWidget {
  final int index;
  final IconData icon;
  final String name;
  const tematicaWidget2(
      {Key? key, required this.index, required this.icon, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tematicaProvider = Provider.of<TematicasProvider>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // print('${ categoria.name }');
              tematicaProvider.isSelected = index;
            },
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tematicaProvider.tematicas[index].isSelected
                      ? AppTheme.primary
                      : Colors.grey[300],
                  border: Border()),
              child: Icon(
                icon,
                color: tematicaProvider.tematicas[index].isSelected
                    ? Colors.white
                    : AppTheme.primary,
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
