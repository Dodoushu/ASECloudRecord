import 'package:flutter/material.dart';
import 'Search_Result.dart';

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

    List<Widget> contentCardBuilder() {
      List<Widget> returnList = new List<Widget>();
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
