import 'package:flutter/material.dart';
import 'BottomNavigationBar.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'package:helloworld/showAlertDialogClass.dart';
import 'pictureGridview.dart';


void main(){
  runApp(new MaterialApp(
    title: '用户查询页面',
    home: new SearchPage(),
  ));
}


class WidgetBuild {
  Container create(String text, IconData icondata,Color truecolor){
    return new Container(
      child:SizedBox(
        height: 60,
        width: 350,
        child: Card(
          color: Colors.white,
          child: new Stack(
            children: <Widget>[
              new Align(
                child: new Stack(
                    children: <Widget>[
                      SizedBox(
                          height: 48,
                          width: 48,
                          child:Card(
                              color: truecolor,
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(100.0)),
                              side: BorderSide(width: 1.0)),
                              child: new Center(
                                  child: Icon(icondata,size: 28,color: Colors.white,)
                              )
                          )
                      ),
                    ]
                ),
                alignment: Alignment.centerLeft,
              ),
              new Positioned(
                  child: new Text(
                      text,
                      style: TextStyle(fontSize: 18)
                  ),
                  top: 10,
                  left: 50,
              ),
              new Align(
                  child: Icon(Icons.arrow_forward_ios,size: 18,),
                alignment: Alignment.centerRight,
              )
            ],
          ),
        ),
      )
    );
  }
}

class SearchPage extends StatelessWidget{

  BottomNavigationBarClass Bottom_NavigationBar = new BottomNavigationBarClass();
  WidgetBuild _widgetBuild = new WidgetBuild();
  @override
  Widget build(BuildContext context) {
    Widget stack = new Stack(
      alignment: Alignment.topCenter,
      children: <Widget> [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          width: double.infinity,
          height: 135,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 460,
            width: 600,
              child: Card(
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    side: BorderSide(width: 1.0),

                  ),
                  child: new Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap:() async{
                            var bodymap = Map();
                            String phoneNum;
                            SharedPreferenceUtil.getString('phoneNum').then((value) async{
                                  phoneNum = value;
                                  bodymap['phone_num'] = phoneNum;
                                  print('*******************************************************');
                                  print(bodymap);
                                  var url = "http://39.100.100.198:8082/Select/AllPicture";
                                  var formData = bodymap;
                                  await request(url, FormData: formData).then((value) {
                                    var data = json.decode(value.toString());
                                    print(data);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>PictureView(PictureInfo: data['textInfo'][0]['address'],)));
//                                    showAlertDialog(context,titleText: '',contentText: data['textInfo'][0]['address'].toString());
                                  });
                            });
                          },
                          child:_widgetBuild.create("全部图片浏览", Icons.photo_library, Colors.amberAccent),
                        ),
                        _widgetBuild.create("健康体检报告查询", Icons.inbox, Colors.deepPurple),
                        _widgetBuild.create("诊断名称查询", Icons.receipt, Colors.tealAccent),
                        _widgetBuild.create("门诊记录查询", Icons.web, Colors.orange),
                        _widgetBuild.create("住院记录查询", Icons.accessible, Colors.brown),
                        _widgetBuild.create("检查项目查询", Icons.description, Colors.lightGreen),
                        _widgetBuild.create("重点关注检查项目查询", Icons.date_range, Colors.blueAccent),

                      ],
                    ),
                  )
            )
          ),
        )
      ],
    );
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          '用户查询',
              style:TextStyle(color: Colors.white),
        ),
        centerTitle: true,
//        backgroundColor: Colors.blue,
        leading: Icon(Icons.arrow_back_ios,size: 25,),
      ),
      body:new ListView(
        children: <Widget>[
          stack,
        ],
      ),

      bottomNavigationBar: Bottom_NavigationBar.Create(),
    );

  }

}
