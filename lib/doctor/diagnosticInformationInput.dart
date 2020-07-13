import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: DiagnosticInformationInput(),
));

class DiagnosticInformationInput extends StatefulWidget {
  @override
  _DiagnosticInformationInput createState() => new _DiagnosticInformationInput();
}


class _DiagnosticInformationInput extends State<DiagnosticInformationInput> {
  GlobalKey<FormState> submitKey = new GlobalKey<FormState>();
  String patientName;
  String patientSex;
  String patientNation;
  String patientPhoneNumber;
  String patientID;
  String longlonglongText;

  void submit(){
    //读取当前的Form状态
    var submitForm = submitKey.currentState;
//    submitForm.save();
    print(patientName);
    print(patientSex);
    print(patientPhoneNumber);
    print(patientID);
    print(longlonglongText);
    //验证Form表单
//    if(submitForm.validate()){
//      submitForm.save();
//      print(patientName+'/n'+patientSex+'/n'+patientID+'/n'+patientPhoneNumber+'/n'+patientNation+'/n'+longlonglongText);
//    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget BasicInfo = Container(
      padding: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('患者基本信息填写:',textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
              ],
            ),
            new Divider(),
            new TextFormField(
              decoration: new InputDecoration(
                labelText: '请输入姓名',
                labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none
                // suffixIcon: new IconButton(
                //   icon: new Icon(
                //     Icons.close,
                //     color: Color.fromARGB(255, 126, 126, 126),
                //   ),
                //   onPressed: () {

                //   },
                // ),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                patientName = value;
              },
//              validator: (value) {
//              },
//              onFieldSubmitted: (value) {
//                patientName = value;
//              },
            ),
            new TextFormField(
              decoration: new InputDecoration(
                  labelText: '请输入性别',
                  labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none
                // suffixIcon: new IconButton(
                //   icon: new Icon(
                //     Icons.close,
                //     color: Color.fromARGB(255, 126, 126, 126),
                //   ),
                //   onPressed: () {

                //   },
                // ),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                patientSex = value;
              },
//              validator: (value) {
//              },
//              onFieldSubmitted: (value) {
//              },
            ),
            new TextFormField(
              decoration: new InputDecoration(
                  labelText: '请输入民族',
                  labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none
                // suffixIcon: new IconButton(
                //   icon: new Icon(
                //     Icons.close,
                //     color: Color.fromARGB(255, 126, 126, 126),
                //   ),
                //   onPressed: () {

                //   },
                // ),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                patientNation = value;
              },
//              validator: (value) {
//              },
//              onFieldSubmitted: (value) {
//              },
            ),
            new TextFormField(
              decoration: new InputDecoration(
                  labelText: '请输入手机号',
                  labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none
                // suffixIcon: new IconButton(
                //   icon: new Icon(
                //     Icons.close,
                //     color: Color.fromARGB(255, 126, 126, 126),
                //   ),
                //   onPressed: () {

                //   },
                // ),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                patientPhoneNumber = value;
              },
//              validator: (value) {
//              },
//              onFieldSubmitted: (value) {
//              },
            ),
            new TextFormField(
              decoration: new InputDecoration(
                  labelText: '请输入身份证号',
                  labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none
                // suffixIcon: new IconButton(
                //   icon: new Icon(
                //     Icons.close,
                //     color: Color.fromARGB(255, 126, 126, 126),
                //   ),
                //   onPressed: () {

                //   },
                // ),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                patientID = value;
              },
//              validator: (value) {
//              },
//              onFieldSubmitted: (value) {
//              },
            ),
          ],
        ),
      ),
    );

    Widget advise = Container(
      padding: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('诊疗结果及健康建议:',style: TextStyle(fontSize: 18),)
              ],
            ),
            new TextFormField(
              maxLines: 10,
              decoration: new InputDecoration(
//                  labelText: '请输入诊疗结果及健康建议:',
//                  labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 0.5)
                  )
                // suffixIcon: new IconButton(
                //   icon: new Icon(
                //     Icons.close,
                //     color: Color.fromARGB(255, 126, 126, 126),
                //   ),
                //   onPressed: () {

                //   },
                // ),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                longlonglongText = value;
              },
              validator: (value) {
              },
              onFieldSubmitted: (value) {
              },
            ),
          ],
        ),
      ),
    );

    Widget botton = Container(
      padding: EdgeInsets.all(0),
      height: 50.0,
      margin: EdgeInsets.only(bottom: 20,left: 20,right: 20),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 20,
          onPressed: submit,
          color: Colors.blue,
          child: new Text(
            '确定',
            style: TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 255, 255, 255)
            ),
          ),
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '诊断信息录入'
        ),
      ),
      body: ListView(
        children: <Widget>[
          BasicInfo,
          advise,
          botton
        ],
      ),
    );
  }
}
