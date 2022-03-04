import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('ALEJANDRÍA',
            style: TextStyle(
                fontFamily: 'Amazing Grotesc Ultra',
                fontSize: 30,
                color: Color.fromRGBO(68, 114, 88, 1))),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chat_bubble_outline_rounded,
                color: Color.fromRGBO(68, 114, 88, 1),
                size: 30,
              ))
        ],
        backgroundColor: Colors.white12,
        bottom: PreferredSize(
          child: Container(
            color: Color.fromRGBO(68, 114, 88, 1),
            width: double.infinity,
            height: 0.5,
          ),
          preferredSize: Size.fromHeight(0),
        ), //Color.fromRGBO(68, 114, 88, 1),
      ),
      body: Center(
        child: Container(
          child: Text('Pagina Principal'),
        ),
      ),
    );
  }
}
