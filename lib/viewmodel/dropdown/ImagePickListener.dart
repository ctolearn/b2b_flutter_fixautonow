import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class ImagePickListener extends ChangeNotifier {

  void changeImage({String imagePath}) {
    Future.delayed(Duration.zero, () {
      this.imagePath = imagePath;
      notifyListeners();
    });
  }
  void removeFile() {
    Future.delayed(Duration.zero, () {
      this.uploadimage = null;
      notifyListeners();
    });
  }
  File uploadimage; //variable for choosed file
  String imagePath;
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
}
