import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/PickFileMethod.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:intl/intl.dart';

import 'package:helloworld/globalUtils.dart';


class outPatientDetailed extends StatefulWidget {
  outPatientDetailed({Key key, @required var id}): super(key:key){
    this.id = id;
  }
  var id;

  @override
  State createState() => new _outPatientDetailed(id: id);
}

class _outPatientDetailed extends State<outPatientDetailed> {

  _outPatientDetailed({@required var id}){
    this.id = id;
    print(id);
  }
  var id;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    List<Widget> buildList(){

      List<Widget> returnlist = new List();

      Widget basicInfo = Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Container(
          child: Column(
            children: <Widget>[
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '日期:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(
                      id['date'],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '医院:',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        id['hospital'],
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '就诊科室:',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        id['department'],
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '医生姓名:',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        id['doctor_name'],
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '病例内容:',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        id['disease_info'],
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '附带图片:',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  smallPicGridViewNet(id['address'])
                ],
              )
            ],
          ),
        ),
      );

      returnlist.add(basicInfo);
      return returnlist;

    }

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
                    '体检记录',
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
//              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: buildList(),
              ),
            )
          ],
        ));
  }
}
