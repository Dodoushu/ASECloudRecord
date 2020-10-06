import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/PickFileMethod.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:intl/intl.dart';

import 'package:helloworld/globalUtils.dart';

void main() => runApp(MaterialApp(
  home: invasiveReview(),
));

class invasiveReview extends StatefulWidget {
  @override
  State createState() => new _invasiveReview();
}

class _invasiveReview extends State<invasiveReview> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  DateTime date = DateTime.now();
  String conclusion;
  String filesname;
  String filespath;
  String laboratoryType;
  List selectedFiles = [];
  List displayPath = [];
  String lebalContent = '请选择检查类目';
  Map labelmap = {
    '1':'胃镜检查',
    '2':'肠镜检查',
    '3':'鼻窦镜检查',
    '4':'支气管镜检查',
    '5':'膀胱尿道镜检查',
    '6':'阴道镜检查',
    '7':'宫腔镜检查',
    '8':'其他检查',
  };


  List<DropdownMenuItem> getListData(){
    List<DropdownMenuItem> items=new List();
    DropdownMenuItem dropdownMenuItem1=new DropdownMenuItem(
      child:new Text('胃镜检查'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2=new DropdownMenuItem(
      child:new Text('肠镜检查'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3=new DropdownMenuItem(
      child:new Text('鼻窦镜检查'),
      value: '3',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4=new DropdownMenuItem(
      child:new Text('支气管镜检查'),
      value: '4',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5=new DropdownMenuItem(
      child:new Text('膀胱尿道镜检查'),
      value: '5',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6=new DropdownMenuItem(
      child:new Text('阴道镜检查'),
      value: '6',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7=new DropdownMenuItem(
      child:new Text('宫腔镜检查'),
      value: '7',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8=new DropdownMenuItem(
      child:new Text('其他检查'),
      value: '8',
    );
    items.add(dropdownMenuItem8);
    return items;
  }

  var value;
  var flag2=0;

/*  _LearnDropdownButton(){
    value=getListData()[0].value;
  }*/


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
          if(value!=Null){
            flag2=1;
          }
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
        if(value!=Null){
            flag2=1;
        }
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

    if(selectedFiles == null || laboratoryType == null || conclusion == null || flag2 == 0){
      showAlertDialog(context, contentText: '请填写所有项目，若没有信息请填写“无”');
    }
    else{var bodymap = Map<String, dynamic>();
    String phoneNum;
    SharedPreferenceUtil.getString('phoneNum').then((value) async{
      phoneNum = value;
      bodymap['files'] = selectedFiles;
      bodymap['date'] = date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString();
      bodymap['items'] = laboratoryType;
      bodymap['result'] = conclusion;
      bodymap['phone_num'] = phoneNum;
      var url = "http://39.100.100.198:8082/UploadFiles/InvasiveInstruments";
      var formData = FormData.fromMap(bodymap);
      await request(url,context, FormData: formData,contentType: 'multipart/form-data').then((value) {

          var data = json.decode(value.toString());
          print(data);
          if(data['status_code'] == 1){
            showAlertDialog(context,  contentText: '操作成功',flag: 1);
          }
          else {
            showAlertDialog(context, titleText: '上传失败', contentText: '请稍后重试',flag: 0);
          }
      });
    });}
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
                    '检查日期:',
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '检查类目:',
                  style: TextStyle(fontSize: 19),
                ),
                new DropdownButton(
                  items: getListData(),
                  hint:new Text(lebalContent),//当没有默认值的时候可以设置的提示
                  onChanged: (value){//下拉菜单item点击之后的回调
                    laboratoryType = value;
                    print(laboratoryType);
                    setState(() {
                      lebalContent = labelmap[value];
                    });
                  },
                  elevation: 24,//设置阴影的高度
                  style: new TextStyle(//设置文本框里面文字的样式
                      color: Colors.black,
                      fontSize: 15
                  ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                  iconSize: 50.0,//设置三角标icon的大小
                ),
              ],
            ),


            Divider(
              thickness: 2,
            ),
            Column(
              children: <Widget>[
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入检查结论',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged: (value) {
                    conclusion = value;
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
            '侵入型器械检查',
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
                    '侵入型器械检查结果上传',
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
