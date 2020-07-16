import 'package:flutter/material.dart';

void main(){
  runApp(new MaterialApp(
    title: '患者主功能页',
    home: new MainPage(),
  ));
}




class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //背景蓝框及第一个功能选择条
    Widget stack = new Stack(
        alignment: Alignment.topCenter,
        children:<Widget>[
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
                      child: Text(
                          '******* 先生/女士，您好',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 25,
                          )
                      )
                  ),
                  new Container(
                      padding: const EdgeInsets.all(6.0),
                      child:Text(
                        '健康是人生的第一财富',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                  ),
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
                          padding: const EdgeInsets.only(top:15),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: new Container(
                                      child: Column(
                                          children: <Widget>[
                                            new Stack(
                                                children: <Widget>[
                                                  SizedBox(
                                                      height: 82,
                                                      width: 82,
                                                      child:Card(
                                                        elevation: 15.0, //阴影
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                            side: BorderSide(width: 1.0)),
                                                      )
                                                  ),
                                                  new Container(
//                                                alignment: Alignment.center,
                                                      padding: EdgeInsets.all(10),
                                                      child: Icon(Icons.assignment_ind,size: 60,color: Colors.black,)
                                                  )
                                                ]

                                            ),
                                            new Container(
                                                child:Text('既往病史填写',style: TextStyle(fontSize: 18),)
                                            )
                                          ]

                                      )
                                  ),
                                ),
                                new Expanded(
                                  child: new Container(
                                      child: Column(


                                          children: <Widget>[
                                            new Stack(
                                                children: <Widget>[
                                                  SizedBox(
                                                      height: 82,
                                                      width: 82,
                                                      child:Card(
                                                        elevation: 15.0, //阴影
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                            side: BorderSide(width: 1.0)),
                                                      )
                                                  ),
                                                  new Container(
//                                                alignment: Alignment.center,
                                                      padding: EdgeInsets.all(10),
                                                      child: Icon(Icons.search,size: 60,color: Colors.black,)
                                                  )
                                                ]
                                            ),
                                            new Container(
                                                child:Text('用户查询',style: TextStyle(fontSize: 18),)
                                            )
                                          ]

                                      )
                                  ),
                                )
                              ]
                          ),
                        )
                    ),
                  )
                ]
            ),
          ),
        ]
    );
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
            child: Row(
                children: <Widget>[
                  new Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                  child: Column(


                                      children: <Widget>[
                                        new Stack(
                                            children: <Widget>[
                                              SizedBox(
                                                  height: 82,
                                                  width: 82,
                                                  child:Card(
                                                    elevation: 15.0, //阴影
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                        side: BorderSide(width: 1.0)),
                                                  )
                                              ),
                                              new Container(
//                                                alignment: Alignment.center,
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(Icons.receipt,size: 60,color: Colors.black,)
                                              )
                                            ]
                                        ),
                                        new Container(
                                            child:Text('体检报告',style: TextStyle(fontSize: 18),)
                                        )
                                      ]

                                  )
                              ),
                            ),
                            new Expanded(
                              child: new Container(
                                  child: Column(


                                      children: <Widget>[
                                        new Stack(
                                            children: <Widget>[
                                              SizedBox(
                                                  height: 82,
                                                  width: 82,
                                                  child:Card(
                                                    elevation: 15.0, //阴影
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                        side: BorderSide(width: 1.0)),
                                                  )
                                              ),
                                              new Container(
//                                                alignment: Alignment.center,
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(Icons.pageview,size: 60,color: Colors.black,)
                                              )
                                            ]
                                        ),
                                        new Container(
                                            child:Text('病症照片',style: TextStyle(fontSize: 18),)
                                        )
                                      ]

                                  )
                              ),
                            ),
                            new Expanded(
                              child: new Container(
                                  child: Column(


                                      children: <Widget>[
                                        new Stack(
                                            children: <Widget>[
                                              SizedBox(
                                                  height: 82,
                                                  width: 82,
                                                  child:Card(
                                                    elevation: 15.0, //阴影
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                        side: BorderSide(width: 1.0)),
                                                  )
                                              ),
                                              new Container(
//                                                alignment: Alignment.center,
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(Icons.perm_media,size: 60,color: Colors.black,)
                                              )
                                            ]
                                        ),
                                        new Container(
                                            child:Text('影像检查',style: TextStyle(fontSize: 18),)
                                        )
                                      ]

                                  )
                              ),
                            )
                          ]
                      )
                  ),
                  new Container(
                    padding: EdgeInsets.all(13),
                    child: Column(
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                                child: Column(

                                    children: <Widget>[
                                      new Stack(
                                          children: <Widget>[
                                            SizedBox(
                                                height: 82,
                                                width: 82,
                                                child:Card(
                                                  elevation: 15.0, //阴影
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                      side: BorderSide(width: 1.0)),
                                                )
                                            ),
                                            new Container(
//                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(10),
                                                child: Icon(Icons.assignment,size: 60,color: Colors.black,)
                                            )
                                          ]
                                      ),
                                      new Container(
                                          child:Text('门诊病历',style: TextStyle(fontSize: 18),)
                                      )
                                    ]

                                )
                            ),
                          ),
                          new Expanded(
                            child: new Container(
                                child: Column(


                                    children: <Widget>[
                                      new Stack(
                                          children: <Widget>[
                                            SizedBox(
                                                height: 82,
                                                width: 82,
                                                child:Card(
                                                  elevation: 15.0, //阴影
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                      side: BorderSide(width: 1.0)),
                                                )
                                            ),
                                            new Container(
//                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(10),
                                                child: Icon(Icons.account_balance_wallet,size: 60,color: Colors.black,)
                                            )
                                          ]
                                      ),
                                      new Container(
                                          child:Text('门诊记录',style: TextStyle(fontSize: 18),)
                                      )
                                    ]

                                )
                            ),
                          ),
                          new Expanded(
                            child: new Container(
                                child: Column(


                                    children: <Widget>[
                                      new Stack(
                                          children: <Widget>[
                                            SizedBox(
                                                height: 82,
                                                width: 82,
                                                child:Card(
                                                  elevation: 15.0, //阴影
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                      side: BorderSide(width: 1.0)),
                                                )
                                            ),
                                            new Container(
//                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(10),
                                                child: Icon(Icons.edit,size: 60,color: Colors.black,)
                                            )
                                          ]
                                      ),
                                      new Container(
                                          child:Text('侵入型器械检查',style: TextStyle(fontSize: 18),)
                                      )
                                    ]

                                )
                            ),
                          )
                        ]
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                                child: Column(


                                    children: <Widget>[
                                      new Stack(
                                          children: <Widget>[
                                            SizedBox(
                                                height: 82,
                                                width: 82,
                                                child:Card(
                                                  elevation: 15.0, //阴影
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                      side: BorderSide(width: 1.0)),
                                                )
                                            ),
                                            new Container(
//                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(10),
                                                child: Icon(Icons.redeem,size: 60,color: Colors.black,)
                                            )
                                          ]
                                      ),
                                      new Container(
                                          child:Text('住院病历',style: TextStyle(fontSize: 18),)
                                      )
                                    ]

                                )
                            ),
                          ),
                          new Expanded(
                            child: new Container(
                                child: Column(


                                    children: <Widget>[
                                      new Stack(
                                          children: <Widget>[
                                            SizedBox(
                                                height: 82,
                                                width: 82,
                                                child:Card(
                                                  elevation: 15.0, //阴影
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                      side: BorderSide(width: 1.0)),
                                                )
                                            ),
                                            new Container(
//                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(10),
                                                child: Icon(Icons.flare,size: 60,color: Colors.black,)
                                            )
                                          ]
                                      ),
                                      new Container(
                                          child:Text('化验检查',style: TextStyle(fontSize: 18),)
                                      )
                                    ]

                                )
                            ),
                          ),
                          new Expanded(
                            child: new Container(
                                child: Column(


                                    children: <Widget>[
                                      new Stack(
                                          children: <Widget>[
                                            SizedBox(
                                                height: 82,
                                                width: 82,
                                                child:Card(
                                                  elevation: 15.0, //阴影
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                      side: BorderSide(width: 1.0)),
                                                )
                                            ),
                                            new Container(
//                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(10),
                                                child: Icon(Icons.opacity,size: 60,color: Colors.black,)
                                            )
                                          ]
                                      ),
                                      new Container(
                                          child:Text('病理学检查',style: TextStyle(fontSize: 18),)
                                      )
                                    ]

                                )
                            ),
                          )
                        ]
                    ),
                  )
                ]
            ),
          ),
        )
    );

    return new Scaffold(
      appBar: new AppBar(
        title: Text('主页',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: new Column(
        children: <Widget>[stack,ChooseModel],
      ),
      bottomNavigationBar:BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.black,size: 40,),title: Text('查询',style: TextStyle(fontSize: 22),)),
            BottomNavigationBarItem(icon: Icon(Icons.pages,color: Colors.black,size: 40),title: Text('主页',style: TextStyle(fontSize: 22),)),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle,color: Colors.black,size: 40),title: Text('我的',style: TextStyle(fontSize: 22),))
          ]
      ),
    );
  }
}