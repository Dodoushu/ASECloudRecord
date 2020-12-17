import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helloworld/http_service.dart';
import 'BottomNavigationBar.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'Search_PatientList.dart';

void main() => runApp(MaterialApp(
      title: "患者查询",
      home: Search(),
    ));

class Search extends StatelessWidget {
  String name;
  String phone_num;
  String ID_num;
  String year;
  String month;
  String day;



            @override
            Widget build(BuildContext context) {
            void submit() async {
            var bodymap = Map();
            String userId;
            SharedPreferenceUtil.getString('doctorUserId')
                .then((value) async {
            userId = value;
            bodymap['userId'] = userId;
            Map watchPatientsInfo = new Map();
            watchPatientsInfo['name'] = name;
            watchPatientsInfo['id_num'] = ID_num;
            watchPatientsInfo['phone_num'] = phone_num;
            bodymap['watchPatientsInfo'] = watchPatientsInfo;
            var url =
            "http://39.100.100.198:8082/selectDAP";
            var formData = bodymap;
            print(bodymap);
            await request(url,context, FormData: formData)
                .then((value) {
            var data = json.decode(value.toString());
            log(data.toString());
            List datalist = data['patients'];
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search_PatientList(contentlist: datalist,)));

            List testData = [
            {
            'name':'zhangsan',
            'sex':0,
            'birthday':'1976-06-03',
            'phone_num':'12121314',
            'id':'123467'
            },
            {
            'name':'zhangsan',
            'sex':0,
            'birthday':'1976-06-03',
              'phone_num':'12121314',
              'id':'123467'
            },
            {
              'name':'zhangsan',
              'sex':0,
              'birthday':'1976-06-03',
              'phone_num':'12121314',
              'id':'123467'
            },
            {
              'name':'zhangsan',
              'sex':0,
              'birthday':'1976-06-03',
              'phone_num':'12121314',
              'id':'123467'
            },
          ];

//          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_PatientList(contentlist: testData,)));
        });
      });
    }

    Widget _DropdownButtonYear = new DropdownButton(
        items: [
          DropdownMenuItem(child: Text('2001')),
          DropdownMenuItem(child: Text('2002')),
          DropdownMenuItem(child: Text('2003'))
        ],
        onChanged: (value) {
          year = value;
        });
    Widget _DropdownButtonMonth = new DropdownButton(
        items: [
          DropdownMenuItem(child: Text('10')),
          DropdownMenuItem(child: Text('11')),
          DropdownMenuItem(child: Text('12'))
        ],
        onChanged: (value) {
          month = value;
        });
    Widget _DropdownButtonDay = new DropdownButton(
        items: [
          DropdownMenuItem(child: Text('1')),
          DropdownMenuItem(child: Text('2')),
          DropdownMenuItem(child: Text('3'))
        ],
        onChanged: (value) {
          day = value;
        });

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
                    '手机号',
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
                      phone_num = value;
                    },
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '身份证号',
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
                    ID_num = value;
                  },
                )
              ],
            ),
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text(
//                  '出生日期：',
//                  style: TextStyle(fontSize: 20),
//                ),
//                Row(
//                  children: <Widget>[
//                    new Container(
//                      padding: EdgeInsets.only(left: 10),
//                      child: _DropdownButtonYear,
//                    ),
//                    new Container(
//                      padding: EdgeInsets.only(left: 20),
//                      child: _DropdownButtonMonth,
//                    ),
//                    new Container(
//                      padding: EdgeInsets.only(left: 20),
//                      child: _DropdownButtonDay,
//                    )
//                  ],
//                )
//              ],
//            ),
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
          '患者查询',
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
