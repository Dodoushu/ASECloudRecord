import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/File_Method.dart';
import 'package:helloworld/PickFileMethod.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/doctor/login.dart' as login;
import 'package:helloworld/sharedPrefrences.dart';

import '../showAlertDialogClass.dart';

void main() => runApp(new register2());

class register2 extends StatefulWidget {
  @override
  State createState() => new _register2();
}

class _register2 extends State<register2> {
  var url = 'http://39.100.100.198:8082';
  String name;         //姓名
  String id_number;    //身份证号
  String specialty;
  String introduction;
  String socialwork;

  MultipartFile id_photo;
  MultipartFile id_card1;
  MultipartFile id_card2;
  MultipartFile certificate;
  MultipartFile worklicense;
  MultipartFile title_certi;

  File_Method file_method = new File_Method();

  var map = Map();
  var filename = Map();

  //上传表单
  void submit() {

    var bodymap = Map();
    var doctor= Map();
    String phoneNum;
    SharedPreferenceUtil.getString('phoneNum').then((value){
      phoneNum = value;
      bodymap['phone_num'] = phoneNum;
      doctor['name'] = name;
      //doctor[]
      FormData formData = FormData.fromMap(map);

      request(url,context, FormData: formData, contentType: 'multipart/form-data')
          .then((value) {
        print('response:' + json.decode(value.toString()));
      });

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => login.Login()));
    });

  }

  void _selectFile(String imageflag) async {
    getSingleImagePath().then((path) {
      MultipartFile.fromFile(path).then((value) {
        map[imageflag] = value;
      });

      setState(() {
        filename[imageflag] = path.toString();
      });
    });
  }

  void _selectFilefromCamera(String imageflag) async {
    getImageFileFromCamera().then((path) {
      MultipartFile.fromFile(path).then((value) {
        map[imageflag] = value;
      });
      setState(() {
        filename[imageflag] = path.toString();
      });
    });
  }

