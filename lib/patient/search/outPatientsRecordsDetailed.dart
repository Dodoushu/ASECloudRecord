import 'package:flutter/material.dart';


class outPatientRecordsDetailed extends StatefulWidget {
  outPatientRecordsDetailed({Key key, @required this.contentlist}) : super(key: key) {
    this.contentlist = contentlist;
  }

  List contentlist;

  @override
  _outPatientRecordsState createState() =>
      new _outPatientRecordsState(contentlist: contentlist);
}

class _outPatientRecordsState extends State<outPatientRecordsDetailed> {
  _outPatientRecordsState({@required List contentlist}) {
    this.contentlist = contentlist;
  }

  TextStyle titleStyle = TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.normal);
  TextStyle contentStyle = TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal);

  Widget dividedBox = SizedBox(
    height: 10,
  );

  List contentlist;

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    List<Widget> buildMedicine(List list){
      List<Widget> ans = new List();
      for(Map temp in list){
        ans.add(Text(temp['medicine_name']+','+temp['medicine_method']+','+temp['time'],style: contentStyle,
            ));
      }
    }

    List<Widget> medicineListBuilder(List list){
      List<Widget> returnList = new List<Widget>();
      for (Map temp in list) {
        Widget contentCard = Container(
          child: new Container(
            child: Container(
              child: Column(
                children: <Widget>[
                  new Column(
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '药物名称：',
                            style: titleStyle,
                          ),
                          Text(
                            temp['medicine_name'],
                            style: contentStyle,
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '使用方法：',
                            style: titleStyle,
                          ),
                          Text(
                            temp['medicine_method'],
                            style: contentStyle,
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '使用频率：',
                            style: titleStyle,
                          ),
                          Text(
                            temp['time'],
                            style: contentStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),
        );
        returnList.add(contentCard);
      }
      return returnList;
    }


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
                padding: EdgeInsets.only(left: 10, right: 10),
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
                            '就诊医院：',
                            style: titleStyle,
                          ),
                          Text(
                            temp['hospital']!=null? temp['hospital'] : '无',
                            style: contentStyle,
                          ),
                        ],
                      ),
                      dividedBox,
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '就诊科室：',
                            style: titleStyle,
                          ),
                          Text(
                            temp['department_treatment'],
                            style: contentStyle,
                          ),
                        ],
                      ),
                      dividedBox,
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '医生姓名：',
                            style: titleStyle,
                          ),
                          Text(
                            temp['doctor_name'],
                            style: contentStyle,
                          ),
                        ],
                      ),
                      dividedBox,
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '检查日期：',
                            style: titleStyle,
                          ),
                          Text(
                            temp['date'].substring(0, 10),
                            style: contentStyle,
                          ),
                        ],
                      ),
                      dividedBox,
                      Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '就诊内容：',
                                style: titleStyle,
                              ),
                              Text(
                                 '',
                                style: contentStyle,
                              ),
                            ],
                          ),
                          dividedBox,
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: width_*0.8,
                              child: Text(
                                temp['treating_info']!=null? temp['treating_info'] : '无',
                                style: contentStyle,
                                textAlign: TextAlign.left,
                              ),
                            )
                          )
                        ],
                      ),
                      dividedBox,

                      Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '诊断内容：',
                                style: titleStyle,
                              ),
                              Text(
                                '',
                                style: contentStyle,
                              ),
                            ],
                          ),
                          dividedBox,
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                width: width_*0.8,
                                child: Text(
                                  temp['treat_info']!=null? temp['treat_info'] : '无',
                                  style: contentStyle,
                                  textAlign: TextAlign.left,
                                ),
                              )
                          )
                        ],
                      ),
                      dividedBox,

                      Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '检查项目：',
                                style: titleStyle,
                              ),
                              Text(
                                '',
                                style: contentStyle,
                              ),
                            ],
                          ),
                          dividedBox,
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                width: width_*0.8,
                                child: Text(
                                  temp['treat_items']!=null? temp['treat_items'] : '无',
                                  style: contentStyle,
                                  textAlign: TextAlign.left,
                                ),
                              )
                          )
                        ],
                      ),
                      dividedBox,

                      Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '非药物治疗方案：',
                                style: titleStyle,
                              ),
                              Text(
                                '',
                                style: contentStyle,
                              ),
                            ],
                          ),
                          dividedBox,
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                width: width_*0.8,
                                child: Text(
                                  temp['treat_methods']!=null? temp['treat_methods'] : '无',
                                  style: contentStyle,
                                  textAlign: TextAlign.left,
                                ),
                              )
                          )
                        ],
                      ),
                      dividedBox,

                      Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '用药方案：',
                                style: titleStyle,
                              ),
                              Text(
                                '',
                                style: contentStyle,
                              ),
                            ],
                          ),
                          dividedBox,
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                width: width_*0.8,
                                child: Text(
                                  temp['treat_methods']!=null? temp['treat_methods'].toString() : '无',
                                  style: contentStyle,
                                  textAlign: TextAlign.left,
                                ),
                              )
                          )
                        ],
                      ),

                      dividedBox,
                      new Container(
                        padding: EdgeInsets.only(right: 10,left: 10),
                        child: Column(
                          children: medicineListBuilder(temp['medicines'])!=null?medicineListBuilder(temp['medicines']) : <Widget>[    new Text('无',
                                style: new TextStyle(
                                  fontSize: 18,
                                ),

                              )],
                        ),
                      )
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
          '门诊详细记录',
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
