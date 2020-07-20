import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '患者主功能页',
    home: new MainPage(),
  ));
}

class WidgetBulld {
  Expanded create(String text, IconData icondata) {
    return Expanded(
      child: new Container(
          child: Column(children: <Widget>[
        new Stack(children: <Widget>[
          SizedBox(
              height: 82,
              width: 82,
              child: Card(
                elevation: 15.0, //阴影
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    side: BorderSide(width: 1.0)),
              )),
          new Container(
//                                                alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Icon(
                icondata,
                size: 60,
                color: Colors.black,
              ))
        ]),
        new Container(
            child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ))
      ])),
    );
  }
}

class MainPage extends StatelessWidget {
  //实例化
  WidgetBulld widgetbuild = new WidgetBulld();

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
                  child: Text('******* 先生/女士，您好',
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
                                  new Container(
//                                                alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.assignment_ind,
                                        size: 60,
                                        color: Colors.black,
                                      ))
                                ]),
                                new Container(
                                    child: Text(
                                  '既往病史填写',
                                  style: TextStyle(fontSize: 18),
                                ))
                              ])),
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
                                  new Container(
//                                                alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.search,
                                        size: 60,
                                        color: Colors.black,
                                      ))
                                ]),
                                new Container(
                                    child: Text(
                                  '用户查询',
                                  style: TextStyle(fontSize: 18),
                                ))
                              ])),
                            )
                          ]),
                    )),
              )
            ]),
      ),
    ]);
    //跳转界面选择
    Widget ChooseModel = SizedBox(
        height: 415,
        width: 390,
        child: Container(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 15.0, //阴影
            //设置圆角和边框
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.0)),
                side: BorderSide(width: 1.0)),
            child: Row(children: <Widget>[
              new Container(
                  padding: EdgeInsets.all(15),
                  child: Column(children: <Widget>[
                    widgetbuild.create("体检报告", Icons.receipt),
                    widgetbuild.create("病症照片", Icons.pageview),
                    widgetbuild.create("影像检查", Icons.perm_media),
                  ])),
              new Container(
                padding: EdgeInsets.all(13),
                child: Column(children: <Widget>[
                  widgetbuild.create("门诊病历", Icons.assignment),
                  widgetbuild.create("门诊记录", Icons.account_balance_wallet),
                  widgetbuild.create("侵入型器械检查", Icons.edit),
                ]),
              ),
              new Container(
                padding: EdgeInsets.all(12),
                child: Column(children: <Widget>[
                  widgetbuild.create("住院病历", Icons.redeem),
                  widgetbuild.create("化验检查", Icons.flare),
                  widgetbuild.create("病理学检查", Icons.opacity),
                ]),
              )
            ]),
          ),
        ));

    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          '主页',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: new Column(
        children: <Widget>[stack, ChooseModel],
      ),
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 40,
            ),
            title: Text(
              '查询',
              style: TextStyle(fontSize: 22),
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.pages, color: Colors.black, size: 40),
            title: Text(
              '主页',
              style: TextStyle(fontSize: 22),
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black, size: 40),
            title: Text(
              '我的',
              style: TextStyle(fontSize: 22),
            ))
      ]),
    );
  }
}
