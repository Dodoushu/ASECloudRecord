import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class File_Method{
    file_pick() async {
    File file;
    await FilePicker.getFile(type: FileType.image,).then((value){
        file = value;
    });
    var name = file.path.substring(file.path.lastIndexOf('/')+1,file.path.length);
    String filePath = file.path;
    MultipartFile multipartFile;
    await MultipartFile.fromFile(filePath,filename: name).then((value) {
        multipartFile = value;
    }
    );
    return multipartFile;
//    var postData = FormData.fromMap({
//      'image':await MultipartFile.fromFile(file.path,filename: name)
//    });
//    var response = await Dio().post("",data: postData,onSendProgress: (int sent, int total){
//      print("$sent $total");
//    },);
  }
}