//  ID_Photopick() async{
//    await file_method.file_pick().then((value) {ID_Photo = value;});
//
//    int FileSize = await ID_Photo.length;
//    if(FileSize > 1024){                     //用length得到文件大小，太大了就给提示（界面上弹窗提示信息），同时清理变量ID_photo
//      //弹窗提醒文件过大
//      ID_Photo = null;
//    }
//  }     //异步函数返回的也是一个future，需要async、await的配合提取
//  IDCard_1pick() async{await file_method.file_pick().then((value){IDCard_1 = value;});}
//  IDCard_2pick() async{await file_method.file_pick().then((value){IDCard_2 = value;});}
//  zi_ge_zhengpick() async{await file_method.file_pick().then((value){zi_ge_zheng = value;});}
//  zhi_ye_zhengpick() async{await file_method.file_pick().then((value){zhi_ye_zheng = value;});}
//  zhi_chengpick() async{await file_method.file_pick().then((value){zhi_cheng = value;});}

  @override
  Widget build(BuildContext context) {
    Widget BasicInfo = new Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '基础信息',
                style: TextStyle(fontSize: 25),
              ),
              Divider(
                thickness: 2,
              ),
              TextField(
                decoration: new InputDecoration(
                  labelText: '请输入您的姓名',
                  labelStyle: new TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              Divider(
                thickness: 2,
              ),
              TextField(
                decoration: new InputDecoration(
                    labelText: '请输入您的身份证号',
                    labelStyle: new TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none),
                onChanged: (value) {
                  id_number = value;
                },
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                children: <Widget>[
                  Text(
                    '证件照:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFile('id_photo')},
                        color: Colors.blue,
                        child: new Text('选择照片',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      )),
                  new Container(
                      margin: EdgeInsets.only(left: 5),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFilefromCamera('id_photo')},
                        color: Colors.blue,
                        child: new Text('相机拍照',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      )),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Text(
                filename['id_photo'].toString(),
                //"dasda",
                style: TextStyle(fontSize: 19),
              ),
              new Row(
                children: <Widget>[
                  Text(
                    '身份证正面照片:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFile('id_card1')},
                        color: Colors.blue,
                        child: new Text('选择照片',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      )),
                  new Container(
                      margin: EdgeInsets.only(left: 5),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFilefromCamera('id_card1')},
                        color: Colors.blue,
                        child: new Text('相机拍照',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      ))
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Text(
                filename['id_card1'].toString(),
                //"dasda",
                style: TextStyle(fontSize: 19),
              ),
              new Row(
                children: <Widget>[
                  Text(
                    '身份证反面照片:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFile('id_card2')},
                        color: Colors.blue,
                        child: new Text('选择照片',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      )),
                  new Container(
                      margin: EdgeInsets.only(left: 5),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFilefromCamera('id_card2')},
                        color: Colors.blue,
                        child: new Text('相机拍照',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      ))
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Text(
                filename['id_card2'].toString(),
                //"dasda",
                style: TextStyle(fontSize: 19),
              ),
              new Row(
                children: <Widget>[
                  Text(
                    '医师资格证:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFile('certificate')},
                        color: Colors.blue,
                        child: new Text('选择照片',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      )),
                  new Container(
                      margin: EdgeInsets.only(left: 5),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFilefromCamera('certificate')},
                        color: Colors.blue,
                        child: new Text('相机拍照',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      ))
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Text(
                filename['certificate'].toString(),
                //"dasda",
                style: TextStyle(fontSize: 19),
              ),
              new Row(
                children: <Widget>[
                  Text(
                    '医师执业证:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFile('worklicense')},
                        color: Colors.blue,
                        child: new Text('选择照片',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      )),
                  new Container(
                      margin: EdgeInsets.only(left: 5),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () =>
                            {_selectFilefromCamera('worklicense')},
                        color: Colors.blue,
                        child: new Text('相机拍照',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      ))
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Text(
                filename['worklicense'].toString(),
                //"dasda",
                style: TextStyle(fontSize: 19),
              ),
              new Row(
                children: <Widget>[
                  Text(
                    '医师职称证书:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFile('title_certi')},
                        color: Colors.blue,
                        child: new Text('选择照片',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      )),
                  new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {_selectFilefromCamera('title_certi')},
                        color: Colors.blue,
                        child: new Text('相机拍照',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      ))
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Text(
                filename['title_certi'].toString(),
                //"dasda",
                style: TextStyle(fontSize: 19),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                child: Text('专业特长:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    )),
              ),
              TextField(
                decoration: new InputDecoration(
                  labelStyle: new TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),
                  ),
                  //border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                onChanged:(value){
                  specialty = value;
              } ,
              ),
              Container(
                child: Text('医师简介:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    )),
              ),
              TextField(
                decoration: new InputDecoration(
                  labelStyle: new TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),
                  ),
                  //border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                onChanged: (value){
                  introduction = value;
                },
              ),
              Container(
                child: Text('社会兼职:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    )),
              ),
              TextField(
                decoration: new InputDecoration(
                  labelStyle: new TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),
                  ),
                  //border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                onChanged: (value){
                  specialty = value;
                },
              )
            ],
          ),
        ));

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
            onPressed: () {
              submit;

            }),
      ),
    );
    return new MaterialApp(
      title: '医生注册2',
      home: new Scaffold(
        appBar: new AppBar(
            title: Text(
              '信息录入',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: new Icon(
              Icons.arrow_back_ios,
              size: 25,
            )),
        body: new ListView(
          children: <Widget>[BasicInfo, ok],
        ),
      ),
    );
  }
}

//缩略图Widget
Widget imgItem(index, setState, imgData) {
  return GestureDetector(
    child: Container(
      color: Colors.transparent,
      child: Stack(alignment: Alignment.topRight, children: <Widget>[
        ConstrainedBox(
          child: Image.file(imgData[index], fit: BoxFit.cover),
//          child: Image.file(File(imgData[index]), fit: BoxFit.cover),
          constraints: BoxConstraints.expand(),
        ),
      ]),
    ),
  );
}
