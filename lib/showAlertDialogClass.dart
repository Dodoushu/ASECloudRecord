import 'package:flutter/material.dart';


showAlertDialog(BuildContext context,{titleText:'请设置标题', contentText:'请设置内容',bottonText:'确定'}) {
  
  //设置按钮
  Widget okButton = FlatButton(
    child: Text(bottonText),
    onPressed: () {
      Navigator.of(context).pop();
//      Navigator.pop(context);
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