import 'package:flutter/material.dart';
import 'package:helloworld/patient/MainFunctionPage.dart';

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

  @override
  Widget build(BuildContext context) {
    List<Widget> buildCheckboxListTile() {
      var doctorlist = [
        {'id': 0, 'name': '张一', 'info': '其他信息'},
        {'id': 1, 'name': '张二', 'info': '其他信息'},
        {'id': 2, 'name': '张三', 'info': '其他信息'},
        {'id': 3, 'name': '张四', 'info': '其他信息'},
        {'id': 4, 'name': '张五', 'info': '其他信息'},
        {'id': 5, 'name': '张六', 'info': '其他信息'},
        {'id': 6, 'name': '张七', 'info': '其他信息'}
      ];

      var CheckoxListTitleList = List<CheckboxListTile>();
//      CheckoxListTitleList.add(CheckboxListTile(
//        secondary: const Icon(Icons.accessible_forward),
//        title: Text(switchContent()),
//        value: onlyuser,
//        onChanged: (bool value) {
//          setState(() {
//            onlyuser=value;
//          });
//          print(value);
//        },
//      ));
      if (onlyuser == false) {
        int i = 0;
        for (Map obj in doctorlist) {
          CheckoxListTitleList.add(new CheckboxListTile(
            secondary: const Icon(Icons.accessible_forward),
            title: Text(obj['name']),
            subtitle: Text(obj['info']),
            value: valueList[obj['id']],
            onChanged: (bool value) {
              setState(() {
                valueList[obj['id']] = value;
              });
              print(value);
            },
          ));
          i++;
        }
      }
      return CheckoxListTitleList;
    }

    Widget ChangeDoctor = new Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 5),
        child: Card(
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
              Container(
                  child: Column(
                children: buildCheckboxListTile(),
              )),
            ],
          ),
        ));

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          '选择医生',
          style: TextStyle(color: Colors.white),
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
