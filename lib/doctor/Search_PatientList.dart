import 'package:flutter/material.dart';
import 'Search_Result.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:helloworld/sharedPrefrences.dart';

class Search_PatientList extends StatefulWidget {
  Search_PatientList({Key key, @required this.contentlist}) : super(key: key) {
    this.contentlist = contentlist;
  }

  List contentlist;

  @override
  _Search_PatientListState createState() =>
      new _Search_PatientListState(contentlist: contentlist);
}

class _Search_PatientListState extends State<Search_PatientList> {
  _Search_PatientListState({@required List contentlist}) {
    this.contentlist = contentlist;
  }

  List contentlist;
  TextStyle titleStyle = TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.normal);
  TextStyle contentStyle = TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    List<Widget> contentCardBuilder() {
      List<Widget> returnList = new List<Widget>();

      String returnSex(int x){
        if(x==0){
          return '男';
        }else{
          return '女';
        }
      }

      int returnAge(String birthday){
        DateTime now = DateTime.now();
        DateTime birth = DateTime.parse(birthday);
        return (now.difference(birth).inDays/365).round();
      }

      for(Map temp in contentlist){
        Widget contentCard = new InkWell(
            onTap: (){
              var bodymap = Map();
              String phoneNum;
              SharedPreferenceUtil.getString('phoneNum')
                  .then((value) async {
                phoneNum = value;
//                                  bodymap['phone_num'] = phoneNum;
                bodymap['phone_num'] = '12121314';
                print(
                    '*******************************************************');
                print(bodymap);
                var url =
                    "http://39.100.100.198:8082/Select/outPatientRecords";
                var formData = bodymap;
                await request(url,context, FormData: formData)
                    .then((value) {
                  var data = json.decode(value.toString());
                  log(data['outPatientRecords'].toString());

                  var url = new List();
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => outPatientRecords(contentlist: data['outPatientRecords'],)));

                });
              });
            },
            child:new Container(
          width: width_,
          child: Container(
            decoration: new BoxDecoration(
              border: new Border.all(width: 0.5,color: Colors.grey)
            ),
            padding: EdgeInsets.only(top:15,bottom: 15,left: 20, right: 20),
            width: width_*0.95,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child:Icon(Icons.assignment_ind,size: 50,)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 90,padding: EdgeInsets.only(right: 10),child:Text(temp['name'],style: contentStyle,),),
                        Container(width: 30,padding: EdgeInsets.only(right: 10),child:Text(returnSex(temp['sex']),style: contentStyle,),),
                        Container(width: 50,padding: EdgeInsets.only(right: 10),child:Text(returnAge(temp['birthday']).toString()+'岁',style: contentStyle,),),
                        Container(width: 110,padding: EdgeInsets.only(right: 10),child:Text(temp['birthday'],style: contentStyle,))
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('电话号码：'+temp['phone_num'],style: contentStyle,),
                        Text('')
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
        returnList.add(contentCard);
      }

      return returnList;
    }


    return Scaffold(
      appBar: new AppBar(
        title: Text(
          '患者列表',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: new ListView(
        children: contentCardBuilder(),
      ),
    );
  }
}
