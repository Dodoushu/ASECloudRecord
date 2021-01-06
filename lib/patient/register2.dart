import 'package:flutter/material.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';
import 'MainFunctionPage.dart';
import 'package:intl/intl.dart';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:helloworld/patient/BottomNavigationBar.dart';
//import 'package:address_picker/address_picker.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:helloworld/globalUtils.dart';

void main() => runApp(MaterialApp(
      home: register2(),
      routes: <String, WidgetBuilder>{
        // 这里可以定义静态路由，不能传递参数
        '/dialog': (BuildContext context) => new NetLoadingDialog(),
      },
    ));

class register2 extends StatefulWidget {
  @override
  State createState() => new _register2();
}

class _register2 extends State<register2> {
  GlobalKey<FormState> registerKey = new GlobalKey<FormState>();

  Function Dismiss;
  String name;
  static final TextEditingController nameController = new TextEditingController();
  String sex;
  static final TextEditingController sexController = new TextEditingController();
  String nation;
  static final TextEditingController nationController = new TextEditingController();
  String birthplace;
  static final TextEditingController birthplaceController = new TextEditingController();
  String ID;
  static final TextEditingController idController = new TextEditingController();

  int formerResidenceNumber; //暂时没用到
  int ICENumber; //暂时没用到

  String mailAddress;
  static final TextEditingController mailaddressController = new TextEditingController();
  String address;
  static final TextEditingController addressController = new TextEditingController();

  String FR1;
  static final TextEditingController fr1Controller = new TextEditingController();
  String FR2;
  static final TextEditingController fr2Controller = new TextEditingController();
  String ICE1name;
  static final TextEditingController ICE1nameController = new TextEditingController();
  String ICE1phone;
  static final TextEditingController ICE1phoneController = new TextEditingController();
  String ICE2name;
  static final TextEditingController ICE2nameController = new TextEditingController();
  String ICE2phone;
  static final TextEditingController ICE2phoneController = new TextEditingController();

  String lebalContent = '请选择性别';
  Map labelmap = {
    '0': '男',
    '1': '女',
  };

  Result birthAddressResult = new Result(
      provinceId: '110000',
      provinceName: "北京市",
      cityName: '北京城区',
      cityId: '110100',
      areaName: '东城区',
      areaId: '110101');

  Result nowAddressResult = new Result(
      provinceId: '110000',
      provinceName: "北京市",
      cityName: '北京城区',
      cityId: '110100',
      areaName: '东城区',
      areaId: '110101');

