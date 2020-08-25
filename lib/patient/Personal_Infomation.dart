import 'package:flutter/material.dart';
import 'BottomNavigationBar.dart';
void main() =>runApp(new Personal_Info());

class Personal_Info extends StatelessWidget {
  BottomNavigationBarClass Bottom_NavigationBar = new BottomNavigationBarClass();

  @override
  Widget build(BuildContext context) {

    Widget Basic_Info = new Container(
      padding: EdgeInsets.only(top: 30,left: 10,right: 5),
      child: new SizedBox(
        height: 300,
        width: 390,
        child: new Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                side: BorderSide(width: 1.0)),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text(
                      '基本信息',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                    child:new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          child: new Text('姓名',
                            style:TextStyle(
                              fontSize: 19,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10),
                        ),
                        new Divider(
                          color: Colors.black26,
                          thickness: 2,
                        ),
                      ]
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child:new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text('性别',
                              style:TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          new Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                        ]
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child:new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text('民族',
                              style:TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          new Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                        ]
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child:new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text('出生地',
                              style:TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          new Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                        ]
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child:new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text('身份证号',
                              style:TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          new Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                        ]
                    ),
                  ),
                ]
            )
        ),
      ),
    );

    Widget Contact  = new Container(
      padding: EdgeInsets.only(top: 30,left: 10,right: 5),
      child: new SizedBox(
        height: 300,
        width: 390,
        child: new Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                side: BorderSide(width: 1.0)),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text(
                      '联系方式',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                    child:new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text('手机号',
                              style:TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          new Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                        ]
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child:new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text('通讯地址',
                              style:TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          new Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                        ]
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child:new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text('现居住地',
                              style:TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          new Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                        ]
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child:new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text('曾居住地',
                              style:TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          new Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                        ]
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child:new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text('紧急联系人',
                              style:TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          new Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                        ]
                    ),
                  ),
                ]
            )
        ),
      ),
    );

    return new MaterialApp(
      title: '个人信息',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('个人信息',style: TextStyle(color: Colors.white),),
          centerTitle: true,
//          backgroundColor: Colors.blue,
          leading: new Icon(Icons.arrow_back_ios,size: 25,),
        ),
        body: new ListView(
          children: [Basic_Info,Contact,]
        ),
        bottomNavigationBar: Bottom_NavigationBar.Create(),
      )
    );
  }
}