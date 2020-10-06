import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/PickFileMethod.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:intl/intl.dart';
import 'package:helloworld/globalUtils.dart';

void main() => runApp(MaterialApp(
      home: SelfPortraitOfDisease(),
    ));

class SelfPortraitOfDisease extends StatefulWidget {
  @override
  State createState() => new _SelfPortraitOfDisease();
}

class _SelfPortraitOfDisease extends State<SelfPortraitOfDisease> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  DateTime date = DateTime.now();
  String introduction;
  String filesname;
  String filespath;
  List selectedFiles = [];
  List displayPath = [];

  Future<void> _selectDate() async //异步
  {
    final DateTime selectdate = await showDatePicker(
      //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectdate == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      date = selectdate;
    });
  }

  Future<void> _selectFile() async {
    Map filesPaths;
    getMultiFilesPath().then((value) {
      filesPaths = value;
      var selectedFilePaths = filesPaths.values;
      MultipartFile tempfile;
      for (String path in selectedFilePaths) {
        displayPath.add(path);
        MultipartFile.fromFile(path).then((value) {
          tempfile = value;
          print('*****************' + path);
          selectedFiles.add(tempfile);
          print(selectedFiles.length);
        });
      }
      setState(() {
        filesname = displayPath.toString();
      });
    });
  }

  Future<void> _selectFilefromCamera() async {
    getImageFileFromCamera().then((value) {
      displayPath.add(value);
      var selectedFilePaths = value;
      MultipartFile tempfile;

      MultipartFile.fromFile(selectedFilePaths).then((value) {
        tempfile = value;
        print('1111111111111111111111' + selectedFilePaths);
        selectedFiles.add(tempfile);
        print(selectedFiles.length);
      });

      setState(() {
        filesname = displayPath.toString();
      });
    });
  }

  void summit() async {
//    print(name);
//    var loginForm = loginKey.currentState;
//    //验证Form表单
//    if(loginForm.validate()){
//      print(name);
//    }
    if (selectedFiles == null) {
      showAlertDialog(context, contentText: '请填写所有项目，若没有信息请填写“无”');
    } else {
      var bodymap = Map<String, dynamic>();
      String phoneNum;
      SharedPreferenceUtil.getString('phoneNum').then((value) async {
        bodymap['phone_num'] = value;
        bodymap['files'] = selectedFiles;
        bodymap['date'] = date.year.toString() +
            '-' +
            date.month.toString() +
            '-' +
            date.day.toString();
        bodymap['picture_type'] = 3;
        var url = "http://39.100.100.198:8082/UploadFiles/DiseasePicture";
        var formData = FormData.fromMap(bodymap);
        await request(url, context,
                FormData: formData, contentType: 'multipart/form-data')
            .then((value) {
          var data = json.decode(value.toString());
          print(data);
          if(data['status_code'] == 1) {
            showAlertDialog(context, contentText: '上传成功', flag: 1);
          }
          else {
            showAlertDialog(context, titleText: '上传失败', contentText: '请稍后重试',flag: 0);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget basicInfo = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: _selectDate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '拍照日期:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
//                  date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString(),
                    DateFormat.yMd().format(date),
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Column(
              children: <Widget>[
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入病症自拍简介',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    introduction = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '文件上传:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Row(
                      children: <Widget>[
                        new Container(
                            margin: EdgeInsets.only(right: 10),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: _selectFilefromCamera,
                              color: Colors.blue,
                              child: new Text('相机拍照',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
                            )),
                        new Container(
//                    margin: EdgeInsets.only(left: 30),
                            child: RaisedButton(
                          elevation: 0,
                          onPressed: _selectFile,
                          color: Colors.blue,
                          child: new Text('选择文件',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '已选择文件:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                smallPicGridView(displayPath)
              ],
            )
          ],
        ),
      ),
    );

    Widget dividerline = Container(
      height: 60,
    );

    Widget ok = new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          onPressed: summit,
          color: Colors.blue,
          child: new Text(
            '确定',
            style: TextStyle(
                fontSize: 14.0, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '病症自拍上传',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
//          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              width: double.infinity,
              height: 90,
              child: Center(
                  child: new Text(
                '自拍照片选择',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
//              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[basicInfo, dividerline, ok],
              ),
            )
          ],
        ));
  }
}
