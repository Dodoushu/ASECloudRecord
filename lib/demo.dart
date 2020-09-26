import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/select.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'dart:core';

void main() {
  runApp(
    new MaterialApp(
      title: 'demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new demo(),
    ),
  );
}

class demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget demoBotton = new Container(
      height: 50.0,
      margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 20),
      child: new RaisedButton(
        color: Colors.red,
        child: new Text('demo'),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
        onPressed: () async{
          Map<String, dynamic> data = Map();
          var url = "http://39.100.100.198:8082/selectDAP";
          data['phone_num'] = '12121314';
          var formData = data;
          print(data);
          await request(url, FormData: formData).then((value){
            data = json.decode(value.toString());
            print(data);
          });
        },
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(''),
      ),
      body: ListView(
        children: <Widget>[
          demoBotton
        ],
      ),
    );
  }
}