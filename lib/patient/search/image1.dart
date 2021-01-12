import 'package:flutter/material.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:helloworld/patient/search/outPatients.dart';
import 'package:helloworld/patient/search/examine.dart';
import 'package:helloworld/patient/search/admission.dart';
import 'package:helloworld/patient/search/outPatientsRecords.dart';
import 'report2.dart';
import 'image2.dart';


class image1 extends StatefulWidget {
  image1({Key key, @required var list}): super(key:key){
    this.list = list;
  }

  @override
  _image1 createState() => new _image1(list: list);
  var list;
}

class _image1 extends State<image1> {
  _image1({@required var list}){
    this.list = list;
    print(list);
  }
  var list;

  Map labelmap = {
    '0': '无类目',
    '1': '超声检查',
    '2': 'X线或X线造影检查',
    '3': 'CT检查',
    '4': '磁共振（MRI）检查',
    '5': '同位素（核素）检查',
    '6': 'PET-CT检查',
    '7': '其他影像检查',
  };

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    List buildList(var list){
      print(list);
      List<Widget> buildedList = new List();
      for(Map map in list){
        Widget itemCard = InkWell(
          onTap: ()async{
            print(map);
            Navigator.push(context, MaterialPageRoute(builder: (context) => image2(id: map,)));
          },
          child: new Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            //宽度
            width: width_*0.95,
            // 盒子样式
            decoration: new BoxDecoration(
              //设置Border属性给容器添加边框
              border: new Border.all(
                //为边框添加颜色
                color: Colors.black12,
                width: 0.1, //边框宽度
              ),
            ),
            child: new Card(
              margin: EdgeInsets.only(top: 10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  new Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10,left: 20),
                    //宽度
                    width: width_*0.7,
                    child: new Column(
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('日期',style: new TextStyle(fontSize: 18,),),
                            Text(map['date']==null?'null':map['date'],style: new TextStyle(fontSize: 18,),),
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('检查类目',style: new TextStyle(fontSize: 18,),),
                            Text(labelmap[map['items']],style: new TextStyle(fontSize: 18,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 30,)
                ],
              ),
            ),
          ),
        );
        buildedList.add(itemCard);
      }
      return buildedList;
    }

    return Scaffold(
        appBar: new AppBar(
          title: Text(
            '影像检查',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
      body: ListView(
        children: buildList(list),
      )
    );
  }
}