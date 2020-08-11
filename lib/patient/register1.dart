
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'register2.dart';
import 'package:helloworld/sharedPrefrences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Login());
  }
}

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String phoneNumber;
  String password;
  String password2;
  String verificationCode;
  bool isShowPassWord = false;

  void login() async{
    //test
    Navigator.push(context, MaterialPageRoute(builder: (context) => register2()));
//    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => register2()), (route) => false);
    //读取当前的Form状态
    var loginForm = loginKey.currentState;
    //验证Form表单
    if(loginForm.validate()){
//      print(userName);
//      print(password);
      var bodymap = Map();
      bodymap['phone_num']=phoneNumber;
      bodymap['pass_word']=password;
      bodymap['ver_code']='111111';
      bodymap['user_type']='0';
      var url = "http://39.100.100.198:8082/register";
      var formData = bodymap;
      print(formData);
      await request(url,FormData: formData).then((value) {

        var data = json.decode(value.toString());
        print(data['result']);
        if(data['result']=='1'){
          SharedPreferenceUtil.setString('phoneNum', phoneNumber);
//          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => register2()), (route) => false);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => register2()), (route) => false);
        }else{
          print('注册失败，账号已存在');
        }
      });
    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
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

  // 计时器函数和变量----------------------------

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            '用户注册',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: new ListView(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              width: double.infinity,
              height: 90,
              child: Center(
                  child: new Text(
                '用户注册',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )),
            ),
            new Container(
              padding: const EdgeInsets.all(16.0),
              child: new Form(
                key: loginKey,
                autovalidate: true,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0))),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: '请输入您的手机号',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
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
                          phoneNumber = value;
                        },
                        validator: (phone) {
                          // if(phone.length == 0){
                          //   return '请输入手机号';
                          // }
                        },
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0))),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                            labelText: '输入密码',
                            labelStyle: new TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 93, 93, 93)),
                            border: InputBorder.none,
                            suffixIcon: new IconButton(
                              icon: new Icon(
                                isShowPassWord
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                              onPressed: showPassWord,
                            )),
                        obscureText: !isShowPassWord,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0))),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                            labelText: '确认密码',
                            labelStyle: new TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 93, 93, 93)),
                            border: InputBorder.none,
//                            suffixIcon: new IconButton(
//                              icon: new Icon(
//                                isShowPassWord
//                                    ? Icons.visibility
//                                    : Icons.visibility_off,
//                                color: Color.fromARGB(255, 126, 126, 126),
//                              ),
//                              onPressed: showPassWord,
//                            )
                        ),
                        obscureText: !isShowPassWord,
                        validator: (value) {
                          if (password!=null&&value != password) {
                            return '请确认两次密码输入相同';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          password2 = value;
                        },
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: <Widget>[
//                          Text(
//                            '验证码',
//                            style: TextStyle(
//                                fontSize: 13, color: Color(0xff333333)),
//                          ),
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
                                  border: InputBorder.none,
                                ),
                                onChanged: (value){
                                  verificationCode = value;
                                }
                              ),
                            ),
                          ),
                          Container(
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
                      padding: EdgeInsets.all(0),
                      height: 50.0,
                      margin: EdgeInsets.only(top: 40.0),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                          elevation: 20,
                          onPressed: login,
                          color: Colors.blue,
                          child: new Text(
                            '确定',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        ),
                      ),
                    ),
                    new Container(
                      //margin: EdgeInsets.only(top: 30.0),
                      padding:
                          EdgeInsets.only(left: 8.0, right: 8.0, top: 30.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            child: Text(
                              '收不到验证码？',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 53, 53, 53)),
                            ),
                          ),
//                          Text(
//                            '注册账号',
//                            style: TextStyle(
//                                fontSize: 15.0,
//                                color: Color.fromARGB(255, 53, 53, 53)
//                            ),
//                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  }
}
