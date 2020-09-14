import 'package:flutter/material.dart';
import 'package:helloworld/patient/MainFunctionPage.dart';
import 'BottomNavigationBar.dart';
import 'ChangePassword.dart';
import 'ChangePhoneNumber.dart';

void main() {
  runApp(new MaterialApp(
    title: '设置页',
    home: new Setting(),
  ));
}

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget ChangePspt = new Container(
        padding: EdgeInsets.only(top: 30, left: 10, right: 5),
        child: SizedBox(
            height: 60,
            width: 390,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePhNum()));
              },
              child: new Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(width: 0.5)),
                  child: Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '修改手机号',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
//                  padding: EdgeInsets.only(left: 230),
                          child: new Icon(
                            Icons.arrow_forward_ios,
                            size: 26,
                          ),
                        ),
                      ]))),
            )));
    Widget ChangePhonenum = new Container(
        padding: EdgeInsets.only(top: 0, left: 10, right: 5),
        child: SizedBox(
            height: 60,
            width: 400,

            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePswd()));
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(width: 0.5)),
                  child: Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '修改密码',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
//                      padding: EdgeInsets.only(left: 250),
                          child: new Icon(
                            Icons.arrow_forward_ios,
                            size: 26,
                          ),
                        ),
                      ]))),
            )));

    Widget ensure = new Container(
      height: 60.0,
      width: 10,
      margin: EdgeInsets.only(top: 10, left: 40, right: 40),
      child: new RaisedButton(
        color: Colors.blue,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0)),
        child: new Text(
          '确定',
          style: TextStyle(fontSize: 23.0, color: Colors.white),
        ),
      ),
    );

    Widget ChangeDoctor = new Container(
        padding: EdgeInsets.only(left: 10, right: 5),
        child: SizedBox(
            height: 60,
            width: 390,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePhNum()));
              },
              child: new Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(width: 0.5)),
                  child: Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '修改医生权限',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
//                          padding: EdgeInsets.only(left: 230),
                          child: new Icon(
                            Icons.arrow_forward_ios,
                            size: 26,
                          ),
                        ),
                      ]))),
            )));

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          '设置',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
//        backgroundColor: Colors.blue,
//        leading: new Icon(Icons.arrow_back_ios,size: 25,),
      ),
      body: new ListView(
        children: <Widget>[ChangePspt, ChangePhonenum, ChangeDoctor],
      ),
    );
  }
}
