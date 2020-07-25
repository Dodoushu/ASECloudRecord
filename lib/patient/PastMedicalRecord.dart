import 'package:flutter/material.dart';
import 'BottomNavigationBar.dart';

void main(){
  runApp(new MaterialApp(
    title: "既往病史",
    home: new PastRecord(),
  ));
}

class WidgetBulld{

  Expanded create(String text, IconData icondata)
  {
    return Expanded(
      child: new Container(
         padding: EdgeInsets.only(top: 20),
          child: Column(


              children: <Widget>[
                new Stack(
                    children: <Widget>[
                      SizedBox(
                          height: 70,
                          width: 70,
                          child:Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                side: BorderSide(width: 1.0)),
                              child: new Center(
                                  child: Icon(icondata,size: 45,color: Colors.black,)
                              )
                          )
                      ),
                    ]
                ),
                new Container(
                    child:Text(
                        text,
                        textAlign: TextAlign.center,//overflow:TextOverflow.ellipsis,
                        style:TextStyle(fontSize: 16)
                        ))

              ]
      )
    )
    );
  }
  }


class PastRecord extends StatelessWidget{
  WidgetBulld widgetbuild = new WidgetBulld();
  BottomNavigationBarClass Bottom_NavigationBar = new BottomNavigationBarClass();
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      //顶栏
      appBar: new AppBar(
        title: Text('既往病史',style: TextStyle(color:Colors.white,fontSize: 25)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: new Icon(Icons.arrow_back_ios,size: 25,),
      ),

      //主题图标
      body:new ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
          height: 660,
          width: 390,
          child: Card(
            elevation: 15.0, //阴影
            //设置圆角和边框
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.0)),
                side: BorderSide(width: 1.0)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      child: Row(
                          children: <Widget>[
                            widgetbuild.create("神经系统", Icons.receipt),
                            widgetbuild.create("心血管系统", Icons.radio_button_checked),
                            widgetbuild.create("呼吸系统", Icons.colorize),
                            widgetbuild.create("消化系统", Icons.opacity),
                          ]
                      )
                  ),

                  new Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widgetbuild.create("内分泌代谢系统", Icons.data_usage),
                          widgetbuild.create("血液系统", Icons.favorite),
                          widgetbuild.create("泌尿系统", Icons.scatter_plot),
                          widgetbuild.create("男性生殖系统", Icons.accessibility),
                        ]
                    ),
                  ),
                  new Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widgetbuild.create("女性生殖系统", Icons.pregnant_woman),
                          widgetbuild.create("骨骼肌肉系统", Icons.account_balance),
                          widgetbuild.create("免疫系统", Icons.flare),
                          widgetbuild.create("眼科疾病", Icons.remove_red_eye),
                        ]
                    ),
                  ),
                  new Container(

                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widgetbuild.create("口腔牙齿疾病", Icons.fiber_smart_record),
                          widgetbuild.create("耳眼鼻喉头颈部疾病", Icons.hearing),
                          widgetbuild.create("皮肤病", Icons.directions_walk),
                          widgetbuild.create("外科疾病", Icons.hdr_weak),
                        ]
                    ),
                  ),
                  new Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: widgetbuild.create("其他病史", Icons.bubble_chart),
                  ),
                ]
            ),
          ),
        )],

      ),
      //底栏
      bottomNavigationBar:Bottom_NavigationBar.Create()
    );
 }
}