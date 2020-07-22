import 'package:flutter/material.dart';
import 'package:helloworld/File_Method.dart';
void main() =>runApp(new register2());

class register2 extends StatefulWidget{
  @override
  State createState() => new _register2();
}

class _register2 extends State<register2> {
  File_Method file_method = new File_Method();
  String name;
  String IdCardNumber;



  @override
  Widget build(BuildContext context) {
    Widget BasicInfo = new Container(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
      child:Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '基础信息',
              style: TextStyle(fontSize: 25),
            ),
            Divider(
              thickness: 2,
            ),

                  TextField(
                    decoration: new InputDecoration(
                      labelText: '请输入您的姓名',
                      labelStyle: new TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 93, 93, 93)
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value){
                      name = value;
                    },
                  ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的身份证号',
                    labelStyle: new TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 93, 93, 93)
                    ),
                    border: InputBorder.none
                  ),
                  onChanged: (value){
                     IdCardNumber= value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  children: <Widget>[
                    Text('证件照:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: file_method.img_upload(),
                          color: Colors.blue,
                          child:new Text(
                              '上传照片',
                              style:TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Text('身份证正反面照片:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: file_method.img_upload(),
                          color: Colors.blue,
                          child:new Text(
                              '上传照片',
                              style:TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )
                    ),
                  ],
                ),

                new Row(
                  children: <Widget>[
                    Text('医师资格证:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: file_method.img_upload(),
                          color: Colors.blue,
                          child:new Text(
                              '上传照片',
                              style:TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Text('医师执业证:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: file_method.img_upload(),
                          color: Colors.blue,
                          child:new Text(
                              '上传照片',
                              style:TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Text('医师职称证书:', style:TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(left: 30),
                        child:RaisedButton(
                          elevation: 0,
                          onPressed: file_method.img_upload(),
                          color: Colors.blue,
                          child:new Text(
                              '上传照片',
                              style:TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Container(
                  child:Text('专业特长:',style:TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),)),
                ),
                TextField(),
                Container(
                  child:Text('医师简介:',style:TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),)),
                ),
                TextField()
              ],
        ),
      )
    );

    Widget ok = new Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          color: Colors.blue,
          child: new Text(
            '确定',
            style: TextStyle(
                fontSize: 20.0, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
        ),
      ),
    );
    return new MaterialApp(
      title: '医生注册2',
      home: new Scaffold(
        appBar:new AppBar(
          title: Text(
            '信息录入',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
          body: new ListView(
            children: <Widget>[
              BasicInfo,ok
            ],
          ),

          ),
    );
  }

}