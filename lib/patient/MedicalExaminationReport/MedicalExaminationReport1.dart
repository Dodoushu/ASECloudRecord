import 'package:flutter/material.dart';
import '';
import '../BottomNavigationBar.dart';
void main() => runApp(new ReportPage());

class ReportPage extends StatefulWidget{
  @override
  State createState() => new _ReportPage();
}
class _ReportPage extends State<ReportPage> {

  BottomNavigationBarClass bottomNavigationBarClass = new BottomNavigationBarClass();

  Widget date = new SizedBox(
      height: 60,
    child: new Card(
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          Text('日期：2020-06-09',style: TextStyle(fontSize: 20),),
          Container(
            margin: EdgeInsets.only(left: 200),
              child:Icon(Icons.arrow_forward_ios,size: 15,),
          )
        ],
      ),
    ),
  );

  Widget hospital = new SizedBox(
    height: 60,
    child: new Card(
      color: Colors.white,
      child: new Container(
          child:Text('体检医院或机构：414医院',style: TextStyle(fontSize: 20),),
        alignment: Alignment.centerLeft,
      ),
    ),
  );

  Widget judge = new SizedBox(
    height: 60,
    child: new Card(
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          Text('体检主要结论或诊断',style: TextStyle(fontSize: 20),),
          Container(
            margin: EdgeInsets.only(left: 200),
            child:Icon(Icons.arrow_forward_ios,size: 15,),
          )
        ],
      ),
    ),
  );

  Widget summary = new SizedBox(
    height: 150,
    child: new Card(
      color: Colors.white,
      child: new Column(
        //mainAxisAlignment:
        children: <Widget>[
          new Container(
            child:Text('体检摘要：',style: TextStyle(fontSize: 20),),
            alignment: Alignment.centerLeft,
          ),
          new Container(
              child:TextField(
                keyboardType: TextInputType.multiline,
                autofocus: true,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical:40,horizontal:5 ),
                  hintText: '请输入',
                  hintMaxLines: 5,
                  border:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  )
                ),
              )
          )
        ],
      ),
    )
  );
  
  Widget FileUpload = new GestureDetector(
      onTap: (){
        //上传图片
      },
      child:new SizedBox(
          height: 60,
          child: new Card(
            color: Colors.white,
            child: new Row(
              children: <Widget> [
                Text('文件上传',style: TextStyle(fontSize: 20)),
                new Container(
                    padding: EdgeInsets.only(left: 200),
                    child:SizedBox(
                      height: 50,
                      width: 110,
                      child: Card(
                        color: Colors.black12,
                        child: Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Row(
                            children: <Widget>[
                              Text('上传',style: TextStyle(fontSize: 16)),
                              Icon(Icons.cloud_upload,size: 20),
                            ],
                          ),
                        ),
                      ),
                    )
                )

              ],
            ),
          )
      ),
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '健康体检报告',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text(
            '健康体检报告',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: Icon(Icons.arrow_back_ios,size: 25),
        ),
        body: new ListView(
          children: <Widget>[
              date,
            hospital,
            judge,
            summary,
            FileUpload,
          ],
        ),
        bottomNavigationBar: bottomNavigationBarClass.Create(),
      )

    );
  }


}