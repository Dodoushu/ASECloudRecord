
import 'package:flutter/material.dart';

class PictureView extends StatelessWidget{

  final List PictureInfo;
  PictureView({Key key, @required this.PictureInfo}): super(key:key);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('图片浏览'),),
      body: Container(
        child: Text(PictureInfo.toString()),
      ),
    );
}}