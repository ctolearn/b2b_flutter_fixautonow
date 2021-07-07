import 'dart:convert';
import 'dart:io';
import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/Book_WorkType_Selection.dart';
import 'package:b2b_flutter_fixautonow/model/Vehicle_Make.dart';
import 'package:b2b_flutter_fixautonow/model/WorkType_Selection.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookViewModel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Company_BookViewModelListener extends ChangeNotifier {
/*  Status status, status_vehicle;

  List<Company_BookViewModel> bookViewModelList;

  List<Vehicle_Make> vehicleMakeList;*/

  Book_WorkType_Selection workType_Selection;
  List<WorkType_Selection> workTypeSelectionList;
  List<WorkType_Selection> selected_bookWorkType = [];
  ApiResponse bookResponse = new ApiResponse();
  ApiResponse<List<Company_BookViewModel>> fetchSelectionResponse = new ApiResponse();

  void fetchSelection() async {

    fetchSelectionResponse = ApiResponse.loading();
    ApiResponse<List<Book_WorkType_Selection>> _apiResponse =
    await WebRepository().fetchBookWorkType();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.EMPTY:
        fetchSelectionResponse = ApiResponse.empty();
        break;
      case Status.ERROR:
        fetchSelectionResponse = ApiResponse.error(message: _apiResponse.message);
        break;
      case Status.COMPLETED:
        fetchSelectionResponse = ApiResponse.completed(_apiResponse.data.map((e) => Company_BookViewModel(book_workType_Selection: e)).toList());
        break;
    }
    notifyListeners();
    /*selected_bookWorkType = [];
    workType_Selection = null;
    vehicle_make = null;
    status = Status.LOADING;
    List<Book_WorkType_Selection> bookWorkTypeSelectionList =
        await WebService().fetchBookWorkType();
    notifyListeners();
    print("The length is : " + bookWorkTypeSelectionList.length.toString());
    this.bookViewModelList = bookWorkTypeSelectionList
        .map((e) => Company_BookViewModel(book_workType_Selection: e))
        .toList();
    status = Status.COMPLETED;
    notifyListeners();*/
  }




  void selectedService(WorkType_Selection workType_Selection) {
    if (selected_bookWorkType.length == 0) {
      selected_bookWorkType.add(workType_Selection);
    } else {
      for (int i = 0; i < selected_bookWorkType.length; i++) {
        WorkType_Selection workType = selected_bookWorkType[i];
        if (workType.id == workType_Selection.id) {
          return;
        }
      }
      selected_bookWorkType.add(workType_Selection);
    }
    notifyListeners();
  }

  void removeSelected(WorkType_Selection workType_Selection) {
    if (selected_bookWorkType.length == 0) {
      return;
    } else {
      for (int i = 0; i < selected_bookWorkType.length; i++) {
        WorkType_Selection workType = selected_bookWorkType[i];
        if (workType.id == workType_Selection.id) {
          selected_bookWorkType.removeAt(i);
          notifyListeners();
          return;
        }
      }
    }
  }

  void selectedCategory(String id) {
    for (int i = 0; i < fetchSelectionResponse.data.length; i++) {
      if (id ==
          fetchSelectionResponse.data[i].book_workType_Selection.service_category_id) {
        workType_Selection = fetchSelectionResponse.data[i].book_workType_Selection;
        workTypeSelectionList = workType_Selection.workTypeSelection;
        selected_bookWorkType = [];
      }
    }
    notifyListeners();
  }

  List<VehicleFile> vehicleImages = [];

  void selectedImage(FilePickerResult result) async {
    List<File> files = await result.paths.map((path) => File(path)).toList();
    if (vehicleImages.length < 4) {
      for (int i = 0; i < files.length; i++) {
        if (vehicleImages.length < 4) {
          var uuid = Uuid();
          //future use ,base: base64Encode(files[i].readAsBytesSync())
          vehicleImages
              .add(VehicleFile(id: uuid.v4().toString(), file: files[i]));
        }
      }
      notifyListeners();
      //vehicleImages.addAll(files);
    } else {
      return;
    }
  }

  Vehicle_Make vehicle_make;

  void selectedModel(Vehicle_Make vehicle_make) {
    this.vehicle_make = vehicle_make;
    notifyListeners();
  }

  void removeImage(VehicleFile vehicleFileRemove) {
    for (int i = 0; i < vehicleImages.length; i++) {
      VehicleFile vehicleFile = vehicleImages[i];
      if (vehicleFile.id == vehicleFileRemove.id) {
        vehicleImages.removeAt(i);
        notifyListeners();
        return;
      }
    }
  }

  bool isRange = false;

  void setRange(bool isRange) {
    this.isRange = isRange;
    notifyListeners();
  }

  void uploadBook(FormData formData) async {
/*    var output = await WebService().saveBooking(formData);
    print(output);*/
  }
  void pickImages({MessageCallBack messageCallBack}) async{
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      if (files.length > 4) {
        files.clear();
        messageCallBack.showMessage("Max image is four");
      } else {
        if (vehicleImages.length >= 4) {
          files.clear();
          messageCallBack.showMessage("Max image is four");
        } else {
          selectedImage(result);
          files.clear();
        }
      }
    } else {
      messageCallBack.showMessage("Choose image to continue");
    }

  }
}

class VehicleFile {
  String id;
  File file;
  String base64Image;

  VehicleFile({this.id, this.file});
}
