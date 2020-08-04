import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';

class File_Method{

    File file;
    var name;
    String filePath;
    MultipartFile multipartFile;

    file_pick() async {
    await FilePicker.getFile(type: FileType.image,).then((value){
        file = value;
    });
    name = file.path.substring(file.path.lastIndexOf('/')+1,file.path.length);
    filePath = file.path;
    zipEncode();
    Create_multiFlie();
//    var postData = FormData.fromMap({
//      'image':await MultipartFile.fromFile(file.path,filename: name)
//    });
//    var response = await Dio().post("",data: postData,onSendProgress: (int sent, int total){
//      print("$sent $total");
//    },);

  }
    Create_multiFlie() async {

        await MultipartFile.fromFile(filePath,filename: name).then((value) {
            multipartFile = value;
        }
        );
        return multipartFile;
    }

    void zipEncode() async{
        var encoder = ZipFileEncoder();
        encoder.create(filePath);   //这是将要创建压缩文件的位置，  我就写了文件的原位置，因为是在本地创建，在上传完成后要删除
        encoder.addFile(file);         //还有一个addDirector的方法，可以直接压一整个文件夹
        encoder.close();                //结束
    }
}