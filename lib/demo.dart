import 'package:flutter/material.dart';

void main() => runApp(register2());

class register2 extends StatefulWidget {
  @override
  State createState() => new _register2();
}

class _register2 extends State<register2> {
  String name;
  String sex;
  String nation;
  String birthplace;
  String ID;

  int formerResidenceNumber;
  int ICENumber;

  String FR1;
  String FR2;
  String ICE1;
  String ICE2;

  void frplus(){
    if(formerResidenceNumber == null){
      formerResidenceNumber = 1;
    }
    if(formerResidenceNumber <= 3){
      setState(() {
        formerResidenceNumber++;
      });
    }
  }

  void INplus(){
    if(ICENumber == null){
      ICENumber = 1;
    }
    if(ICENumber<=3){
      setState(() {
        ICENumber++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget basicInfo = Container(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('基础信息',style: TextStyle(fontSize: 25),)
              ],
            ),
            Divider(thickness: 2,),
            Column(
              children: <Widget>[
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的姓名',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged:(value){
                    name=value;
                  },
                ),
                Divider(thickness: 2,),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的性别',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged:(value){
                    sex=value;
                  },
                ),
                Divider(thickness: 2,),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的民族',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged:(value){
                    nation=value;
                  },
                ),
                Divider(thickness: 2,),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的出生地',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                  onChanged:(value){
                    birthplace=value;
                  },
                ),
                Divider(thickness: 2,),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的身份证号',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged:(value){
                    ID=value;
                  },
                ),
                Divider(thickness: 2,),
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
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('联络方式',style: TextStyle(fontSize: 25),)
              ],
            ),
            Divider(thickness: 2,),
            Column(
              children: <Widget>[
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的通讯地址',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged:(value){
                    name=value;
                  },
                ),
                Divider(thickness: 2,),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的现居住地',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged:(value){
                    sex=value;
                  },
                ),
                Divider(thickness: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('曾居住地',style: TextStyle(fontSize: 18),),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: frplus,
                    )
                  ],
                ),
                Divider(thickness: 2,),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的曾居住地1',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged:(value){
                    FR1=value;
                  },
                ),
                Divider(thickness: 2,),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的曾居住地2',
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged:(value){
                    FR2=value;
                  },
                ),
                Divider(thickness: 2,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('紧急联系人',style: TextStyle(fontSize: 18),),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: frplus,
                )
              ],
            ),
            Divider(thickness: 2,),
            TextField(
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人1',
                labelStyle: new TextStyle(
                    fontSize: 15.0,
                    color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged:(value){
                ICE1=value;
              },
            ),
            Divider(thickness: 2,),
            TextField(
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人2',
                labelStyle: new TextStyle(
                    fontSize: 15.0,
                    color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged:(value){
                ICE2=value;
              },
            ),
            Divider(thickness: 2,),
          ],
        ),
      ),
    );

    Widget ok = new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0,bottom: 30,left: 30,right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          onPressed: frplus,
          color: Colors.blue,
          child: new Text(
            '确定',
            style: TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
        ),
      ),
    );

    return MaterialApp(
      title: '用户注册',
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              '用户注册',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: ListView(
            children: <Widget>[
              basicInfo,
              dividerline,
              contact,
              ok
            ],
          )
      ),
    );
  }
}