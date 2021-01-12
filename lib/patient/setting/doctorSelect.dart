import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: doctorSelect(
      onlyuser: true,
      doctorlist: [
        {'id': 0, 'name': '张一', 'info': '其他信息', 'select': true},
        {'id': 1, 'name': '张二', 'info': '其他信息', 'select': false},
        {'id': 2, 'name': '张三', 'info': '其他信息', 'select': false},
        {'id': 3, 'name': '张四', 'info': '其他信息', 'select': true},
        {'id': 4, 'name': '张五', 'info': '其他信息', 'select': false},
        {'id': 5, 'name': '张六', 'info': '其他信息', 'select': true},
        {'id': 6, 'name': '张七', 'info': '其他信息', 'select': false}
      ],
      selectedDoctor: [
        {'id': 0, 'name': '张一', 'info': '其他信息', 'select': true},
        {'id': 3, 'name': '张四', 'info': '其他信息', 'select': true},
        {'id': 5, 'name': '张六', 'info': '其他信息', 'select': true},
      ],
      unSelectedDoctor: [
        {'id': 1, 'name': '张二', 'info': '其他信息', 'select': false},
        {'id': 2, 'name': '张三', 'info': '其他信息', 'select': false},
        {'id': 4, 'name': '张五', 'info': '其他信息', 'select': false},
        {'id': 6, 'name': '张七', 'info': '其他信息', 'select': false}
      ],
    ),
  ));
}

class doctorSelect extends StatefulWidget {
  doctorSelect(
      {Key key,
      @required this.onlyuser,
      @required this.doctorlist,
      @required this.selectedDoctor,
      @required this.unSelectedDoctor})
      : super(key: key) {
    this.onlyuser = onlyuser;
    this.selectedDoctor = selectedDoctor;
    this.unSelectedDoctor = unSelectedDoctor;
  }

//
  bool onlyuser;
  List doctorlist;
  List selectedDoctor;
  List unSelectedDoctor;

  @override
  _doctorSelectState createState() => new _doctorSelectState(
      onlyuser: onlyuser,
      pdoctorlist: doctorlist,
      pselectedDoctor: selectedDoctor,
      punSelectedDoctor: unSelectedDoctor);
//  _doctorSelectState createState() => new _doctorSelectState();

}

class _doctorSelectState extends State<doctorSelect> {
  _doctorSelectState(
      {@required bool onlyuser,
      @required List pdoctorlist,
      @required List pselectedDoctor,
      @required List punSelectedDoctor}) {
    this.onlyuser = onlyuser;
    this.doctorlist = pdoctorlist;
    this.selectedDoctor = pselectedDoctor;
    this.unSelectedDoctor = punSelectedDoctor;
  }

//  bool onlyuser = true;
//  List doctorlist = [
//    {'id': 0, 'name': '张一', 'info': '其他信息', 'select': true},
//    {'id': 1, 'name': '张二', 'info': '其他信息', 'select': false},
//    {'id': 2, 'name': '张三', 'info': '其他信息', 'select': false},
//    {'id': 3, 'name': '张四', 'info': '其他信息', 'select': true},
//    {'id': 4, 'name': '张五', 'info': '其他信息', 'select': false},
//    {'id': 5, 'name': '张六', 'info': '其他信息', 'select': true},
//    {'id': 6, 'name': '张七', 'info': '其他信息', 'select': false}
//  ];
//  List selectedDoctor = [
//    {'id': 0, 'name': '张一', 'info': '其他信息', 'select': true},
//    {'id': 3, 'name': '张四', 'info': '其他信息', 'select': true},
//    {'id': 5, 'name': '张六', 'info': '其他信息', 'select': true},
//  ];
//  List unSelectedDoctor = [
//    {'id': 1, 'name': '张二', 'info': '其他信息', 'select': false},
//    {'id': 2, 'name': '张三', 'info': '其他信息', 'select': false},
//    {'id': 4, 'name': '张五', 'info': '其他信息', 'select': false},
//    {'id': 6, 'name': '张七', 'info': '其他信息', 'select': false}
//  ];



