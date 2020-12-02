import 'package:flutter/material.dart';
import 'package:helloworld/patient/search/invasive1.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'pictureGridview.dart';
import 'dart:developer';
import 'package:helloworld/patient/search/outPatients.dart';
import 'package:helloworld/patient/search/examine.dart';
import 'package:helloworld/patient/search/admission.dart';
import 'package:helloworld/patient/search/outPatientsRecords.dart';

import 'search/report1.dart';
import 'search/laboratory1.dart';

void main() {
  runApp(new MaterialApp(
    title: '用户查询页面',
    home: new SearchPage(),
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
//              height: 460,

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
                            SizedBox(
                              height: width_ / 2.6,
                              child: Container(
//                                  elevation: 15.0, //阴影
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
//                                      side: BorderSide(width: 1.0)
//                                  ),
                                  //设置圆角和边框
                                  //设置内部两图标

                                  child: new Container(
                                padding: EdgeInsets.only(top: width_ / 25),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                          child: new InkWell(
                                        onTap: () async {
                                          var bodymap = Map();
                                          String phoneNum;
                                          SharedPreferenceUtil.getString('userId').then((value) async {
                                            phoneNum = value;
                                            bodymap['userId'] = phoneNum;
                                            print(
                                                '*******************************************************');
                                            print(bodymap);
                                            var url =
                                                "http://39.100.100.198:8082/Select/outPatientRecords";
                                            var formData = bodymap;
                                            await request(url, context,
                                                    FormData: formData)
                                                .then((value) {
                                              var data =
                                                  json.decode(value.toString());
                                              log(data['outPatientRecords']
                                                  .toString());

                                              var url = new List();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          outPatientRecords(
                                                            contentlist: data[
                                                                'outPatientRecords'],
                                                          )));
                                            });
                                          });
                                        },
                                        child: new Container(
                                            child: Column(children: <Widget>[
                                          new Stack(children: <Widget>[
                                            SizedBox(
                                                height: width_ / 4.5,
                                                width: width_ / 4.5,
                                                child: Card(
                                                  elevation: 15.0, //阴影
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  100.0)),
                                                      side: BorderSide(
                                                          width: 1.0)),
                                                )),
                                            InkWell(
                                                child: new Container(
//                                                alignment: Alignment.center,
                                                    padding: EdgeInsets.all(
                                                        width_ / 35),
                                                    child: Icon(
                                                      Icons.record_voice_over,
                                                      size: (width_ / 6) * 0.98,
                                                      color: Colors.pink,
                                                    )))
                                          ]),
                                          new InkWell(
                                              child: Container(
                                                  child: Text(
                                            '门诊病历查询',
                                            style: TextStyle(
                                                fontSize: width_ / 22),
                                          )))
                                        ])),
                                      )),
                                      new Expanded(
                                          child: InkWell(
                                        onTap: () async {
                                          var bodymap = Map();
                                          String phoneNum;
                                          SharedPreferenceUtil.getString(
                                                  'userId')
                                              .then((value) async {
                                            phoneNum = value;
                                            bodymap['userId'] = phoneNum;
                                            print(
                                                '*******************************************************');
                                            print(bodymap);
                                            var url =
                                                "http://39.100.100.198:8082/Select/AllPicture";
                                            var formData = bodymap;
                                            await request(url, context,
                                                    FormData: formData)
                                                .then((value) {
                                              var data =
                                                  json.decode(value.toString());
                                              var url = new List();
                                              for (var value
                                                  in data['textInfo']) {
                                                url.addAll(value['address']);
//                                      log(value['address'].toString());
                                              }
                                              for (var value
                                                  in data['diseasePictures']) {
                                                url.addAll(value['address']);
//                                      log(value['address'].toString());
                                              }
                                              for (var value in data[
                                                  'laboratoryPictures']) {
                                                url.addAll(value['address']);
//                                      log(value['address'].toString());
                                              }
                                              for (var value
                                                  in data['imagePictures']) {
                                                url.addAll(value['address']);
//                                      log(value['address'].toString());
                                              }
                                              for (var value in data[
                                                  'instrumentPictures']) {
                                                url.addAll(value['address']);
//                                      log(value['address'].toString());
                                              }
                                              log(url.toString());
                                              var urls = List<String>();
                                              for (value in url) {
                                                urls.add('http://' +
                                                    value.toString());
                                              }
//                                    print(data);
//                                    log(data['textInfo'].toString());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PictureView(
                                                            urls: urls,
                                                          )));
//                                    showAlertDialog(context,titleText: '',contentText: data['textInfo'][0]['address'].toString());
                                            });
                                          });
                                        },
                                        child: new Container(
                                            child: Column(children: <Widget>[
                                          new Stack(children: <Widget>[
                                            SizedBox(
                                                height: width_ / 4.6,
                                                width: width_ / 4.6,
                                                child: Card(
                                                  elevation: 15.0, //阴影
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  100.0)),
                                                      side: BorderSide(
                                                          width: 1.0)),
                                                )),
                                            Container(
                                                child: new Container(
//                                                alignment: Alignment.center,
                                                    padding: EdgeInsets.all(
                                                        width_ / 40),
                                                    child: Icon(
                                                      Icons.photo_library,
                                                      size: width_ / 6,
                                                      color: Colors.amberAccent,
                                                    )))
                                          ]),
                                          Container(
                                              child: new Container(
                                                  child: Text(
                                            '全部图片浏览',
                                            style: TextStyle(
                                                fontSize: width_ / 22),
                                          )))
                                        ])),
                                      ))
                                    ]),
                              )),
                            ),
                            new Divider(),



