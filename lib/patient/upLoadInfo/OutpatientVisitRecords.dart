import 'dart:core';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/PickFileMethod.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';
import 'package:helloworld/patient/MainFunctionPage.dart';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:intl/intl.dart';
import 'hospitalizedRecord.dart';

void main() => runApp(MaterialApp(
  home: outpatientVisitRecords(),
));

class outpatientVisitRecords extends StatefulWidget {
  @override
  State createState() => new _outpatientVisitRecords();
}

class _outpatientVisitRecords extends State<outpatientVisitRecords> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  DateTime date = DateTime.now();
  String hospital;
  String office;
  String doctorname;
  String recordcontent;
  String conclusion;
  String examItem;
  String medicine_name;   //药物名称
  String medicine_method;  //使用方法
  String time;   //使用频率
  String nonDrugMethod;
  String lebalContent = '请选择科室';


  List<DropdownMenuItem> getListData(){
    List<DropdownMenuItem> items=new List();
    DropdownMenuItem dropdownMenuItem1=new DropdownMenuItem(
      child:new Text('皮肤科'),
      value: '皮肤科',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2=new DropdownMenuItem(
      child:new Text('内科'),
      value: '内科',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3=new DropdownMenuItem(
      child:new Text('外科'),
      value: '外科',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4=new DropdownMenuItem(
      child:new Text('妇产科'),
      value: '妇产科',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5=new DropdownMenuItem(
      child:new Text('男科'),
      value: '男科',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6=new DropdownMenuItem(
      child:new Text('儿科'),
      value: '儿科',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7=new DropdownMenuItem(
      child:new Text('五官科'),
      value: '五官科',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8=new DropdownMenuItem(
      child:new Text('肿瘤科'),
      value: '肿瘤科',
    );
    items.add(dropdownMenuItem8);
    DropdownMenuItem dropdownMenuItem9=new DropdownMenuItem(
      child:new Text('中医科'),
      value: '中医科',
    );
    items.add(dropdownMenuItem9);
    DropdownMenuItem dropdownMenuItem10=new DropdownMenuItem(
      child:new Text('传染科'),
      value: '传染科',
    );
    items.add(dropdownMenuItem10);
    return items;
  }

  Future<void> _selectDate() async //异步
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
      date = selectdate;
    });
  }


  void summit() async {

//    print(name);
//    var loginForm = loginKey.currentState;
//    //验证Form表单
//    if(loginForm.validate()){
//      print(name);
//    }


    var bodymap = Map();
    var tempdrugMethod = Map<String,dynamic>();
    var drugMethod = List<Map>();
    var outPatientRecords = Map();
    String phoneNum;
    SharedPreferenceUtil.getString('phoneNum').then((value) async{
      phoneNum = value;
      bodymap['phone_num'] = '11223344556';
      outPatientRecords['date'] = date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString();
      outPatientRecords['department_treatment'] = office;
      outPatientRecords['hospit al'] = hospital;
      outPatientRecords['disease_info'] = recordcontent;
      outPatientRecords['doctor_name'] = doctorname;
      outPatientRecords['treat_info'] = recordcontent;
      outPatientRecords['treating_info'] = conclusion;
      outPatientRecords['treat_methods'] = nonDrugMethod;
      tempdrugMethod['medicine_name'] = medicine_name;
      tempdrugMethod['medicine_method'] = medicine_method;
      tempdrugMethod['time'] = time;
      drugMethod.add(tempdrugMethod);
      outPatientRecords['medicines'] = [{'medicine_name':medicine_name,'medicine_method':medicine_method,'time':time}];
      bodymap['outPatientRecords'] = outPatientRecords;
      print(bodymap);
      var url = "http://39.100.100.198:8082/outpatientRecords";
      var formData = bodymap;
      await request(url, FormData: formData).then((value) {
        var data = json.decode(value.toString());
        print(data);
        showAlertDialog(context, contentText: '操作成功');

      });
    });


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
              onTap: _selectDate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '体检日期:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
//                  date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString(),
                    DateFormat.yMd().format(date),
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
                  hint:new Text(lebalContent),//当没有默认值的时候可以设置的提示
//                  value: value,//下拉菜单选择完之后显示给用户的值
                  onChanged: (value){//下拉菜单item点击之后的回调
                    office = value;
                    setState(() {
                      lebalContent = value;
                    });
                  },
                  elevation: 24,//设置阴影的高度
                  style: new TextStyle(//设置文本框里面文字的样式
                      color: Colors.black,
                      fontSize: 15
                  ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                  iconSize: 50.0,//设置三角标icon的大小
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
                    labelText: '请输入诊断内容',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    recordcontent = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入就诊内容',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    conclusion = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入检查项目',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    examItem = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalizedRecord()));
                  },
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '住院治疗',
                        style: TextStyle(fontSize: 19),
                      ),
                      Icon(Icons.arrow_forward_ios,size: 19,color: Colors.black,),
                    ],
                ),),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '门诊治疗:',
                      style: TextStyle(fontSize: 19),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                    children: <Widget>[
                      Container(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '非药物治疗方案:',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      TextField(
                        decoration: new InputDecoration(
                          labelText: '请输入非药物治疗方案',
                          labelStyle: new TextStyle(
                              fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        maxLines: 4,
                        onChanged: (value) {
                          nonDrugMethod = value;
                        },
                      ),
                      Container(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '药物治疗方案:',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      TextField(
                        decoration: new InputDecoration(
                          labelText: '药物名称',
                          labelStyle: new TextStyle(
                              fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          medicine_name = value;
                        },
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      TextField(
                        decoration: new InputDecoration(
                          labelText: '使用方法',
                          labelStyle: new TextStyle(
                              fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          medicine_method = value;
                        },
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      TextField(
                        decoration: new InputDecoration(
                          labelText: '使用频率',
                          labelStyle: new TextStyle(
                              fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          time = value;
                        },
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                )
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
            '门诊就诊记录上传',
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
                    '门诊就诊记录',
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
