import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/PickFileMethod.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';
import 'package:helloworld/patient/MainFunctionPage.dart';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
  home: Pathology(),
));

class Pathology extends StatefulWidget {
  @override
  State createState() => new _Pathology();
}

class _Pathology extends State<Pathology> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  DateTime date = DateTime.now();
  String content;

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

//  Future<void> _selectFile() async {
//    Map filesPaths;
//    getMultiFilesPath().then((value){
//      filesPaths = value;
//      var selectedFilePaths = filesPaths.values;
//      MultipartFile tempfile;
//      for(String path in selectedFilePaths){
//        MultipartFile.fromFile(path).then((value){
//          tempfile = value;
//          print('*****************'+path);
//          selectedFiles.add(tempfile);
//          print(selectedFiles.length);
//        });
//      }
//      setState(() {
//        filesname = value.keys.toString();
//      });
//    });
//  }

  void summit() async {

//    print(name);
//    var loginForm = loginKey.currentState;
//    //验证Form表单
//    if(loginForm.validate()){
//      print(name);
//    }
    showDialog(
        context: context,
        builder: (context) {
          return new NetLoadingDialog(
            //  dismissDialog: _disMissCallBack,
          );
        }
    );
    var bodymap = Map();
    String phoneNum;
    SharedPreferenceUtil.getString('phoneNum').then((value) async{
      phoneNum = value;
      bodymap['phone_num'] = phoneNum;
      bodymap['examine_info'] = content;
      print(bodymap);
      var url = "http://39.100.100.198:8082/diseaseExamine";
      var formData = bodymap;
      await request(url, FormData: formData).then((value) {
        var data = json.decode(value.toString());
        print(data);
        showAlertDialog(context,
              titleText: '', contentText: '操作成功',flag: 1);

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget basicInfo = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '病理学检查结果',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 10,
                  onChanged: (value) {
                    content = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
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
            '病理学检查',
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
                    '病理学检查结果上传',
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
