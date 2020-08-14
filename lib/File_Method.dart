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
//    zipEncode();
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


}