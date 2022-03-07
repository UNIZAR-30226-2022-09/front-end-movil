import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class BottomLineAppBar extends StatelessWidget with PreferredSizeWidget {
  const BottomLineAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        color: AppTheme.primary,
        width: double.infinity,
        height: 0.5,
      ),
      preferredSize: Size.fromHeight(0),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(0);
}
