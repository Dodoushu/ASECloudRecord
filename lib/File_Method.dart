import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class File_Method{
    img_upload() async {
    File file = await FilePicker.getFile(type: FileType.image,);
    var name = file.path.substring(file.path.lastIndexOf('/')+1,file.path.length);
    var postData = FormData.fromMap({
      'image':await MultipartFile.fromFile(file.path,filename: name)
    });
    var response = await Dio().post("",data: postData,onSendProgress: (int sent, int total){
      print("$sent $total");
    },);
  }
}