  bool onlyuser;
  List doctorlist;
  List selectedDoctor;
  List unSelectedDoctor;

  List<OverlayEntry> overlayEntryList = new List();

  String switchContent() {
    if (onlyuser == true) {
      return '仅自己可见';
    } else {
      return '选中医生可见';
    }
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    Column buildSelectedCheckboxListTile() {
      var CheckoxListTitleList = List<CheckboxListTile>();
      if (onlyuser == false) {
        for (Map obj in selectedDoctor) {
          CheckoxListTitleList.add(new CheckboxListTile(
            isThreeLine: true,
            secondary: Image.network(
              'https://www.easyicon.net/api/resizeApi.php?id=1291310&size=96',
            ),
            title: Text(obj['name']),
            subtitle: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(obj['hospital'] == null ? '医院不详' : obj['hospital']),
                Text(obj['department'] == null ? '科室不详' : obj['department'])
              ],
            ),
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
      return Column(
        children: CheckoxListTitleList,
      );
    }

    Column buildUnSelectedCheckboxListTile() {
      var CheckoxListTitleList = List<CheckboxListTile>();
      if (onlyuser == false) {
        for (Map obj in unSelectedDoctor) {
          CheckoxListTitleList.add(new CheckboxListTile(
            isThreeLine: true,
            secondary: Image.network(
              'https://www.easyicon.net/api/resizeApi.php?id=1291310&size=96',
            ),
            title: Text(obj['name']),
            subtitle: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(obj['hospital'] == null ? '医院不详' : obj['hospital']),
                Text(obj['department'] == null ? '科室不详' : obj['department'])
              ],
            ),
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
      return Column(
        children: CheckoxListTitleList,
      );
    }

    AppBar appBar = AppBar(
      title: Text('Demo'),
    );

    void screen() {
      String name = null;
      String hospital = null;
      String department = null;
      int flag = 0;
      OverlayEntry infoSelect = new OverlayEntry(builder: (context) {
        return new Positioned(
            top: appBar.preferredSize.height +
                MediaQueryData.fromWindow(window).padding.top,
            left: MediaQuery.of(context).size.width * 0.4,
            child: new Material(
                child: new Container(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
//                                      height: 500,
                child: new Container(
                  padding: EdgeInsets.all(6),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      children: <Widget>[
                        new Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '姓名',
                                style: TextStyle(fontSize: 12),
                              ),
                              TextField(
                                decoration: new InputDecoration(
                                  labelStyle: new TextStyle(
                                    fontSize: 12,
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
                                '医院',
                                style: TextStyle(fontSize: 12),
                              ),
                              TextField(
                                decoration: new InputDecoration(
                                  labelStyle: new TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 93, 93, 93),
                                  ), //border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  hospital = value;
                                },
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '科室',
                              style: TextStyle(fontSize: 12),
                            ),
                            TextField(
                              decoration: new InputDecoration(
                                labelStyle: new TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 93, 93, 93),
                                ), //border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                department = value;
                              },
                            )
                          ],
                        ),
                        new Container(
                          height: 30,
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 5),
                          child: new SizedBox.expand(
                            child: new RaisedButton(
                              onPressed: () {
                                SharedPreferenceUtil.getString('userId')
                                    .then((value) async {
                                  Map<String, dynamic> data = Map();
                                  var url =
                                      "http://39.100.100.198:8082/selectAllDoctor";
                                  Map<String, dynamic> doctor = Map();
                                  data['userId'] = value;
                                  doctor['name'] = name;
                                  doctor['hospital'] = hospital;
                                  doctor['department'] = department;
                                  data['doctor'] = doctor;
                                  var formData = data;
                                  print('1111' + data.toString());
                                  await request(url, context,
                                          FormData: formData)
                                      .then((value) {
                                    Map data = json.decode(value.toString());
                                    List selectedList = new List();
                                    if (data['selected_doctor_id'] != null) {
                                      for (int id in data['selected_doctor_id']) {
                                        selectedList.add(id);
                                      }
                                    }
                                    doctorlist.clear();
//                                    selectedDoctor.clear();
                                    unSelectedDoctor.clear();

                                    for (Map temp in selectedDoctor) {
                                      doctorlist.add(temp);
                                    }

                                    for (Map temp in data['doctors']) {
                                      Map doctor = {};
                                      doctor['id'] = temp['id'];
                                      doctor['name'] = temp['name'];
                                      doctor['info'] = temp['id_num'];
                                      doctor['hospital'] = temp['hospital'];
                                      doctor['department'] = temp['department'];
                                      doctor['pictureAddress'] =
                                          temp['address'] == null
                                              ? temp['address']
                                              : null;
                                      if (selectedList.contains(temp['id'])) {
//                                        doctor['select'] = true;
//                                        selectedDoctor.add(doctor);
                                      } else {
                                        doctor['select'] = false;
                                        unSelectedDoctor.add(doctor);
                                      }
                                      doctorlist.add(doctor);
                                    }
                                    if (selectedDoctor.length == 0) {
                                      onlyuser = true;
                                    } else {
                                      onlyuser = false;
                                    }
                                    print('11111');
                                    print(doctorlist);
                                    print(selectedDoctor);
                                    print(unSelectedDoctor);
                                    flag = 1;
                                    refreshPage();
                                    for (OverlayEntry temp
                                        in overlayEntryList) {
                                      temp.remove();
                                    }
                                  });
                                });
                              },
                              elevation: 0,
                              color: Colors.blue,
                              child: new Text(
                                '确定',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
                              //onPressed:,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
      });

      overlayEntryList.add(infoSelect);

      Overlay.of(context).insertAll(overlayEntryList);
    }

    ;

    Container text1() {
      if (onlyuser == false && selectedDoctor.isNotEmpty) {
        return new Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text('已选中：')],
          ),
        );
      }
    }

    Container text2() {
      if (onlyuser == false && unSelectedDoctor.isNotEmpty) {
        return new Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text('未选中：')],
          ),
        );
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
                    padding: EdgeInsets.only(
                        right: 16, left: 24, top: 4, bottom: 10),
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
                                Container(),
                              ]))),
                  Container(child: text1()),
                  Container(
                    child: buildSelectedCheckboxListTile(),
                  ),

