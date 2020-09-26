import 'package:flutter/material.dart';
import 'BottomNavigationBar.dart';
import 'Search.dart';
void main() {
  runApp(new MaterialApp(
    title: '患者主功能页',
    home: new MainPage(),
  ));
}

//class WidgetBulld {
//
//  Expanded create(String text, IconData icondata) {
//    return Expanded(
//      child: new Container(
//          child: Column(children: <Widget>[
//          new SizedBox(
//              height: 82,
//              width: 82,
//              child: Card(
//                elevation: 15.0, //阴影
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
//                    side: BorderSide(width: 1.0)),
//                child:new Container(
//                    alignment: Alignment.center,
//                    child: Icon(
//                      icondata,
//                      size: 50,
//                      color: Colors.black,
//                    ))
//              )),
//          new Container(
//              child: Text(text, style: TextStyle(fontSize: 18),
//        ))
//      ])),
//    );
//  }
//}

class MainPage extends StatelessWidget {
  //实例化
  @override
  Widget build(BuildContext context) {
    //背景蓝框及第一个功能选择条
    Widget stack = new Stack(alignment: Alignment.topCenter, children: <Widget>[
      //蓝框
      Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        width: double.infinity,
        height: 135,
      ),
      //文字及功能框一
      Container(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('******* 医生，您好',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ))),
              new Container(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    '健康是人生的第一财富',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
              SizedBox(
                height: 150,
                width: 600,
                child: Card(
                    elevation: 15.0, //阴影
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        side: BorderSide(width: 1.0)),
                    //设置圆角和边框
                    //设置内部两图标

                    child: new Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                child: Column(children: <Widget>[
                                  new Stack(children: <Widget>[
                                    SizedBox(
                                        height: 82,
                                        width: 82,
                                        child: Card(
                                          elevation: 15.0, //阴影
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0)),
                                              side: BorderSide(width: 1.0)),
                                        )),
                                    new InkWell(
                                        onTap: (){
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => 录入页面));
                                        },
                                        child: new Container(
//                                                alignment: Alignment.center,
                                            padding: EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.search,
                                              size: 60,
                                              color: Colors.black,
                                            ))
                                    ),
                                  ]),
                                  new InkWell(
                                    onTap: (){
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => 录入页面));
                                    },
                                    child: Container(
                                        child: Text(
                                          '医生录入',
                                          style: TextStyle(fontSize: 18),
                                        )),
                                  )
                                ]),
                              ),
                            ),
                            new Expanded(
                              child: new Container(
                                  child: Column(children: <Widget>[
                                new Stack(children: <Widget>[
                                  SizedBox(
                                      height: 82,
                                      width: 82,
                                      child: Card(
                                        elevation: 15.0, //阴影
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.0)),
                                            side: BorderSide(width: 1.0)),
                                      )),
                                  new InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                                    },
                                      child: new Container(
//                                                alignment: Alignment.center,
                                          padding: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.search,
                                            size: 60,
                                            color: Colors.black,
                                          ))
                                  ),
                                ]),
                                new InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                                  },
                                  child: Container(
                                      child: Text(
                                        '患者查询',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                )
                              ]),
                              ),
                            )
                          ]),
                    )),
              )
            ]),
      ),
    ]);
    //跳转界面选择
//    Widget ChooseModel = SizedBox(
//        height: 415,
//        width: 390,
//        child: Container(
//          padding: const EdgeInsets.only(bottom: 12),
//          child: Card(
//            elevation: 15.0, //阴影
//            //设置圆角和边框
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(28.0)),
//                side: BorderSide(width: 1.0)),
//            child: Row(children: <Widget>[
//              new Container(
//                  padding: EdgeInsets.all(18),
//                  child: Column(children: <Widget>[
//                    widgetbuild.create("体检报告", Icons.receipt),
//                    widgetbuild.create("病症照片", Icons.pageview),
//                    widgetbuild.create("影像检查", Icons.perm_media),
//                  ])),
//              new Container(
//                padding: EdgeInsets.all(18),
//                child: Column(children: <Widget>[
//                  widgetbuild.create("门诊病历", Icons.assignment),
//                  widgetbuild.create("门诊记录", Icons.account_balance_wallet),
//                  widgetbuild.create("侵入型器械检查", Icons.edit),
//                ]),
//              ),
//              new Container(
//                padding: EdgeInsets.all(18),
//                child: Column(children: <Widget>[
//                  widgetbuild.create("住院病历", Icons.redeem),
//                  widgetbuild.create("化验检查", Icons.flare),
//                  widgetbuild.create("病理学检查", Icons.opacity),
//                ]),
//              )
//            ]),
//          ),
//        ));

    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          '主页',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: new ListView(
        children:<Widget>[
          stack,
//          ChooseModel
        ]
      ),

     // bottomNavigationBar: Bottom_NavigationBar.Create(),
    );
  }
}