//                            InkWell(
//                              onTap: () async {
//                                var bodymap = Map();
//                                String phoneNum;
//                                SharedPreferenceUtil.getString('phoneNum')
//                                    .then((value) async {
//                                  phoneNum = value;
////                                  bodymap['phone_num'] = phoneNum;
//                                  bodymap['phone_num'] = '12121314';
//                                  print(
//                                      '*******************************************************');
//                                  print(bodymap);
//                                  var url =
//                                      "http://39.100.100.198:8082/Select/outPatientRecords";
//                                  var formData = bodymap;
//                                  await request(url, context,
//                                          FormData: formData)
//                                      .then((value) {
//                                    var data = json.decode(value.toString());
//                                    log(data['outPatientRecords'].toString());
//
//                                    var url = new List();
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                            builder: (context) =>
//                                                outPatientRecords(
//                                                  contentlist:
//                                                      data['outPatientRecords'],
//                                                )));
//                                  });
//                                });
//                              },
//                              child: _widgetBuild.create(
//                                  '门诊记录查询',
//                                  Icons.record_voice_over,
//                                  Colors.deepPurpleAccent),
//                            ),
//                            InkWell(
//                              onTap: () async {
//                                var bodymap = Map();
//                                String phoneNum;
//                                SharedPreferenceUtil.getString('phoneNum')
//                                    .then((value) async {
//                                  phoneNum = value;
//                                  bodymap['phone_num'] = phoneNum;
//                                  print(
//                                      '*******************************************************');
//                                  print(bodymap);
//                                  var url =
//                                      "http://39.100.100.198:8082/Select/AllPicture";
//                                  var formData = bodymap;
//                                  await request(url, context,
//                                          FormData: formData)
//                                      .then((value) {
//                                    var data = json.decode(value.toString());
//                                    var url = new List();
//                                    for (var value in data['textInfo']) {
//                                      url.addAll(value['address']);
////                                      log(value['address'].toString());
//                                    }
//                                    for (var value in data['diseasePictures']) {
//                                      url.addAll(value['address']);
////                                      log(value['address'].toString());
//                                    }
//                                    for (var value
//                                        in data['laboratoryPictures']) {
//                                      url.addAll(value['address']);
////                                      log(value['address'].toString());
//                                    }
//                                    for (var value in data['imagePictures']) {
//                                      url.addAll(value['address']);
////                                      log(value['address'].toString());
//                                    }
//                                    for (var value
//                                        in data['instrumentPictures']) {
//                                      url.addAll(value['address']);
////                                      log(value['address'].toString());
//                                    }
//                                    log(url.toString());
//                                    var urls = List<String>();
//                                    for (value in url) {
//                                      urls.add('http://' + value.toString());
//                                    }
////                                    print(data);
////                                    log(data['textInfo'].toString());
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                            builder: (context) => PictureView(
//                                                  urls: urls,
//                                                )));
////                                    showAlertDialog(context,titleText: '',contentText: data['textInfo'][0]['address'].toString());
//                                  });
//                                });
//                              },
//                              child: _widgetBuild.create("全部图片浏览",
//                                  Icons.photo_library, Colors.amberAccent),
//                            ),



                            InkWell(
                              onTap: () async {

                                var bodymap = Map();
                                SharedPreferenceUtil.getString('userId')
                                    .then((value) async {
                                  bodymap['userId'] = value;
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




//                                var bodymap = Map();
//                                String phoneNum;
//                                SharedPreferenceUtil.getString('phoneNum')
//                                    .then((value) async {
//                                  phoneNum = value;
//                                  bodymap['phone_num'] = phoneNum;
//                                  print(
//                                      '*******************************************************');
//                                  print(bodymap);
//                                  var url =
//                                      "http://39.100.100.198:8082/Select/ReportPicture";
//                                  var formData = bodymap;
//                                  await request(url, context,
//                                          FormData: formData)
//                                      .then((value) {
//                                    print(value);
//                                    var data = json.decode(value.toString());
//                                    var url = new List();
//                                    for (var value in data['textInfo']) {
//                                      url.addAll(value['address']);
////                                      log(value['address'].toString());
//                                    }
//                                    log(url.toString());
//                                    var urls = List<String>();
//                                    for (value in url) {
//                                      urls.add('http://' + value.toString());
//                                    }
////                                    print(data);
////                                    log(data['textInfo'].toString());
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                            builder: (context) => PictureView(
//                                                  urls: urls,
//                                                )));
////                                    showAlertDialog(context,titleText: '',contentText: data['textInfo'][0]['address'].toString());
//                                  });
//                                });
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
                                    bodymap['userId'] = phoneNum;
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
                                      bodymap['userId'] = value;
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

//                                    phoneNum = value;
//                                    bodymap['phone_num'] = phoneNum;
//                                    print(
//                                        '*******************************************************');
//                                    print(bodymap);
//                                    var url =
//                                        "http://39.100.100.198:8082/Select/LaboratoryPicture";
//                                    var formData = bodymap;
//                                    await request(url, context,
//                                            FormData: formData)
//                                        .then((value) {
//                                      print(value);
//                                      var data = json.decode(value.toString());
//                                      var url = new List();
//                                      for (var value
//                                          in data['laboratoryPictures']) {
//                                        url.addAll(value['address']);
////                                      log(value['address'].toString());
//                                      }
//                                      log(url.toString());
//                                      var urls = List<String>();
//                                      for (value in url) {
//                                        urls.add('http://' + value.toString());
//                                      }
////                                    print(data);
////                                    log(data['textInfo'].toString());
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) => PictureView(
//                                                    urls: urls,
//                                                  )));
////                                    showAlertDialog(context,titleText: '',contentText: data['textInfo'][0]['address'].toString());
//                                    });
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
                                    bodymap['userId'] = phoneNum;
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
                                child: _widgetBuild.create("影像检查图片查询",
                                    Icons.accessible, Colors.brown)),
                            InkWell(
                                onTap: () async {

                                  var bodymap = Map();
                                  SharedPreferenceUtil.getString('userId')
                                      .then((value) async {
                                    bodymap['userId'] = value;
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


//                                  var bodymap = Map();
//                                  String phoneNum;
//                                  SharedPreferenceUtil.getString('phoneNum')
//                                      .then((value) async {
//                                    phoneNum = value;
//                                    bodymap['phone_num'] = phoneNum;
//                                    print(
//                                        '*******************************************************');
//                                    print(bodymap);
//                                    var url =
//                                        "http://39.100.100.198:8082/Select/InstrumentPicture";
//                                    var formData = bodymap;
//                                    await request(url, context,
//                                            FormData: formData)
//                                        .then((value) {
//                                      print(value);
//                                      var data = json.decode(value.toString());
//                                      var url = new List();
//                                      for (var value
//                                          in data['instrumentPictures']) {
//                                        url.addAll(value['address']);
////                                      log(value['address'].toString());
//                                      }
//                                      log(url.toString());
//                                      var urls = List<String>();
//                                      for (value in url) {
//                                        urls.add('http://' + value.toString());
//                                      }
////                                    print(data);
////                                    log(data['textInfo'].toString());
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) => PictureView(
//                                                    urls: urls,
//                                                  )));
////                                    showAlertDialog(context,titleText: '',contentText: data['textInfo'][0]['address'].toString());
//                                    });
//                                  });
                                },
                                child: _widgetBuild.create("侵入型器械检查图片查询",
                                    Icons.description, Colors.lightGreen)),
                            InkWell(
                              onTap: () async {
                                var bodymap = Map();
                                String phoneNum;
                                SharedPreferenceUtil.getString('userId')
                                    .then((value) async {
                                  phoneNum = value;
                                  bodymap['userId'] = phoneNum;
                                  print(
                                      '*******************************************************');
                                  print(bodymap);
                                  var url =
                                      "http://39.100.100.198:8082/Select/admission";
                                  var formData = bodymap;
                                  await request(url, context,
                                          FormData: formData)
                                      .then((value) {
                                    var data = json.decode(value.toString());
                                    print(data['admissionNotes']);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => admission(
                                                  contentlist:
                                                      data['admissionNotes'],
                                                )));
                                  });
                                });
                              },
                              child: _widgetBuild.create(
                                  '住院病历查询', Icons.local_hospital, Colors.red),
                            ),
                            InkWell(
                              onTap: () async {
                                var bodymap = Map();
                                String phoneNum;
                                SharedPreferenceUtil.getString('userId')
                                    .then((value) async {
                                  phoneNum = value;
                                  bodymap['userId'] = phoneNum;
                                  print(
                                      '*******************************************************');
                                  print(bodymap);
                                  var url =
                                      "http://39.100.100.198:8082/Select/examine";
                                  var formData = bodymap;
                                  await request(url, context,
                                          FormData: formData)
                                      .then((value) {
                                    var data = json.decode(value.toString());
                                    print(data['examines']);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => examine(
                                                  contentlist: data['examines'],
                                                )));
                                  });
                                });
                              },
                              child: _widgetBuild.create('病理学检查查询',
                                  Icons.bookmark_border, Colors.black45),
                            ),
                            InkWell(
                              onTap: () async {
                                var bodymap = Map();
                                String phoneNum;
                                SharedPreferenceUtil.getString('userId')
                                    .then((value) async {
                                  phoneNum = value;
                                  bodymap['userId'] = phoneNum;
                                  print(
                                      '*******************************************************');
                                  print(bodymap);
                                  var url =
                                      "http://39.100.100.198:8082/Select/outPatient";
                                  var formData = bodymap;
                                  await request(url, context,
                                          FormData: formData)
                                      .then((value) {
                                    var data = json.decode(value.toString());
                                    log(data['outPatients'].toString());

                                    var url = new List();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => outPatients(
                                                  contentlist:
                                                      data['outPatients'],
                                                )));
                                  });
                                });
                              },
                              child: _widgetBuild.create(
                                  '门诊信息查询', Icons.assistant, Colors.pinkAccent),
                            ),
                          ],
                        ),
                      )))),
        )
      ],
    );
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          '用户查询',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
//        backgroundColor: Colors.blue,
//        leading: Icon(Icons.arrow_back_ios,size: 25,),
      ),
      body: new ListView(
        children: <Widget>[
          stack,
        ],
      ),
    );
  }
}
