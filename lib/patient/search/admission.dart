import 'package:flutter/material.dart';

class admission extends StatefulWidget {
  admission({Key key, @required this.contentlist}) : super(key: key) {
    this.contentlist = contentlist;
  }

  List contentlist;

  @override
  _admissionState createState() =>
      new _admissionState(contentlist: contentlist);
}

class _admissionState extends State<admission> {
  _admissionState({@required List contentlist}) {
    this.contentlist = contentlist;
  }

  List contentlist;

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    List<Widget> contentCardBuilder() {
      List<Widget> returnList = new List<Widget>();
      for (Map temp in contentlist) {
        Widget contentCard = Container(
          padding: EdgeInsets.only(
            top: 7, bottom: 3
          ),
            child: new Card(
              margin: EdgeInsets.only(
                right: width_ * 0.03,
                left: width_ * 0.03,
              ),
              child: Container(
                  margin: EdgeInsets.only(
                    right: width_ * 0.03,
                    left: width_ * 0.03,
                      top: 15,
                      bottom: 15
                  ),
                  child: Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '开始日期：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                              temp['s_date']!=null? temp['s_date'] : '无',
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '结束日期：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['o_date']!=null? temp['o_date'] : '无',
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '就诊科室：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['department_treatment'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '就诊医院：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['hospital'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '医生姓名：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['doctor_name'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '住院病历内容：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['admission_info'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  )),
            ));
        returnList.add(contentCard);
      }
      return returnList;
    }

//    Widget contentCard = new Container(
//      width: width_*0.95,
//      child: new Column(
//        children: contentCardBuilder(),
//      ),
//    );

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          '门诊信息',
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
