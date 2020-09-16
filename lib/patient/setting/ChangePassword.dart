import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
void main() => runApp(ChangePswd());

class ChangePswd extends StatefulWidget{
  @override
  _ChangePswd createState() => _ChangePswd();

}
class _ChangePswd extends State<ChangePswd> {
      GlobalKey<FormState> ChangePswdKey = new GlobalKey<FormState>();
      String old;
      String new_1;
      String new_2;

      void ChangePswd() async{
        var ChangePswdForm = ChangePswdKey.currentState;
        if(ChangePswdForm.validate())
          {
            Map<String,dynamic> map = {
              'OldPassWord':old
            };
            var bodymap = Map();
            bodymap['OldPassWord'] = old;
            var url = "http://101.133.228.14:8081/config?";
            http.post(url,body: bodymap).then((response) {

            });

          }
      }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('修改密码',style: TextStyle(color: Colors.white),),
          centerTitle: true,
//          backgroundColor: Colors.white,
        ),
        body: new ListView(
          children: <Widget> [
            new Container(
              padding: const EdgeInsets.all(16),
              child: new Form(
                key: ChangePswdKey,
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
                          labelText: '输入旧密码',
                          labelStyle: new TextStyle(fontSize: 15.0,color: Color.fromARGB(255, 93, 93, 93)),
                        ),
                        onChanged: (value){
                          old = value;
                        },
                       validator:(old) {

                       },
                        onFieldSubmitted: (value){

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
                          labelText: '输入新密码',
                          labelStyle: new TextStyle(fontSize: 15.0,color: Color.fromARGB(255, 93, 93, 93)),
                        ),
                        obscureText: true,
                        onSaved: (value){
                          new_1 = value;
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
                          labelText: '确认新密码',
                          labelStyle: new TextStyle(fontSize: 15.0,color: Color.fromARGB(255, 93, 93, 93)),
                        ),
                        obscureText: true,
                        validator: (value){
                          if(new_1 != null && value != new_1)
                            {
                              return '请确认两次密码输入相同';
                            }
                          return null;
                        },
                        onSaved: (value){
                          new_2 = value;
                        },
                      ),
                    ),
                    new Container(
                      height: 40.0,
                      width: 300,
                      margin: EdgeInsets.only(top:30),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                            elevation: 20,
                            onPressed: null,
                            color: Colors.blue,
                            child: new Text(
                              '确定',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                            ),
                        )
                      ),
                  ],
                ),
              )
            )
          ],
        )
      );
  }
}