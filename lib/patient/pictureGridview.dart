import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: PictureGridview(),
    );
  }
}

class PictureGridview extends StatefulWidget {

  List picturelist;
  PictureGridview({this.picturelist});



  @override
  _PictureGridview createState() => _PictureGridview(picturelist: this.picturelist);
}



//创建图片的list
List<Container> _buildGridTileList(int count) {
  List<Container> containers = List<Container>.generate(
      count, (int index) => Container(child: Image.asset('images/timg.jpeg')));
  return containers;
}

//创建gridview
Widget buildGrid() {
  return GridView.extent(
      maxCrossAxisExtent: 150.0,
      padding: const EdgeInsets.all(4.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: _buildGridTileList(30));
}

class _PictureGridview extends State<PictureGridview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片展示'),
      ),
      body: Center(
        child: buildGrid(),
      ),
    );
  }
}
