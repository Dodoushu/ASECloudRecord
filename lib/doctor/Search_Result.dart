import 'package:flutter/material.dart';

void main()=> runApp(new SearchResult());

class SearchResult extends StatefulWidget{
  @override
  _SearchResult createState()  => new _SearchResult();
}
class _SearchResult extends State<SearchResult> {


  List PatientData = [
    {
      "hospital":'414医院',
      "date":'2020年6月12日',
      "room":'脑科',
      "doctor_name":'宋医生',
      "judge":'两肺上陈旧性肺结核,病变部大部分纤维化及钙化;与前片比较,病变部略有吸收',
    },
    {
      "hospital":'833医院',
      "date":'2020年5月10日',
      "room":'神经内科',
      "doctor_name":'宋医生',
      "judge":'两肺上陈旧性肺结核,病变部大部分纤维化及钙化;',
    },
  ];


  @override
  Widget build(BuildContext context) {
      Widget PersonalInfo = new Container(
        margin: EdgeInsets.all(20),
          child:SizedBox(
              height: 250,
              child: new Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                  ),
                color: Colors.white,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      child: Text('患者基础信息',style: TextStyle(fontSize: 20),),
                      padding: EdgeInsets.all(12),
                    ),
                    new Row(
                      children: <Widget> [
                        new Container(
                          child: Text(
                            '姓名:',
                          ),
                          padding: EdgeInsets.only(left: 12),
                        ),
                        new Container(
                          child: Text(
                            '张三'
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    new Row(
                      children: <Widget> [
                        new Container(
                          child: Text(
                            '性别:',
                          ),
                          padding: EdgeInsets.only(left: 12),
                        ),
                        new Container(
                          child: Text(
                              '男'
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    new Row(
                      children: <Widget> [
                        new Container(
                          child: Text(
                            '民族:',
                          ),
                          padding: EdgeInsets.only(left: 12),
                        ),
                        new Container(
                          child: Text(
                              '汉族'
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    new Row(
                      children: <Widget> [
                        new Container(
                          child: Text(
                            '出生地:',
                          ),
                          padding: EdgeInsets.only(left: 12),
                        ),
                        new Container(
                          child: Text(
                              '陕西省西安市'
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    new Row(
                      children: <Widget> [
                        new Container(
                          child: Text(
                            '身份证号:',
                          ),
                          padding: EdgeInsets.only(left: 12),
                        ),
                        new Container(
                          child: Text(
                              '1234454676767667'
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                  ],
                )
              )
          ),
      );
      Widget PastMedicalInfo(context,index) {
        return new Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: new SizedBox(
            height: 160,
            child: new Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28.0)),
        ),
              child:new Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Container(
                        child:Column(
                          children: <Widget>[
                            new Container(
                                child:Text(PatientData[index]["hospital"],style: TextStyle(fontSize: 20),)
                            ),
                            new Container(
                                child:Text(PatientData[index]["date"],style: TextStyle(fontSize: 20),)
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(right: 40),
                      ),
                        Column(
                          children: <Widget>[
                            new Container(
                                child:Text(PatientData[index]["room"],style: TextStyle(fontSize: 20),)
                            ),
                            new Container(
                                child:Text(PatientData[index]["doctor_name"],style: TextStyle(fontSize: 20),)
                            )
                          ],
                        )
                    ],

                  ),
                  new Container(
                      child:Text('诊断：'+PatientData[index]["judge"],style: TextStyle(fontSize: 20),)
                  )
                ],

              )
        ),
        ),
        );
      }
      return new MaterialApp(
        title: '患者查询结果',
        home: new Scaffold(
          appBar: new AppBar(
            title: Text(
              '患者信息查询结果',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: new Icon(Icons.arrow_back_ios,size: 25,),
          ),
          body: ListView(
            children: <Widget>[
              PersonalInfo,
              new Container(
                child: Text('患者过往诊疗信息',style: TextStyle(fontSize: 20),),
                margin: EdgeInsets.only(left: 30),
              ),
              ListView.builder(
                itemCount: PatientData.length,
                itemBuilder: PastMedicalInfo,
                  shrinkWrap: true   //不添加这一句简单使用ListView会报错，原因未知
              ),
            ],
          )
        ),
      );
  }

}