  Result mailAddressResult = new Result(
      provinceId: '110000',
      provinceName: "北京市",
      cityName: '北京城区',
      cityId: '110100',
      areaName: '东城区',
      areaId: '110101');
//  Result addressResult = new Result('110000', '110100', '110101', '北京市', '北京城区', '东城区');

  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('男'),
      value: '0',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('女'),
      value: '1',
    );
    items.add(dropdownMenuItem2);
    return items;
  }

  DateTime startDate = DateTime.now();
  Future<void> _selectstartDate() async //异步
  {
    final DateTime selectdate = await showDatePicker(
      //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectdate == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      startDate = selectdate;
    });
  }

  var data;
  void submit() async {
    var loginForm = registerKey.currentState;
    //验证Form表单
    if (loginForm.validate()) {
      var bodymap = Map();
      var patient = Map();
      String phoneNum;
      SharedPreferenceUtil.getString('userId').then((value) {
        phoneNum = value;
        bodymap['userId'] = phoneNum;
        patient['name'] = name;
        SharedPreferenceUtil.setString("name", name).then((value) async {
          patient['birthday'] = startDate.year.toString() +
              '-' +
              startDate.month.toString() +
              '-' +
              startDate.day.toString();

          patient['sex'] = int.parse(sex);
          patient['race'] = nation;
          patient['birthplace'] = birthAddressResult.provinceName +
              ' ' +
              birthAddressResult.cityName +
              ' ' +
              birthAddressResult.areaName +
              ' ' +
              birthplace;
          patient['id_num'] = ID;
          patient['postal_addr'] = mailAddressResult.provinceName +
              ' ' +
              mailAddressResult.cityName +
              ' ' +
              mailAddressResult.areaName +
              ' ' +
              mailAddress;
          patient['now_addr'] = nowAddressResult.provinceName +
              ' ' +
              nowAddressResult.cityName +
              ' ' +
              nowAddressResult.areaName +
              ' ' +
              address;
          patient['pre_addr1'] = FR1;
          patient['emerge'] = [
            {'name': ICE1name, 'phone_num': ICE1phone},
            {'name': ICE2name, 'phone_num': ICE2phone}
          ];
          bodymap['patient'] = patient;
          print(bodymap);
          var url = "http://39.100.100.198:8082/patient";
          var formData = bodymap;

          await request(url, context, FormData: formData).then((value) {
            var data = json.decode(value.toString());
            if (data['status_code'] == 1) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationWidget()),
                  (route) => false);
            } else if (data['status_code'] == 0) {
              showAlertDialog(context,
                  titleText: 'failed', contentText: '身份信息证已存在，请重试', flag: 0);
            } else if (data['status_code'] == 2) {
              showAlertDialog(context,
                  titleText: 'failed', contentText: '必填信息不全，请重试', flag: 0);
            }
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget basicInfo = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '基础信息',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Column(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: new InputDecoration(
                    labelText: '请输入您的姓名',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '性别:',
                      style: TextStyle(fontSize: 19),
                    ),
                    new DropdownButton(
                      items: getListData(),
                      hint: new Text(lebalContent), //当没有默认值的时候可以设置的提示
                      onChanged: (value) {
                        //下拉菜单item点击之后的回调
                        sex = value;
                        print(sex);
                        setState(() {
                          lebalContent = labelmap[value];
                        });
                      },
                      elevation: 24, //设置阴影的高度
                      style: new TextStyle(
                        //设置文本框里面文字的样式
                          color: Colors.black,
                          fontSize: 15),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                      iconSize: 50.0, //设置三角标icon的大小
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  controller: nationController,
                  decoration: new InputDecoration(
                    labelText: '请输入您的民族',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    nation = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                InkWell(
                  onTap: _selectstartDate,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '出生日期:',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
//                  date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString(),
                        DateFormat.yMd().format(startDate),
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '出生地:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Container(),
                  ],
                ),
                InkWell(
                    onTap: () async {
                      Result result = await CityPickers.showCityPicker(
                          context: context);
                      if (result != null) {
                        birthAddressResult = result;
                        print(birthAddressResult.toString());
                        setState(() {});
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: new Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(birthAddressResult.provinceName,
                              style: TextStyle(fontSize: 18)),
                          Text(birthAddressResult.cityName,
                              style: TextStyle(fontSize: 18)),
                          Text(birthAddressResult.areaName,
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                    )),
                TextField(
                  controller: birthplaceController,
                  decoration: new InputDecoration(
                    labelText: '请输入详细地址',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    birthplace = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                Form(
                    key: registerKey,
                    child: TextFormField(
                      controller: idController,
                      autovalidate: true,
                      decoration: new InputDecoration(
                        labelText: '请输入您的身份证号',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        RegExp cardReg = RegExp(
                            r'^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$');
                        if (value == null ||
                            value.isEmpty ||
                            !cardReg.hasMatch(value)) {
                          return '请输入有效身份证号';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        ID = value;
                      },
                    )),
                Divider(
                  thickness: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );

    Widget dividerline = Container(
      height: 30,
    );

    Widget contact = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '联络方式',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '通讯地址:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Container(),
                  ],
                ),
                InkWell(
                    onTap: () async {
                      Result result2 =
                          await CityPickers.showCityPicker(context: context);
                      if (result2 != null) {
                        mailAddressResult = result2;
                        print(mailAddressResult.toString());
                        setState(() {});
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(mailAddressResult.provinceName,
                              style: TextStyle(fontSize: 18)),
                          Text(mailAddressResult.cityName,
                              style: TextStyle(fontSize: 18)),
                          Text(mailAddressResult.areaName,
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                    )),
                TextField(
                  controller: mailaddressController,
                  decoration: new InputDecoration(
                    labelText: '请输入详细地址',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    mailAddress = value;
                  },
                ),

                Divider(
                  thickness: 2,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '现居住地:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Container(),
                  ],
                ),
                InkWell(
                    onTap: () async {
                      Result result3 =
                          await CityPickers.showCityPicker(context: context);
                      if (result3 != null) {
                        nowAddressResult = result3;
                        print(nowAddressResult.toString());
                        setState(() {});
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(nowAddressResult.provinceName,
                              style: TextStyle(fontSize: 18)),
                          Text(nowAddressResult.cityName,
                              style: TextStyle(fontSize: 18)),
                          Text(nowAddressResult.areaName,
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                    )),
                TextField(
                  controller: addressController,
                  decoration: new InputDecoration(
                    labelText: '请输入详细地址',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    address = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '曾居住地',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  controller: fr1Controller,
                  decoration: new InputDecoration(
                    labelText: '请输入您的曾居住地1',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged: (value) {
                    FR1 = value;
                  },
                ),
//                Divider(
//                  thickness: 2,
//                ),
//                TextField(
//                  decoration: new InputDecoration(
//                    labelText: '请输入您的曾居住地2',
//                    labelStyle: new TextStyle(
//                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
//                    border: InputBorder.none,
//                  ),
//                  maxLines: 5,
//                  onChanged: (value) {
//                    FR2 = value;
//                  },
//                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '紧急联系人',
                      style: TextStyle(fontSize: 18),
                    ),
//                    IconButton(
//                      icon: Icon(Icons.add),
//                      onPressed: frplus,
//                    )
                  ],
                )),
            Divider(
              thickness: 2,
            ),
            TextField(
              controller: ICE1nameController,
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人1姓名',
                labelStyle: new TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ICE1name = value;
              },
            ),
            Divider(
              thickness: 2,
            ),
            TextField(
              controller: ICE1phoneController,
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人1电话',
                labelStyle: new TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ICE1phone = value;
              }, 
            ),
            Divider(
              thickness: 2,
            ),
            TextField(
              controller: ICE2nameController,
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人2姓名',
                labelStyle: new TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ICE2name = value;
              },
            ),
            Divider(
              thickness: 2,
            ),
            TextField(
              controller: ICE2phoneController,
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人2电话',
                labelStyle: new TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ICE2phone = value;
              },
            ),
          ],
        ),
      ),
    );

    Widget ok = new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          onPressed: () {
            print("summit begin");
            submit();
            //_disMissCallBack(Dismiss);
            print("summit end");
          },
          color: Colors.blue,
          child: new Text(
            '确定',
            style: TextStyle(
                fontSize: 14.0, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
        ),
      ),
    );

    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor:Colors.blue,
          backgroundColor: Colors.black12
      ),
        child: Scaffold(
        appBar: AppBar(
          title: Text(
            '用户注册',
            style: TextStyle(color: Colors.black),
          ),
          leading: new Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
          centerTitle: true,
//            backgroundColor: Colors.white,
        ),
        body: new ListView(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 0.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              width: double.infinity,
              height: 90,
              child: Center(
                  child: new Text(
                '基础信息填写',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )),
            ),
            basicInfo,
            dividerline,
            contact,
            ok,
          ],
        )));
  }
}
