import 'package:flutter/material.dart';
import 'MainFunctionPage.dart';


void main() {
  runApp(MaterialApp(
    home: BottomNavigationWidget(),
  ));
}

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int currentIndex = 0;
//  List listTabs = [MainPage(), SearchPage(), Setting()];
  List listTabs = [MainPage(), ]; //setting()

  Widget build(BuildContext context) {
    return Scaffold(
      body: listTabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        iconSize: 30,
//        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
                color: Colors.black,
              ),
              title: Text(
                '主页',
                style: TextStyle(
                  fontSize: 18,
                ),
              )),
//          BottomNavigationBarItem(
//              icon: Icon(
//                Icons.search,
//                color: Colors.black,
//              ),
//              title: Text(
//                '查询',
//                style: TextStyle(fontSize: 18),
//              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.build, color: Colors.black),
              title: Text(
                '设置',
                style: TextStyle(fontSize: 18),
              ))
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          print(index);
        },
      ),
    );
  }
}