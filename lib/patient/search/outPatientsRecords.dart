import 'package:flutter/material.dart';
import 'outPatientsRecordsDetailed.dart';

class outPatientRecords extends StatefulWidget {
  outPatientRecords({Key key, @required this.contentlist}) : super(key: key) {
    this.contentlist = contentlist;
  }

  List contentlist;

  @override
  _outPatientRecordsState createState() =>
      new _outPatientRecordsState(contentlist: contentlist);
}

class _outPatientRecordsState extends State<outPatientRecords> {
  _outPatientRecordsState({@required List contentlist}) {
    this.contentlist = contentlist;
  }

  bool getDayDifference(String time, int days) {
    var birthday = DateTime.parse(time);
    var date2 = DateTime.now();
    int difference = date2.difference(birthday).inDays;
    return difference < days ? true : false;
  }

  TextStyle titleStyle = TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal);
  TextStyle contentStyle = TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal);


  var _value = 0;
  List contentlist;
  Map<int, int> valueToDays = {0: 999999, 1: 90, 2: 180, 3: 365, 4: 365 * 3};
  int selectedDays = 999999;

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    Widget timeSelecter = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new Text(
            '时间范围：',
            style: new TextStyle(
//                      color: Colors.,
//                      fontWeight: FontWeight.,
              fontSize: 22,
            ),
          ),
          DropdownButton(
              isExpanded: false,
              value: _value,
              items: [
                DropdownMenuItem(
                  child: Text(
                    '全部',
                    style: new TextStyle(
//                      color: Colors.,
//                      fontWeight: FontWeight.,
                      fontSize: 18,
                    ),
                  ),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text(
                    '近三个月',
                    style: new TextStyle(
//                      color: Colors.,
//                      fontWeight: FontWeight.,
                      fontSize: 18,
                    ),
                  ),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text(
                    '近半年',
                    style: new TextStyle(
//                      color: Colors.,
//                      fontWeight: FontWeight.,
                      fontSize: 18,
                    ),
                  ),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text(
                    '近一年',
                    style: new TextStyle(
//                      color: Colors.,
//                      fontWeight: FontWeight.,
                      fontSize: 18,
                    ),
                  ),
                  value: 3,
                ),
                DropdownMenuItem(
                  child: Text(
                    '近三年',
                    style: new TextStyle(
//                      color: Colors.,
//                      fontWeight: FontWeight.,
                      fontSize: 18,
                    ),
                  ),
                  value: 4,
                ),
              ],
              icon: Icon(
                Icons.keyboard_arrow_down,
              ),
              iconSize: 20,
              onChanged: (value) {
                setState(() {
                  _value = value;
                  selectedDays = valueToDays[value];
                });
              }),
//          RaisedButton(
//            color: Colors.blue,
//            // 按钮背景色
//            highlightColor: Colors.blue[700],
//            // 按钮高亮后的背景色
//            colorBrightness: Brightness.dark,
//            // 使用深色主题，保证按钮文字颜色为浅色
//            splashColor: Colors.grey,
//            // 点击时，水波动画中水波的颜色
//            child: Text(
//              "查询",
//              style: new TextStyle(
////                      color: Colors.,
////                      fontWeight: FontWeight.,
//                fontSize: 20,
//              ),
//            ),
//            // 文本
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(12.0)),
//            //圆角矩形
//            onPressed: () {},
//          )
        ],
      ),
    );

    List<Widget> contentCardBuilder() {
      List<Widget> returnList = new List<Widget>();
//      returnList.add(timeSelecter);
      for (Map temp in contentlist) {
        Widget contentCard = Container(
            padding: EdgeInsets.only(top: 7, bottom: 3),
            child: InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => outPatientRecordsDetailed(contentlist: [temp],)));
              },
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
                      bottom: 15),
                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: width_ * 0.30,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                temp['hospital'] != null
                                    ? temp['hospital']
                                    : '无',
                                style: titleStyle,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 8,
                            ),
                            Text(temp['date'].substring(0, 10),
                                style: titleStyle,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.grey),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 18),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("就诊科室：" + temp['department_treatment'],
                                style: titleStyle,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 8,
                            ),
                            Text("医生姓名：" + temp['doctor_name'],
                                style: titleStyle,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      )
                    ],
                  )),
            )));
        if (getDayDifference(temp['date'].substring(0, 10), selectedDays)) {
          returnList.add(contentCard);
        }
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
          '门诊病历查询',
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
