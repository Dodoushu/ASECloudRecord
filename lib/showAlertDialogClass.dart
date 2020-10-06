
import 'package:flutter/material.dart';


showAlertDialog(BuildContext context,
    {titleText: '请设置标题', contentText: '请设置内容', bottonText: '确定', flag: 0}) {
  //设置按钮
  Widget okButton = FlatButton(
    child: Text(bottonText),
    onPressed: () {
      Navigator.of(context).pop();
      if (flag == 1){
        Navigator.of(context).pop();
      }else if(flag == 2){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
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


// ignore: must_be_immutable
class NetLoadingDialog extends StatefulWidget {
  String loadingText;
//  bool outsideDismiss;

  Function dismissDialog;

  NetLoadingDialog(
      {Key key,
        this.loadingText = "loading...",
       // this.outsideDismiss = true,
        this.dismissDialog})
      : super(key: key);

  @override
  State<NetLoadingDialog> createState() => _LoadingDialog();
}

class _LoadingDialog extends State<NetLoadingDialog> {
  _dismissDialog() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      widget.dismissDialog(() {
        Navigator.of(context).pop();
        print("func");
      });
    });

//    WidgetsBinding.instance.addPostFrameCallback((_) {
//
//    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
//      onTap: widget.outsideDismiss ? _dismissDialog : null,
  //  onTap: (){Navigator.of(context).pop();},  点击退出，该context是dialog的context
      child: Material(
        type: MaterialType.transparency,
        child: new Center(
          child: new SizedBox(
            width: 120.0,
            height: 120.0,
            child: new Container(
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
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: new Text(
                      widget.loadingText,
                      style: new TextStyle(fontSize: 12.0),
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



