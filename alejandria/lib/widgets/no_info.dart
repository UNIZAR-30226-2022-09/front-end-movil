import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoPosts extends StatelessWidget {
  String text;
  IconData icon;
  NoPosts(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: 90,
        ),
        FaIcon(
          icon,
          size: 100,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey, fontSize: 19, fontStyle: FontStyle.italic),
        )
      ]),
    );
  }
}
