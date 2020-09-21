import 'package:flutter/material.dart';
import 'package:helloworld/patient/MainFunctionPage.dart';
import 'package:helloworld/select.dart';

void main() {
  runApp(MaterialApp(
    home: doctorSelect(),
  ));
}

class doctorSelect extends StatefulWidget {
  @override
  _doctorSelectState createState() => new _doctorSelectState();
}

class _doctorSelectState extends State<doctorSelect> {
  bool onlyuser = true;
  List<bool> valueList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  String switchContent() {
    if (onlyuser == true) {
      return '仅自己可见';
    } else {
      return '选中医生可见';
    }
  }

  var doctorlist = [
    {'id': 0, 'name': '张一', 'info': '其他信息', 'select': true},
    {'id': 1, 'name': '张二', 'info': '其他信息', 'select': false},
    {'id': 2, 'name': '张三', 'info': '其他信息', 'select': false},
    {'id': 3, 'name': '张四', 'info': '其他信息', 'select': true},
    {'id': 4, 'name': '张五', 'info': '其他信息', 'select': false},
    {'id': 5, 'name': '张六', 'info': '其他信息', 'select': true},
    {'id': 6, 'name': '张七', 'info': '其他信息', 'select': false}
  ];

  var selectedDoctor = [
    {'id': 0, 'name': '张一', 'info': '其他信息', 'select': true},
    {'id': 3, 'name': '张四', 'info': '其他信息', 'select': true},
    {'id': 5, 'name': '张六', 'info': '其他信息', 'select': true},
  ];

  var unSelectedDoctor = [
    {'id': 1, 'name': '张二', 'info': '其他信息', 'select': false},
    {'id': 2, 'name': '张三', 'info': '其他信息', 'select': false},
    {'id': 4, 'name': '张五', 'info': '其他信息', 'select': false},
    {'id': 6, 'name': '张七', 'info': '其他信息', 'select': false}
  ];

  @override
  Widget build(BuildContext context) {

    Column buildSelectedCheckboxListTile() {
      var CheckoxListTitleList = List<CheckboxListTile>();
      if (onlyuser == false) {
        for (Map obj in selectedDoctor) {
          CheckoxListTitleList.add(new CheckboxListTile(
            secondary: const Icon(Icons.accessible_forward),
            title: Text(obj['name']),
            subtitle: Text(obj['info']),
            value: obj['select'],
            onChanged: (bool value) {
              setState(() {
                int i = 0;
                for (Map temp in selectedDoctor) {
                  if (temp['id'] == obj['id']) {
                    break;
                  } else {
                    i++;
                  }
                }
                Map tempDoctor = new Map();
                tempDoctor = selectedDoctor[i];
                tempDoctor['select'] = false;
                selectedDoctor.removeAt(i);
                unSelectedDoctor.add(tempDoctor);
                unSelectedDoctor.sort((a, b) =>
                    (a['id'].toString()).compareTo((b['id'].toString())));
              });
            },
          ));
        }
      }
      return Column(children: CheckoxListTitleList,);
    }

    Column buildUnSelectedCheckboxListTile() {
      var CheckoxListTitleList = List<CheckboxListTile>();
      if (onlyuser == false) {
        for (Map obj in unSelectedDoctor) {
          CheckoxListTitleList.add(new CheckboxListTile(
            secondary: const Icon(Icons.accessible_forward),
            title: Text(obj['name']),
            subtitle: Text(obj['info']),
            value: obj['select'],
            onChanged: (bool value) {
              setState(() {
                int i = 0;
                for (Map temp in unSelectedDoctor) {
                  if (temp['id'] == obj['id']) {
                    break;
                  } else {
                    i++;
                  }
                }
                Map tempDoctor = new Map();
                tempDoctor = unSelectedDoctor[i];
                tempDoctor['select'] = true;
                unSelectedDoctor.removeAt(i);
                selectedDoctor.add(tempDoctor);
                selectedDoctor.sort((a, b) =>
                    (a['id'].toString()).compareTo((b['id'].toString())));
              });
            },
          ));
        }
      }
      return Column(children: CheckoxListTitleList,);
    }

    Container text1(){
      if(onlyuser == false&&selectedDoctor.isNotEmpty){
        return new Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text('已选中：')],
        ),);
      }
    }

    Container text2(){
      if(onlyuser == false&&unSelectedDoctor.isNotEmpty){
        return new Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text('未选中：')],
          ),);
      }
    }

    Widget ChangeDoctor = new Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 5),
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  side: BorderSide(width: 0.5)),
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                    EdgeInsets.only(right: 16, left: 24, top: 4, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          switchContent(),
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
//                secondary: const Icon(Icons.accessible_forward),
//                title: Text(switchContent()),
                          value: onlyuser,
                          onChanged: (bool value) {
                            setState(() {
                              onlyuser = value;
                            });
                            print(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  new Container(
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Container(
//                          padding: EdgeInsets.only(left: 230),
//                          child: new Icon(
//                            Icons.arrow_forward_ios,
//                            size: 26,
//                          ),
                                ),
                              ]))),
                  Container(child:text1()),
                  Container(
                    child: buildSelectedCheckboxListTile(),
                  ),
                  new Container(
                      height: 40.0,
                      width: 200,
                      margin: EdgeInsets.only(top:15,bottom: 15),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                          elevation: 0,
                          onPressed: (){
                            print(selectedDoctor.isNotEmpty);
//                      for(Map obj in selectedDoctor){
//                        print(obj['id']);
//                      };
                          },
                          color: Colors.blue,
                          child: new Text(
                            '提交',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                        ),
                      )
                  ),
                  Container(child:text2()),
                  Container(
                    child: buildUnSelectedCheckboxListTile(),
                  ),
                ],
              ),
            )
          ],
        ));

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          '选择医生',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
//        backgroundColor: Colors.blue,
//        leading: new Icon(Icons.arrow_back_ios,size: 25,),
      ),
      body: new ListView(
        children: <Widget>[ChangeDoctor],
      ),
    );
  }
}
