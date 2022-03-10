import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explorador',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: AppTheme.primary,
                size: 30,
              ))
        ],
        bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
      ),
      body: Center(
        child: Text('ExplorerScreen'),
      ),
    );
  }
}
