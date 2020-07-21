import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: new Center(
        child: Text(
          '消息',
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),);
  }
}