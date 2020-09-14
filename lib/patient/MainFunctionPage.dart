import 'package:flutter/material.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'BottomNavigationBar.dart';
import 'PastMedicalRecord.dart';

import 'upLoadInfo/hospitalizedRecord.dart';
import 'upLoadInfo/imageReview.dart';
import 'upLoadInfo/InvasiveReview.dart';
import 'upLoadInfo/LaboratoryExaminationPicture.dart';
import 'upLoadInfo/MedicalReport.dart';
import 'upLoadInfo/OutpatientMedical.dart';
import 'upLoadInfo/OutpatientVisitRecords.dart';
import 'upLoadInfo/pathology.dart';
import 'upLoadInfo/selfPortraitOfDisease.dart';
import 'User_Search.dart';

void main() {
  runApp(new MaterialApp(
    title: '患者主功能页',
    home: new MainPage(),
  ));
}

class WidgetBulld {
  Container create(String text, IconData icondata ,double width_ ) {
    return
      new Container(
          child: Column(children: <Widget>[
            new SizedBox(
                height: width_/5,
                width: width_/5,
                child: Card(
                    elevation: 15.0, //阴影
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        side: BorderSide(width: 1.0)),
                    child: new Container(
                        alignment: Alignment.center,
                        child: Icon(
                          icondata,
                          size: width_/8,
                          color: Colors.black,
                        )))),
            new Container(
                child: Text(
                  text,
                  style: TextStyle(fontSize: width_/25),
                ))
          ]));
  }
}


class MainPage extends StatefulWidget {
  @override
  State createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  //实例化
  WidgetBulld widgetbuild = new WidgetBulld();
//  BottomNavigationBarClass Bottom_NavigationBar = new BottomNavigationBarClass();
  String name;

  @override
  Widget build(BuildContext context) {

    double width_ = MediaQuery.of(context).size.width;

    List listTabs = [];
    //背景蓝框及第一个功能选择条
    Widget stack = new Stack(alignment: Alignment.topCenter, children: <Widget>[
      //蓝框
      Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        width: double.infinity,
        height: width_/2.9,
      ),
      //文字及功能框一
      Container(
        padding: EdgeInsets.all(width_/40),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.only(top: width_/20),
                  child: Text(' 尊敬的用户，您好',
//                 child: Text(name.toString() + '，您好',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width_/15,
                      ))),
              new Container(
                  padding: EdgeInsets.all(width_/65),
                  child: Text(
                    '健康是人生的第一财富',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width_/20,
                    ),
                  )),
              SizedBox(
                height: width_/2.6,
                child: Card(
                    elevation: 15.0, //阴影
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        side: BorderSide(width: 1.0)),
                    //设置圆角和边框
                    //设置内部两图标

                    child: new Container(
                      padding:  EdgeInsets.only(top: width_/25),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                  child: Column(children: <Widget>[
                                    new Stack(children: <Widget>[
                                      SizedBox(
                                          height: width_/4.5,
                                          width: width_/4.5,
                                          child: Card(
                                            elevation: 15.0, //阴影
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100.0)),
                                                side: BorderSide(width: 1.0)),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PastRecord()));
                                          },
                                          child: new Container(
//                                                alignment: Alignment.center,
                                              padding: EdgeInsets.all(width_/40),
                                              child: Icon(
                                                Icons.assignment_ind,
                                                size: width_/6,
                                                color: Colors.black,
                                              )))
                                    ]),
                                    new InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PastRecord()));
                                        },
                                        child: Container(
                                            child: Text(
                                              '既往病史填写',
                                              style: TextStyle(fontSize: width_/22),
                                            )))
                                  ])),
                            ),
                            new Expanded(
                              child: new Container(
                                  child: Column(children: <Widget>[
                                    new Stack(children: <Widget>[
                                      SizedBox(
                                          height: width_/4.6,
                                          width: width_/4.6,
                                          child: Card(
                                            elevation: 15.0, //阴影
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100.0)),
                                                side: BorderSide(width: 1.0)),
                                          )),
                                      InkWell(
                                          onTap: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchPage()));
                                          },
                                          child:new Container(
//                                                alignment: Alignment.center,
                                          padding: EdgeInsets.all(width_/40),
                                          child: Icon(
                                            Icons.search,
                                            size: width_/6,
                                            color: Colors.black,
                                          )))
                                    ]),
                                    InkWell(
                                        onTap: (){
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchPage()));
                                        },
                                        child:new Container(
                                        child: Text(
                                          '用户查询',
                                          style: TextStyle(fontSize: width_/22),
                                        )))
                                  ])),
                            )
                          ]),
                    )),
              )
            ]),
      ),
    ]);
    //跳转界面选择


    Widget ChooseModel_ = new Container(
      height: width_*1,
      child: FractionallySizedBox(
        widthFactor: 0.95,
        heightFactor: 1,
        child:  new Card(
          elevation: 15.0, //阴影
          //设置圆角和边框
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
              side: BorderSide(width: 1.0)),

          child: new Container(
            padding: EdgeInsets.only(top: width_/25),
            child: new GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0
              ),
              children: <Widget>[
                InkWell(
                  child: widgetbuild.create("体检报告", Icons.receipt,width_),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => medicalReport()));
                  },),
                InkWell(
                  child: widgetbuild.create("病症照片", Icons.pageview,width_),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => SelfPortraitOfDisease()));
                  },),
                InkWell(
                  child: widgetbuild.create("影像检查", Icons.perm_media,width_),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => ImageReview()));
                  },),
                InkWell(
                  child: widgetbuild.create("门诊病历", Icons.assignment,width_),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => outpatientMedical()));
                  },),
                InkWell(child: widgetbuild.create("门诊记录", Icons.account_balance_wallet,width_),
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (
                      context) => outpatientVisitRecords()));
                },),
                InkWell(child: widgetbuild.create("侵入型器械检查", Icons.edit,width_),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => invasiveReview()));
                  },),
                InkWell(child: widgetbuild.create("住院病历", Icons.redeem,width_),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => HospitalizedRecord()));
                  },),
                InkWell(child: widgetbuild.create("化验检查", Icons.flare,width_),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => laboratoryExaminationPicture()));
                  },),
                InkWell(child: widgetbuild.create("病理学检查", Icons.opacity,width_),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => Pathology()));
                  },)
              ],
            ),
          ),
        )

      ),
    );

    return new Scaffold(

      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //修改颜色
        ),
        title: Text(
          '主页',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
//        backgroundColor: Colors.white,
      ),
      body: new ListView(children: <Widget>[stack,ChooseModel_]),
    );}
}
