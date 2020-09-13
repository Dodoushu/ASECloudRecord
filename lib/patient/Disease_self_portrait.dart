import 'package:flutter/material.dart';
import 'BottomNavigationBar.dart';
void main() => runApp(new DiseasePhoto());

class DiseasePhoto extends StatefulWidget{
  @override
  State createState() => new _DiseasePhoto();
}


class _DiseasePhoto extends State<DiseasePhoto> {

  @override
  Widget build(BuildContext context) {

    Widget uploadimage = new GestureDetector(
        onTap: (){
          //上传图片
        },
        child: new Container(
          height: 130,
          width: 130,
          color: Colors.blueGrey,
          child: new Center(
            child: Icon(Icons.file_upload,size: 60,color: Colors.white,),
          ),
        )
    );

    return new MaterialApp(
      title:"病症自拍照片",
      home: new Scaffold(
        appBar: new AppBar(
          title: Text(
            '病症自拍照片',
            style: TextStyle(color: Colors.white),
          ),
          leading: new Icon(Icons.arrow_back_ios,size: 25,),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: new ListView(
          children: <Widget> [
              uploadimage,
          ]
        ),
      ),
    );
  }

}