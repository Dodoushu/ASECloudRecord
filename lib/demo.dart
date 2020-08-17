import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'PickFileMethod.dart';
import 'package:helloworld/http_service.dart';

void main() =>runApp(new register2());

class register2 extends StatefulWidget{
  @override
  State createState() => new _register2();
}

class _register2 extends State<register2> {

  var url = 'http://39.100.100.198:8082/file/upload';


  String filePath;

  MultipartFile pickedFile;

  void pickFile() async{
    getSingleImagePath().then((value) => filePath=value);
    pickedFile = await MultipartFile.fromFile(filePath);
  }

  //上传表单
  void CreateForm_POST(){

    print(pickedFile);
    var map = Map<String, dynamic>();
    map['phone_num'] = '66779';
    map['file'] = pickedFile;
    map['picture_type']=3;

    FormData formData = FormData.fromMap(map);
//
    request(url,FormData: map,contentType: 'multipart/form-data').then((value)
    {
      print('response:' + json.decode(value.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget BasicInfo = new Container(
        padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
        child:Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(
                thickness: 2,
              ),
              Row(
                children: <Widget>[
                  Text('上传图片测试:', style:TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),
                  ),
                  ),
                  new Container(
                      margin: EdgeInsets.only(left: 30),
                      child:RaisedButton(
                        elevation: 0,
                        onPressed: pickFile,
                        color: Colors.blue,
                        child:new Text(
                            '上传照片',
                            style:TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      )
                  ),
                ],
              ),
            ],
          ),
        )
    );

    Widget ok = new Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          color: Colors.blue,
          child: new Text(
            '确定',
            style: TextStyle(
                fontSize: 20.0, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
          onPressed: CreateForm_POST,
        ),
      ),
    );
    return new MaterialApp(
      title: '医生注册2',
      home: new Scaffold(
        appBar:new AppBar(
          title: Text(
            '信息录入',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: new ListView(
          children: <Widget>[
            BasicInfo,ok
          ],
        ),

      ),
    );
  }

}
