import 'package:flutter/material.dart';
import 'package:helloworld/patient/MainFunctionPage.dart';
import 'BottomNavigationBar.dart';
void main(){
  runApp(new MaterialApp(
    title: '设置页',
    home: new Setting(),
  ));
}

class Setting extends StatelessWidget{
  BottomNavigationBarClass Bottom_NavigationBar = new BottomNavigationBarClass();
  @override
  Widget build(BuildContext context) {
    Widget ChangePspt = new Container(
        padding: EdgeInsets.only(top: 30,left: 10,right: 5),
        child: SizedBox(
          height: 60,
          width: 390,
          child: new Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(width: 1.0)),
              child: Row(
                children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child:Text('修改手机号',
                    style:TextStyle(
                        fontSize: 23
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 230),
                  child:new Icon(Icons.arrow_forward_ios,size: 26,),
                ),
              ]
              )
          ),

      )
    );
    Widget ChangePhonenum = new Container(
        padding: EdgeInsets.only(top:0,left: 10,right: 5),
        child: SizedBox(
          height: 60,
          width: 400,
          child: new Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(width: 1.0)),
              child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10),
                      child:Text('修改密码',
                        style:TextStyle(
                            fontSize: 23
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 250),
                      child:new Icon(Icons.arrow_forward_ios,size: 26,),
                    ),
                  ]
              )
          ),

        )
    );
    Widget ensure = new Container(
      height: 60.0,
      width: 10,
        margin: EdgeInsets.only(top: 10,left: 40,right: 40),
        child: new RaisedButton(
          color: Colors.blue,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
          child: new Text(
            '确定',
            style: TextStyle(
                fontSize: 23.0,
                color: Colors.white
            ),
          ),
        ),

    );



    return Scaffold(
      appBar: new AppBar(
        title: Text('设置',style: TextStyle(color: Colors.white),),
        centerTitle: true,
//        backgroundColor: Colors.blue,
        leading: new Icon(Icons.arrow_back_ios,size: 25,),
      ),
      body: new ListView(
        children: <Widget>[ChangePspt,ChangePhonenum,ensure],
      ),

      bottomNavigationBar:Bottom_NavigationBar.Create()
    );
  }
}