
import 'package:flutter/material.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
      home: HospitalizedRecord(),
    ));

class HospitalizedRecord extends StatefulWidget {
  @override
  State createState() => new _HospitalizedRecord();
}

class _HospitalizedRecord extends State<HospitalizedRecord> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  DateTime startDate = DateTime.now();
  DateTime EndDate = DateTime.now();
  String hospital;
  String office;
  String doctorname;
  String recordcontent;
  String lebalContent = '请选择科室';
  Map labelmap = {
    '1': '皮肤科',
    '2': '内科',
    '3': '外科',
    '4': '妇产科',
    '5': '男科',
    '6': '儿科',
    '7': '五官科',
    '8': '肿瘤科',
    '9': '中医科',
    '10': '传染科'
  };

  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('皮肤科'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('内科'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3 = new DropdownMenuItem(
      child: new Text('外科'),
      value: '3',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4 = new DropdownMenuItem(
      child: new Text('妇产科'),
      value: '4',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5 = new DropdownMenuItem(
      child: new Text('男科'),
      value: '5',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6 = new DropdownMenuItem(
      child: new Text('儿科'),
      value: '6',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7 = new DropdownMenuItem(
      child: new Text('五官科'),
      value: '7',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8 = new DropdownMenuItem(
      child: new Text('肿瘤科'),
      value: '8',
    );
    items.add(dropdownMenuItem8);
    DropdownMenuItem dropdownMenuItem9 = new DropdownMenuItem(
      child: new Text('中医科'),
      value: '9',
    );
    items.add(dropdownMenuItem9);
    DropdownMenuItem dropdownMenuItem10 = new DropdownMenuItem(
      child: new Text('传染科'),
      value: '10',
    );
    items.add(dropdownMenuItem10);
    return items;
  }

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

  Future<void> _selectendDate() async //异步
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
      EndDate = selectdate;
    });
  }

  void summit() async {
//    print(name);
//    var loginForm = loginKey.currentState;
//    //验证Form表单
//    if(loginForm.validate()){
//      print(name);
//    }

    if (office == null ||
        hospital == null ||
        doctorname == null ||
        recordcontent == null) {
      showAlertDialog(context, contentText: '请填写所有项目，若没有信息请填写“无”');
    } else {
      var bodymap = Map();
      var admissionNote = Map();
      String phoneNum;
      SharedPreferenceUtil.getString('userId').then((value) async {
        phoneNum = value;
//      admissionNote['phone_num'] = phoneNum;
        bodymap['userId'] = phoneNum;
        admissionNote['s_date'] = startDate.year.toString() +
            '-' +
            startDate.month.toString() +
            '-' +
            startDate.day.toString();
        admissionNote['o_date'] = EndDate.year.toString() +
            '-' +
            EndDate.month.toString() +
            '-' +
            EndDate.day.toString();
        admissionNote['department_treatment'] = office;
        admissionNote['hospital'] = hospital;
        admissionNote['doctor_name'] = doctorname;
        admissionNote['admission_info'] = recordcontent;
        bodymap['admissionNote'] = admissionNote;
        print(bodymap);
        var url = "http://39.100.100.198:8082/admission";
        var formData = bodymap;
        await request(url, context, FormData: formData).then((value) {
          Map data = json.decode(value.toString());
          print(data);
          if(data['status_code'] == 1) {
            showAlertDialog(context, titleText: 'success', contentText: '操作成功', flag: 1);
          }
          else {
            showAlertDialog(context, titleText: '上传失败', contentText: '请稍后重试',flag: 0);
          }
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
            InkWell(
              onTap: _selectstartDate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '开始日期:',
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
            InkWell(
              onTap: _selectendDate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '结束日期:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
//                  date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString(),
                    DateFormat.yMd().format(EndDate),
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
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
                      '就诊科室:',
                      style: TextStyle(fontSize: 19),
                    ),
                    new DropdownButton(
                      items: getListData(),
                      hint: new Text(lebalContent),
                      //当没有默认值的时候可以设置的提示
//                  value: value,//下拉菜单选择完之后显示给用户的值
                      onChanged: (value) {
                        //下拉菜单item点击之后的回调
                        office = labelmap[value];
                        print(office);
                        setState(() {
                          lebalContent = labelmap[value];
                        });
                      },
                      elevation: 24,
                      //设置阴影的高度
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
                  decoration: new InputDecoration(
                    labelText: '就诊医院',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    hospital = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入医生姓名',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    doctorname = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入住院病例内容',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    recordcontent = value;
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );

    Widget dividerline = Container(
      height: 60,
    );

    Widget ok = new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          onPressed: summit,
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

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '住院病历上传',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
//          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              width: double.infinity,
              height: 90,
              child: Center(
                  child: new Text(
                '住院病历',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
//              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[basicInfo, dividerline, ok],
              ),
            )
          ],
        ));
  }
}
