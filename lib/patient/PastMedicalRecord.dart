import 'package:flutter/material.dart';
import 'BottomNavigationBar.dart';
import 'dart:convert';
import 'PastMedicalRecordEdit.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/patient/login.dart';
import 'package:helloworld/showAlertDialogClass.dart';

void main() {
  runApp(new MaterialApp(
    title: "既往病史",
    home: new PastRecord(),
  ));
}



class WidgetBulld {
  int disease;

  WidgetBulld({int diseasenum = 0}) {
    // There's a better way to do this, stay tuned.
    this.disease = diseasenum;
  }

  Expanded create(String text, IconData icondata) {
    return Expanded(
        child: new Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(children: <Widget>[
                  new Stack(children: <Widget>[
                    SizedBox(
                        height: 67,
                        width: 67,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                side: BorderSide(width: 1.0)),
                            child: new Center(
                                child: Icon(
                              icondata,
                              size: 45,
                              color: Colors.black,
                            )))),
                  ]),
                  new Container(
                      child: Text(text,
                          textAlign: TextAlign.center,
                          //overflow:TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16)))
                ])));
  }
}

class PastRecord extends StatelessWidget {

  double heightnum = 120;
  WidgetBulld widgetbuild = new WidgetBulld();
  BottomNavigationBarClass Bottom_NavigationBar =
      new BottomNavigationBarClass();

  @override
  Widget build(BuildContext context) {
    void summit(int disease) async{
      var url = "http://101.133.228.14:8081/disease";
      String phone_num;
      int disease_type=disease;
      String disease_info;
      String token;
      SharedPreferenceUtil.containsKey('token').then((value) {

        if(value==false){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);}

      });
      SharedPreferenceUtil.getString('phoneNum').then((value){
        phone_num = value;
      });
      SharedPreferenceUtil.getString('token').then((value){
        token = value;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => pastMedicalRecordEdit())).then((value) {
        disease_info = value;
      });
      var bodymap = Map();
      var patientDiseaseInfo = Map();
      bodymap['phone_num'] = phone_num;
      bodymap['token'] = token;
      bodymap['patientDiseaseInfo'] = patientDiseaseInfo;
      patientDiseaseInfo['disease_type'] = disease_type;
      patientDiseaseInfo['disease_info'] = disease_info;
      await request(url, FormData: bodymap).then((value){
        Map data = json.decode(value.toString());
        if(data['result']==1){
          showAlertDialog(context,
              titleText: 'success', contentText: '上传成功');
        }else{
          showAlertDialog(context,
              titleText: 'failed', contentText: '上传失败');
        }
      });
    }
    return new Scaffold(
        //顶栏
        appBar: new AppBar(
          title:
              Text('既往病史', style: TextStyle(color: Colors.white, fontSize: 25)),
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: new Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
        ),

        //主题图标
        body: new ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              height: 800,
              width: 390,
              child: Card(
                elevation: 15.0, //阴影
                //设置圆角和边框
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    side: BorderSide(width: 1.0)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            InkWell(onTap: (){summit(1);}, child:widgetbuild.create("神经系统", Icons.receipt)),
                            InkWell(onTap: (){summit(2);}, child:widgetbuild.create("心血管系统", Icons.radio_button_checked)),
                            InkWell(onTap: (){summit(3);},child:widgetbuild.create("呼吸系统", Icons.colorize)),
                            InkWell(onTap: (){summit(4);},child:widgetbuild.create("消化系统", Icons.opacity)),
                          ])),
                      new Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(onTap: (){summit(5);},child:widgetbuild.create("内分泌代\n谢系统", Icons.data_usage)),
                              InkWell(onTap: (){summit(6);},child:widgetbuild.create("血液系统", Icons.favorite)),
                              InkWell(onTap: (){summit(7);},child:widgetbuild.create("泌尿系统", Icons.scatter_plot)),
                              InkWell(onTap: (){summit(8);},child:widgetbuild.create("男性生殖\n系统", Icons.accessibility)),
                            ]),
                      ),
                      new Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(onTap: (){summit(9);},child:widgetbuild.create("女性生殖\n系统", Icons.pregnant_woman)),
                              InkWell(onTap: (){summit(10);},child:widgetbuild.create("骨骼肌肉\n系统", Icons.account_balance)),
                              InkWell(onTap: (){summit(11);},child:widgetbuild.create("免疫系统", Icons.flare)),
                              InkWell(onTap: (){summit(12);},child:widgetbuild.create("眼科疾病", Icons.remove_red_eye)),
                            ]),
                      ),
                      new Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(onTap: (){summit(13);},child:widgetbuild.create("口腔牙齿\n疾病", Icons.fiber_smart_record)),
                              InkWell(onTap: (){summit(14);},child:widgetbuild.create("耳眼鼻喉头\n颈部疾病", Icons.hearing)),
                              InkWell(onTap: (){summit(15);},child:widgetbuild.create("皮肤病", Icons.directions_walk)),
                              InkWell(onTap: (){summit(16);},child:widgetbuild.create("外科疾病", Icons.hdr_weak)),
                            ]),
                      ),
                      new Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 22),
                        child: InkWell(onTap: (){summit(17);},child:widgetbuild.create("其他病史", Icons.bubble_chart)),
                      ),
                    ]),
              ),
            )
          ],
        ),
        //底栏
        bottomNavigationBar: Bottom_NavigationBar.Create());
  }
}
