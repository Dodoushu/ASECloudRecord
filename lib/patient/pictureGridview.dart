
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void main(){
  runApp(new MaterialApp(
    title: '全部图片浏览',
    home: new PictureView(),
  ));
}
class ImageBulid {
  final String url;
  ImageBulid(this.url);

}
class BigPhoto extends StatelessWidget{
  final String url;
  BigPhoto({Key key, @required this.url}): super(key:key);

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body:  new GestureDetector(
        child: Container(
          child: PhotoView(
            imageProvider: new NetworkImage(url),
          ),
        ),
        onTap:(){
          Navigator.pop(context);
      },
      ),
    );
  }
}
class PictureView extends StatelessWidget{

  final List urls;
  PictureView({Key key, @required this.urls}): super(key:key);
//  var urls = ['https://th.bing.com/th/id/OIP.b7nc7IbOW5cWI4kwhWWrgQHaE7?pid=Api&rs=1',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'http://www.chinanews.com/cul/2018/01-08/U322P4T8D8418615F107DT20180108102000.jpg',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'http://www.chinanews.com/cul/2018/01-08/U322P4T8D8418615F107DT20180108102000.jpg',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'http://www.chinanews.com/cul/2018/01-08/U322P4T8D8418615F107DT20180108102000.jpg',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'http://www.chinanews.com/cul/2018/01-08/U322P4T8D8418615F107DT20180108102000.jpg',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'http://www.chinanews.com/cul/2018/01-08/U322P4T8D8418615F107DT20180108102000.jpg',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'http://www.chinanews.com/cul/2018/01-08/U322P4T8D8418615F107DT20180108102000.jpg',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'http://www.chinanews.com/cul/2018/01-08/U322P4T8D8418615F107DT20180108102000.jpg',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'https://th.bing.com/th/id/OIP.12_fx00igRkY93QOsbmb_wHaKD?pid=Api&rs=1',
//    'http://www.chinanews.com/cul/2018/01-08/U322P4T8D8418615F107DT20180108102000.jpg',
//  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
            '图片浏览',
          style:TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Icon(Icons.arrow_back_ios,size: 25,),
      ),
      body: new GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            mainAxisSpacing: 4,  //
            crossAxisSpacing: 4, //缩略图间距
            childAspectRatio: 1.0 //显示区域宽高相等
        ),
        itemCount: urls.length,
        itemBuilder: (context,index){
          return  new GestureDetector(
              child: Container(
                child: new Image(image: NetworkImage(urls[index]), fit: BoxFit.cover,), //这句可以完成中心裁剪
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => BigPhoto(url: urls[index],)));
              },
          );
        },

      ),
    );
}}