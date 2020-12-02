import 'package:flutter/material.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'package:helloworld/patient/pictureGridview.dart';
import 'dart:developer';

import 'laboratory1.dart';
import 'report1.dart';
import 'invasive1.dart';



void main() {
  runApp(new MaterialApp(
    title: '用户查询页面',
    home: new SearchPage('83'),
  ));
}

class WidgetBuild {
  Container create(String text, IconData icondata, Color truecolor,
      {double width = 350}) {
    return new Container(
        child: SizedBox(
          height: 60,
          width: width,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            color: Colors.white,
            child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: new Stack(
                  children: <Widget>[
                    new Align(
                      child: new Stack(children: <Widget>[
                        SizedBox(
                            height: 44,
                            width: 44,
                            child: Card(
                                color: truecolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100.0)),
                                ),
                                child: new Center(
                                    child: Icon(
                                      icondata,
                                      size: 28,
                                      color: Colors.white,
                                    )))),
                      ]),
                      alignment: Alignment.centerLeft,
                    ),
                    new Positioned(
                      child: new Text(text, style: TextStyle(fontSize: 18)),
                      top: 11,
                      left: 50,
                    ),
                    new Align(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      alignment: Alignment.centerRight,
                    )
                  ],
                )),
          ),
        ));
  }
}

class SearchPage extends StatelessWidget {

  SearchPage(this.patientId);

  String patientId;

  WidgetBuild _widgetBuild = new WidgetBuild();

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    Widget stack = new Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          width: double.infinity,
          height: 135,
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 20),
          padding: EdgeInsets.all(10),
          child: SizedBox(
              child: Container(
                  child: Card(
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        side: BorderSide(width: 1.0),
                      ),
                      child: new Container(
                        width: width_ * 0.93,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () async {

                                var bodymap = Map();
                                SharedPreferenceUtil.getString('userId')
                                    .then((value) async {
                                  bodymap['userId'] = patientId;
                                  print(bodymap);
                                  var url =
                                      "http://39.100.100.198:8082/Select/ReportPicture";
                                  var formData = bodymap;
                                  await request(url, context, FormData: formData).then((value) {
                                    var data = json.decode(value.toString());
                                    log(data.toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => report1(list: data['reports'],)));
                                  });
                                });
                              },
                              child: _widgetBuild.create(
                                  "健康体检报告图片查询", Icons.inbox, Colors.deepPurple),
                            ),
                            InkWell(
                                onTap: () async {
                                  var bodymap = Map();
                                  String phoneNum;
                                  SharedPreferenceUtil.getString('userId')
                                      .then((value) async {
                                    phoneNum = value;
                                    bodymap['userId'] = patientId;
                                    print(
                                        '*******************************************************');
                                    print(bodymap);
                                    var url =
                                        "http://39.100.100.198:8082/Select/DiseasePicture";
                                    var formData = bodymap;
                                    await request(url, context,
                                        FormData: formData)
                                        .then((value) {
                                      print(value);
                                      var data = json.decode(value.toString());
                                      var url = new List();
                                      for (var value
                                      in data['diseasePictures']) {
                                        url.addAll(value['address']);
//                                      log(value['address'].toString());
                                      }
                                      log(url.toString());
                                      var urls = List<String>();
                                      for (value in url) {
                                        urls.add('http://' + value.toString());
                                      }
//                                    print(data);
//                                    log(data['textInfo'].toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PictureView(
                                                urls: urls,
                                              )));
//                                    showAlertDialog(context,titleText: '',contentText: data['textInfo'][0]['address'].toString());
                                    });
                                  });
                                },
                                child: _widgetBuild.create("病症自拍照片查询",
                                    Icons.receipt, Colors.tealAccent)),
                            InkWell(
                                onTap: () async {

                                  var bodymap = Map();
                                  String phoneNum;
                                  SharedPreferenceUtil.getString('phoneNum')
                                      .then((value) async {
                                    var bodymap = Map();
                                    SharedPreferenceUtil.getString('userId')
                                        .then((value) async {
                                      bodymap['userId'] = patientId;
                                      print(bodymap);
                                      var url =
                                          "http://39.100.100.198:8082/Select/LaboratoryPicture";
                                      var formData = bodymap;
                                      await request(url, context, FormData: formData).then((value) {
                                        var data = json.decode(value.toString());
                                        log(data.toString());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => laboratory1(list: data['laboratoryPictures'],)));
                                      });
                                    });
                                  });
                                },
                                child: _widgetBuild.create(
                                    "化验检查图片查询", Icons.web, Colors.orange)),
                            InkWell(
                                onTap: () async {
                                  var bodymap = Map();
                                  String phoneNum;
                                  SharedPreferenceUtil.getString('userId')
                                      .then((value) async {
                                    phoneNum = value;
                                    bodymap['userId'] = patientId;
                                    print(
                                        '*******************************************************');
                                    print(bodymap);
                                    var url =
                                        "http://39.100.100.198:8082/Select/ImagePicture";
                                    var formData = bodymap;
                                    await request(url, context,
                                        FormData: formData)
                                        .then((value) {
                                      print(value);
                                      var data = json.decode(value.toString());
                                      var url = new List();
                                      for (var value in data['imagePictures']) {
                                        url.addAll(value['address']);
//                                      log(value['address'].toString());
                                      }
                                      log(url.toString());
                                      var urls = List<String>();
                                      for (value in url) {
                                        urls.add('http://' + value.toString());
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PictureView(
                                                urls: urls,
                                              )));
//                                    showAlertDialog(context,titleText: '',contentText: data['textInfo'][0]['address'].toString());
                                    });
                                  });
                                },
                                child: _widgetBuild.create("影像检查图片查询",
                                    Icons.accessible, Colors.brown)),
                            InkWell(
                                onTap: () async {

                                  var bodymap = Map();
                                  SharedPreferenceUtil.getString('userId')
                                      .then((value) async {
                                    bodymap['userId'] = patientId;
                                    print(bodymap);
                                    var url =
                                        "http://39.100.100.198:8082/Select/InstrumentPicture";
                                    var formData = bodymap;
                                    await request(url, context, FormData: formData).then((value) {
                                      var data = json.decode(value.toString());
                                      log(data.toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => invasive1(list: data['instrumentPictures'],)));
                                    });
                                  });
                                },
                                child: _widgetBuild.create("侵入型器械检查图片查询",
                                    Icons.description, Colors.lightGreen)),
                          ],
                        ),
                      )))),
        )
      ],
    );
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          '患者信息查询',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          stack,
        ],
      ),
    );
  }
}
