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
      home: medicalReport(),
    ));

class medicalReport extends StatefulWidget {
  @override
  State createState() => new _medicalReport();
}

class _medicalReport extends State<medicalReport> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  DateTime date = DateTime.now();
  String hospital;
  String conclusion;
  String reportAbstract;
  String filesname;
  String filespath;
  List displayPath = [];
  List<MultipartFile> selectedFiles = new List<MultipartFile>();

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
    showDialog(
        context: context,
        builder: (context) {
          return new NetLoadingDialog(
            //  dismissDialog: _disMissCallBack,
          );
        }
    );
    var bodymap = Map<String,dynamic>();
    String phoneNum;
    SharedPreferenceUtil.getString('phoneNum').then((value) async{
      phoneNum = value;
      bodymap['phone_num'] = phoneNum;
      bodymap['files'] = selectedFiles;
      bodymap['hospital'] = hospital;
      bodymap['report_info'] = reportAbstract;
      bodymap['result'] = conclusion;
      bodymap['date'] = date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString();
      var url = "http://39.100.100.198:8082/UploadFiles/MedicalExaminationReport";
      FormData formData = FormData.fromMap(bodymap);
      await request(url, context,FormData: formData,contentType: 'multipart/form-data').then((value) {
          var data = json.decode(value['response'].toString());
          print(data);
          showAlertDialog(context,contentText: '上传成功',flag: 1);
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
            InkWell(
              onTap: _selectDate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '体检日期:',
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
                    labelText: '请输入体检机构',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    hospital = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入主要结论或诊断',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    conclusion = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入体检摘要',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    reportAbstract = value;
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
                    ),
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
                Text(
                  filesname.toString(),
                  style: TextStyle(fontSize: 19),
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
          iconTheme: IconThemeData(
            color: Colors.black, //修改颜色
          ),
          title: Text(
            '健康体检记录',
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
                '体检记录上传',
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
