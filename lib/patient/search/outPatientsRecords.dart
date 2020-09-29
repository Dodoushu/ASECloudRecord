import 'package:flutter/material.dart';
import 'package:helloworld/patient/MainFunctionPage.dart';
import 'package:helloworld/select.dart';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';


class outPatientRecords extends StatefulWidget {
  outPatientRecords({Key key, @required this.contentlist}) : super(key: key) {
    this.contentlist = contentlist;
  }

  List contentlist;

  @override
  _outPatientRecordsState createState() =>
      new _outPatientRecordsState(contentlist: contentlist);
}

class _outPatientRecordsState extends State<outPatientRecords> {
  _outPatientRecordsState({@required List contentlist}) {
    this.contentlist = contentlist;
  }

  List contentlist;

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    List<Widget> medicineListBuilder(List list){
      List<Widget> returnList = new List<Widget>();
      for (Map temp in list) {
        Widget contentCard = Container(
          child: new Card(
            child: Container(
              child: Column(
                children: <Widget>[
                  new Row(
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '药物名称：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['medicine_name'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '使用方法：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['medicine_method'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '使用频率：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['time'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),
        );
      }
    }


    List<Widget> contentCardBuilder() {
      List<Widget> returnList = new List<Widget>();
      for (Map temp in contentlist) {
        Widget contentCard = Container(
          padding: EdgeInsets.only(
            top: 7, bottom: 3
          ),
            child: new Card(
              margin: EdgeInsets.only(
                right: width_ * 0.03,
                left: width_ * 0.03,
              ),
              child: Container(
                  margin: EdgeInsets.only(
                    right: width_ * 0.03,
                    left: width_ * 0.03,
                      top: 15,
                      bottom: 15
                  ),
                  child: Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '检查日期：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['date'].substring(0, 10),
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '就诊科室：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['department_treatment'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '就诊医院：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['hospital']!=null? temp['hospital'] : '无',
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '医生姓名：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['doctor_name'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '诊断内容：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['treat_info']!=null? temp['treat_info'] : '无',
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '就诊内容：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['treating_info']!=null? temp['treating_info'] : '无',
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '检查项目：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['treat_items']!=null? temp['treat_items'] : '无',
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '非药物治疗方案：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['treat_methods']!=null? temp['treat_methods'] : '无',
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '用药方案：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            '',
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Container(
                        padding: EdgeInsets.only(right: 10,left: 10),
                        child: Column(
                          children: medicineListBuilder(temp['medicines'])!=null?medicineListBuilder(temp['medicines']) : <Widget>[    new Text('无',
                                style: new TextStyle(
                                  fontSize: 18,
                                ),

                              )],
                        ),
                      )
                    ],
                  )),
            ));
        returnList.add(contentCard);
      }
      return returnList;
    }

//    Widget contentCard = new Container(
//      width: width_*0.95,
//      child: new Column(
//        children: contentCardBuilder(),
//      ),
//    );

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          '门诊病历查询',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: new ListView(
        children: contentCardBuilder(),
      ),
    );
  }
}
