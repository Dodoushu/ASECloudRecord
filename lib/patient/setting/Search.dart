import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helloworld/http_service.dart';

import 'package:flutter/material.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'ChangePassword.dart';
import 'ChangePhoneNumber.dart';
import 'doctorSelect.dart';
import 'package:helloworld/login.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:helloworld/sharedPrefrences.dart';


void main() => runApp(MaterialApp(
      title: "医生查询",
      home: Search(),
    ));

class Search extends StatelessWidget {
  String name = null;
  String hospital = null;
  String department = null;


  List doctorlist = [];
  List selectedDoctor = [];
  List unSelectedDoctor = [];
  bool onlyuser;





  @override
  Widget build(BuildContext context) {

    void getlist() async{

    }


    void submit() async {
      SharedPreferenceUtil.getString('userId').then((value) async{
        Map<String, dynamic> data = Map();
        var url = "http://39.100.100.198:8082/selectAllDoctor";
        Map<String, dynamic> doctor = Map();
        data['userId'] = value;
        doctor['name'] = name;
        doctor['hospital'] = hospital;
        doctor['department'] = department;
        data['doctor'] = doctor;
        var formData = data;
        print(data);
        await request(url,context, FormData: formData).then((value) {
          Map data = json.decode(value.toString());
//          log('response:' + data.toString());
          List selectedList = new List();
          if(data['selected_doctor_id']!=null){
            for(int id in data['selected_doctor_id']){
              selectedList.add(id);
            }
          }

          doctorlist.clear();
          selectedDoctor.clear();
          unSelectedDoctor.clear();

          for(Map temp in data['doctors']){

            Map doctor = {};
            doctor['id'] = temp['id'];
            doctor['name'] = temp['name'];
            doctor['info'] = temp['id_num'];
            doctor['hospital'] = temp['hospital'];
            doctor['department'] = temp['department'];
            doctor['pictureAddress'] = temp['address']==null? temp['address']:null;

            if(selectedList.contains(temp['id'])){
              doctor['select'] = true;
              selectedDoctor.add(doctor);
            }else{
              doctor['select'] = false;
              unSelectedDoctor.add(doctor);
            }
            doctorlist.add(doctor);
          }
          if(selectedDoctor.length == 0){
            onlyuser = true;
          }else{
            onlyuser = false;
          }

          print(selectedDoctor);
//
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return new doctorSelect(onlyuser: onlyuser, doctorlist: doctorlist, selectedDoctor: selectedDoctor, unSelectedDoctor: unSelectedDoctor);
          }));

        });
      });
    }

    Widget PatientInfo = new Container(
      padding: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: <Widget>[
            new Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '姓名',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextField(
                    decoration: new InputDecoration(
                      labelStyle: new TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 93, 93, 93),
                      ),
                      //border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                  )
                ],
              ),
            ),
            new Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '医院',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextField(
                    decoration: new InputDecoration(
                      labelStyle: new TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 93, 93, 93),
                      ), //border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      hospital = value;
                    },
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '科室',
                  style: TextStyle(fontSize: 20),
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelStyle: new TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ), //border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    department = value;
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );

    Widget ok = new Container(
      height: 50,
      margin: EdgeInsets.all(30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          onPressed: submit,
          elevation: 0,
          color: Colors.blue,
          child: new Text(
            '查询',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
          //onPressed:,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '查询',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: ListView(
        children: <Widget>[
          PatientInfo,
          ok,
        ],
      ),
    );
  }
}
