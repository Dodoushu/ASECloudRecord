import 'package:flutter/material.dart';

class BottomNavigationBarClass{
  BottomNavigationBar Create()
  {
    return  new BottomNavigationBar(
    items:  <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.black,size: 40,),title: Text('查询',style: TextStyle(fontSize: 22),)),
    BottomNavigationBarItem(icon: Icon(Icons.pages,color: Colors.black,size: 40),title: Text('主页',style: TextStyle(fontSize: 22),)),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle,color: Colors.black,size: 40),title: Text('我的',style: TextStyle(fontSize: 22),))
    ]
    );
  }
}