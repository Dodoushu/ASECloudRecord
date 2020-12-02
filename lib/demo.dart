import 'package:flutter/material.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/select.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'patient/setting/doctorSelect.dart';

void main() {
  runApp(new MaterialApp(
    title: '设置页',
    home: new doctorSelectFactor(),
  ));
}

List doctorlist = [];
List selectedDoctor = [];
List unSelectedDoctor = [];
bool onlyuser;

class doctorSelectFactor extends StatelessWidget{
  String name;
  String hospital;
  String department;

  @override
  Widget build(BuildContext context) {

    void getlist() async{
      SharedPreferenceUtil.getString('userId').then((value) async{
        String userId = value;
        String url = 'http://39.100.100.198:8082/selectAllDoctor';
        Map selectAll = new Map();
        Map doctor = new Map();
        doctor['name'] = '李四';
        doctor['hospital'] = null;
        doctor['department'] = null;
        selectAll['userId'] = userId;
        selectAll['doctor'] = doctor;
        request(url, context, FormData: selectAll).then((value){

          Map data = json.decode(value.toString());
          log(data.toString());
        });
      });
    }

    double width_ = MediaQuery.of(context).size.width;
    Widget selectFactor = new Center(
      child: new Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        //宽度
        width: width_*0.95,
        //高度
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                  decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    labelText: '姓名',
                    labelStyle: new TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
//                border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    name = value;
                  }
              ),
              TextField(
                  decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    labelText: '医院',
                    labelStyle: new TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
//                border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    hospital = value;
                  }
              ),
              TextField(
                  decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    labelText: '科室',
                    labelStyle: new TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
//                border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    department = value;
                  }
              )
            ],
          ),
        ),
      ),
    );

    Widget summit = new Container(
        height: 40.0,
        width: 200,
        margin: EdgeInsets.only(top:15,bottom: 15),
        child: new SizedBox.expand(
          child: new RaisedButton(
            elevation: 0,
            onPressed: getlist,
            color: Colors.blue,
            child: new Text(
              '查询',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
          ),
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '医生查询',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
//        backgroundColor: Colors.white,
      ),
      body: new Column(
        children: [selectFactor,summit],
      ),
    );
  }
}