                  Container(child: text2()),
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
        actions: <Widget>[
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15, right: 15),
                  child: InkWell(
                    onTap: screen,
                    child: new Text(
                      '筛选',
                      style: new TextStyle(
//                    color: Colors.,
//                    fontWeight: FontWeight.,
                        fontSize: 18,
                      ),
                    ),
                  ))),
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15, right: 15),
                  child: InkWell(
                    onTap: () {
                      List<int> commitlist = List();
                      for (Map temp in selectedDoctor) {
                        commitlist.add(temp['id']);
                      }
                      if (onlyuser == true) {
                        commitlist.clear();
                      }
                      print(commitlist);
                      SharedPreferenceUtil.getString('userId')
                          .then((value) async {
                        Map map = Map();
                        map['userId'] = value;
                        map['add_doctor_id'] = commitlist;
                        print(map);
                        var url = "http://39.100.100.198:8082/selectPAD";
                        await request(url, context, FormData: map)
                            .then((value) {
                          Map data = json.decode(value.toString());
                          print(data);
                          if(data['status_code'] == 1){
                            showAlertDialog(context,
                                titleText: '操作成功',
                                contentText: '医生修改成功',
                                flag: 0);
                          }

                        });
                      });
                    },
                    child: new Text(
                      '提交',
                      style: new TextStyle(
//                    color: Colors.,
//                    fontWeight: FontWeight.,
                        fontSize: 18,
                      ),
                    ),
                  )))
        ],
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
