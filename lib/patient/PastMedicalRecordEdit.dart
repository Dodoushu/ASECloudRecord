import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: pastMedicalRecordEdit(),
    ));

class pastMedicalRecordEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text;
    return new Scaffold(
      //顶栏
      appBar: new AppBar(
        title:
            Text('既往病史', style: TextStyle(color: Colors.white, fontSize: 25)),
        centerTitle: true,
//        backgroundColor: Colors.blue,
        leading: new Icon(
          Icons.arrow_back_ios,
          size: 25,
        ),
      ),
      body: new ListView(
        children: <Widget>[
          Container(
            padding:EdgeInsets.all(10),
            child:Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '病史描述',
                style: TextStyle(fontSize: 25),
              )
            ],
          ),),
          Divider(
            thickness: 1,
          ),
          Card(
            margin: EdgeInsets.all(10),
            child: Container(
              padding:EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
              child: TextField(
                decoration: new InputDecoration(
                  labelText: '请输入您的病史描述',
                  labelStyle: new TextStyle(
                      fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none,
                ),
                maxLines: 5,
                onChanged: (value) {
                  text = value;
                },
              ),
            ),
          ),
          //new Divider(),
          new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
            height: 50.0,
            margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
            child: new SizedBox.expand(
              child: new RaisedButton(
                elevation: 0,
                onPressed: () {
                  Navigator.pop(context, text);
                },
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
          )
        ],
      ),
    );
  }
}
