import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
void main() => runApp(ChangePhNum());

class ChangePhNum extends StatefulWidget{
  @override
  _ChangePhNum createState() => _ChangePhNum();

}
class _ChangePhNum extends State<ChangePhNum> {
  GlobalKey<FormState> ChangePhNumKey = new GlobalKey<FormState>();
  String OldNumber;
  String NewNumber;
  String Verification_Code;

  void ChangePhNum() async{
    var ChangePhNumForm = ChangePhNumKey.currentState;
    if(ChangePhNumForm.validate())
    {
      Map<String,dynamic> map = {
        'OldPhoneNumber':OldNumber
        //NewNumber
        //Verification_Code
        //验证对错，给出文字提示
      };
      var bodymap = Map();
      bodymap['OldPhoneNumber'] = OldNumber;
      var url = "http://101.133.228.14:8081/config?";
      http.post(url,body: bodymap).then((response) {

      });

    }
  }

  // 计时器函数和变量----------------------------
  bool isButtonEnable = true; //按钮状态  是否可点击
  String buttonText = '发送验证码'; //初始文本
  int count = 60; //初始倒计时时间
  Timer timer; //倒计时的计时器
  TextEditingController mController = TextEditingController();

  void _buttonClickListen() {
    setState(() {
      if (isButtonEnable) {
        //当按钮可点击时
        isButtonEnable = false; //按钮状态标记
        _initTimer();

        return null; //返回null按钮禁止点击
      } else {
        //当按钮不可点击时
//        debugPrint('false');
        return null; //返回null按钮禁止点击
      }
    });
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isButtonEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '重新发送($count)'; //更新文本内容
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    mController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '修改手机号',
      home: new Scaffold(
          appBar: AppBar(
            title: Text('修改手机号',style: TextStyle(color: Colors.white),),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: Icon(Icons.arrow_back_ios,color: Colors.white,),
          ),
          body: new ListView(
            children: <Widget> [
              new Container(
                  padding: const EdgeInsets.all(16),
                  child: new Form(
                    key: ChangePhNumKey,
                    autovalidate: true,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          decoration: new BoxDecoration(
                              border: new Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 240, 248, 240),
                                    width:1.0,
                                  )
                              )
                          ),
                          child:  new TextFormField(
                            decoration: new InputDecoration(
                              labelText: '输入旧手机号',
                              labelStyle: new TextStyle(fontSize: 15.0,color: Color.fromARGB(255, 93, 93, 93)),
                            ),
                            onChanged: (value){
                              OldNumber = value;
                            },
                          ),
                        ),
                        new Container(
                          decoration: new BoxDecoration(
                              border: new Border(
                                  bottom: BorderSide(
                                      color: Color.fromARGB(255, 240, 240, 240),
                                      width: 1.0
                                  )
                              )
                          ),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                              labelText: '输入手机号',
                              labelStyle: new TextStyle(fontSize: 15.0,color: Color.fromARGB(255, 93, 93, 93)),
                            ),
                            obscureText: false,
                            onChanged: (value){
                              NewNumber = value;
                            },
                          ),
                        ),
                        new Container(
                          decoration: new BoxDecoration(
                              border: new Border(
                                  bottom: BorderSide(
                                      color: Color.fromARGB(255, 240, 240, 240),
                                      width: 1.0
                                  )
                              )
                          ),
                          child: new Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsets.only(left: 0, right: 0, top: 0),
                                child: TextFormField(
                                    maxLines: 1,
                                    onSaved: (value) {},
                                    controller: mController,
                                    textAlign: TextAlign.left,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(6)
                                    ],
                                    decoration: InputDecoration(
//                                  hintText: ('填写验证码'),
//                                  contentPadding:
//                                      EdgeInsets.only(top: -5, bottom: 0),
//                                  hintStyle: TextStyle(
//                                    color: Color(0xff999999),
//                                    fontSize: 13,
//                                  ),
//                                  alignLabelWithHint: true,
//                                  border: OutlineInputBorder(
//                                      borderSide: BorderSide.none),

                                      labelText: '请输入验证码',
                                      labelStyle: new TextStyle(
                                          fontSize: 15.0,
                                          color: Color.fromARGB(255, 93, 93, 93)),
                                     // border: InputBorder.none,
                                    ),
                                    onChanged: (value){
                                      Verification_Code = value;
                                    }
                                ),
                              ),
                            ),
                            new Container(
                              width: 120,
                              child: FlatButton(
                                disabledColor: Colors.grey.withOpacity(0.1),
                                //按钮禁用时的颜色
                                disabledTextColor: Colors.white,
                                //按钮禁用时的文本颜色
                                textColor: isButtonEnable
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.2),
                                //文本颜色
                                color: isButtonEnable
                                    ? Color(0xff44c5fe)
                                    : Colors.grey.withOpacity(0.1),
                                //按钮的颜色
                                splashColor: isButtonEnable
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.transparent,
                                shape: StadiumBorder(side: BorderSide.none),
                                onPressed: () {
                                  setState(() {
                                    _buttonClickListen();
                                  });
                                },
//                        child: Text('重新发送 (${secondSy})'),
                                child: Text(
                                  '$buttonText',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
    ],
                          ),

                        ),
                        new Container(
                            height: 40.0,
                            width: 300,
                            margin: EdgeInsets.only(top:30),
                            child: new GestureDetector(
                                onTap: (){
                                  ChangePhNum();
                                },
                                child: new SizedBox.expand(
                                  child: new RaisedButton(
                                    elevation: 20,
                                    onPressed: ChangePhNum,
                                    color: Colors.blue,
                                    child: new Text(
                                      '确定',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color.fromARGB(255, 255, 255, 255)),
                                    ),
                                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                  ),
                                ),

    )

                        ),
                      ],
                    ),
                  )
              )
            ],
          )
      ),
    );
  }
}