import 'dart:io';

import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/Profile.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ProfileViewModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
class Company_ProfileListenerViewModel extends ChangeNotifier{
  ApiResponse<Company_ProfileViewModel> apiResponse = ApiResponse();

  void fetchProfile() async{
    apiResponse = ApiResponse.loading();
    ApiResponse<Profile> _apiResponse = await WebRepository().fetchDashboardProfile();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.COMPLETED:
        apiResponse = ApiResponse.completed(Company_ProfileViewModel(profile:_apiResponse.data));
        break;
      case Status.ERROR:
        apiResponse = ApiResponse.error();
        break;
      case Status.EMPTY:
        apiResponse = ApiResponse.empty();
        break;
    }
    notifyListeners();
  }
  void reloadContact(String owner_c_code,String owner_mobile) async{
    apiResponse.data.profile.owner_c_code = owner_c_code;
    apiResponse.data.profile.owner_mobile = owner_mobile;
    notifyListeners();

  }


  File uploadimage; //variable for choosed file
  void getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if(result != null){
      uploadimage = File(result.files.single.path);
      notifyListeners();
    }
  }

  void uploadProfile(){
   /* uploadFile() async {
      String uploadurl = "http://192.168.0.112/test/file_upload.php";
      //dont use http://localhost , because emulator don't get that address
      //insted use your local IP address or use live URL
      //hit "ipconfig" in windows or "ip a" in linux to get you local IP

      FormData formdata = FormData.fromMap({
        "file": await MultipartFile.fromFile(
            selectedfile.path,
            filename: basename(selectedfile.path)
          //show only filename from path
        ),
      });

      response = await dio.post(uploadurl,
        data: formdata,
        onSendProgress: (int sent, int total) {
          String percentage = (sent/total*100).toStringAsFixed(2);
          setState(() {
            progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
            //update the progress
          });
        },);

      if(response.statusCode == 200){
        print(response.toString());
        //print response from server
      }else{
        print("Error during connection to server.");
      }
    }*/
  }

  /*
  <?php
$return["error"] = false;
$return["msg"] = "";
$return["success"] = false;
//array to return

if(isset($_FILES["file"])){
    //directory to upload file
    $target_dir = "files/"; //create folder files/ to save file
    $filename = $_FILES["file"]["name"];
    //name of file
    //$_FILES["file"]["size"] get the size of file
    //you can validate here extension and size to upload file.

    $savefile = "$target_dir/$filename";
    //complete path to save file

    if(move_uploaded_file($_FILES["file"]["tmp_name"], $savefile)) {
        $return["error"] = false;
        //upload successful
    }else{
        $return["error"] = true;
        $return["msg"] =  "Error during saving file.";
    }
}else{
    $return["error"] = true;
    $return["msg"] =  "No file is sublitted.";
}

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);
//converting array to JSON string
?>
  * */
}
