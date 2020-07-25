import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/File_Method.dart';
import 'package:helloworld/http_service.dart';
void main() =>runApp(new register2());

class register2 extends StatefulWidget{
  @override
  State createState() => new _register2();
}

class _register2 extends State<register2> {

  var url = '';
  String name;
  String IdCardNumber;
  String Specialty;
  String Introduction;
  String SocialWork;

  MultipartFile ID_Photo;
  MultipartFile IDCard_1;
  MultipartFile IDCard_2;
  MultipartFile zi_ge_zheng;
  MultipartFile zhi_ye_zheng;
  MultipartFile zhi_cheng;

  File_Method file_method = new File_Method();

  void CreateForm_POST(){

    var map = Map();
    map['name'] = name;
    map['IdCardNumber'] = IdCardNumber;
    map['Specialty'] = Specialty;
    map['Introduction'] = Introduction;
    map['SocialWork'] = SocialWork;

    map['ID_Photo'] = ID_Photo;  //证件照
    map['IDCard_1'] = IDCard_1;  //身份证正面照
    map['IDCard_2'] = IDCard_2;   //身份证反面照
    map['certification'] = zi_ge_zheng;   //医师资格证
    map['practice_license'] = zhi_ye_zheng;   //医师执业证
    map['pro_certificates '] = zhi_cheng;    //医师职称证书
    FormData formData = FormData.fromMap(map);

    request(url,FormData: formData,contentType: 'multipart/form-data').then((value)
    {
      print('response:' + json.decode(value.toString()));
    });
  }

  ID_Photopick() async{await file_method.file_pick().then((value){ID_Photo = value;});}     //异步函数返回的也是一个future，需要async、await的配合提取
  IDCard_1pick() async{await file_method.file_pick().then((value){IDCard_1 = value;});}
  IDCard_2pick() async{await file_method.file_pick().then((value){IDCard_2 = value;});}
  zi_ge_zhengpick() async{await file_method.file_pick().then((value){zi_ge_zheng = value;});}
  zhi_ye_zhengpick() async{await file_method.file_pick().then((value){zhi_ye_zheng = value;});}
  zhi_chengpick() async{await file_method.file_pick().then((value){zhi_cheng = value;});}

  @override
  Widget build(BuildContext context) {
    Widget BasicInfo = new Container(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
      child:Container(
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
                        fontSize: 15,
                        color: Color.fromARGB(255, 93, 93, 93)
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value){
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
                      fontSize: 15,
                      color: Color.fromARGB(255, 93, 93, 93)
                    ),
                    border: InputBorder.none
                  ),
                  onChanged: (value){
                     IdCardNumber= value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  children: <Widget>[
                    Text('证件照:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: ID_Photopick,
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
                new Row(
                  children: <Widget>[
                    Text('身份证正面照片:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: IDCard_1pick,
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
            new Row(
              children: <Widget>[
                Text('身份证反面照片:', style:TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 93, 93, 93),
                ),
                ),
                new Container(
                    margin: EdgeInsets.only(left: 30),
                    child:RaisedButton(
                      elevation: 0,
                      onPressed: IDCard_2pick,
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

                new Row(
                  children: <Widget>[
                    Text('医师资格证:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: zi_ge_zhengpick,
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
                new Row(
                  children: <Widget>[
                    Text('医师执业证:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: zhi_ye_zhengpick,
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
                new Row(
                  children: <Widget>[
                    Text('医师职称证书:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: zhi_chengpick,
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
                Divider(
                  thickness: 2,
                ),
                Container(
                  child:Text('专业特长:',style:TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),)),
                ),
                TextField(),
                Container(
                  child:Text('医师简介:',style:TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),)),
                ),
                TextField()
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