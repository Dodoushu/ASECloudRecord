import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

showAlertDialog(BuildContext context,
    {titleText: '请设置标题', contentText: '请设置内容', bottonText: '确定', flag: 0}) {
  //设置按钮
  Widget okButton = FlatButton(
    child: Text(bottonText),
    onPressed: () {
      Navigator.of(context).pop();
      if (flag == 1) Navigator.pop(context);
    },
  );

  //设置对话框
  AlertDialog alert = AlertDialog(
    title: Text(titleText),
    content: Text(contentText),
    actions: [
      okButton,
    ],
  );

  //显示对话框
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//使用PageRouteBuilder实现半透明背景
class DialogRouter extends PageRouteBuilder{

  final Widget page;

  DialogRouter(this.page)
      : super(
    opaque: false,
    barrierColor: Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
  );
}

class LoadingDialog extends Dialog {

  String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Material(
        ///背景透明
        color: Colors.transparent,
        ///保证控件居中效果
        child: new Center(
          ///弹框大小
          child: new SizedBox(
            width: 120.0,
            height: 120.0,
            child: new Container(
              ///弹框背景和圆角
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: new Text(
                      "加载中",
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}