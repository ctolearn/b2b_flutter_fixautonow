
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/model/AddOn.dart';
import 'package:b2b_flutter_fixautonow/model/BookReceive_Info.dart';
import 'package:b2b_flutter_fixautonow/model/Book_WorkType_Selection.dart';
import 'package:b2b_flutter_fixautonow/model/Booking_Information.dart';
import 'package:b2b_flutter_fixautonow/model/Branch.dart';
import 'package:b2b_flutter_fixautonow/model/Company.dart';
import 'package:b2b_flutter_fixautonow/model/Company_WorkType.dart';
import 'package:b2b_flutter_fixautonow/model/CurrentUser.dart';
import 'package:b2b_flutter_fixautonow/model/DashBoard_Book.dart';
import 'package:b2b_flutter_fixautonow/model/DashboardCount.dart';
import 'package:b2b_flutter_fixautonow/model/EmployeeDashboard_Count.dart';
import 'package:b2b_flutter_fixautonow/model/Invoice_Information.dart';
import 'package:b2b_flutter_fixautonow/model/Job.dart';
import 'package:b2b_flutter_fixautonow/model/Messages.dart';
import 'package:b2b_flutter_fixautonow/model/Outliers.dart';
import 'package:b2b_flutter_fixautonow/model/Profile.dart';
import 'package:b2b_flutter_fixautonow/model/ReceiveBooking.dart';
import 'package:b2b_flutter_fixautonow/model/SentBooking.dart';
import 'package:b2b_flutter_fixautonow/model/Service.dart';
import 'package:b2b_flutter_fixautonow/model/Service_Category.dart';
import 'package:b2b_flutter_fixautonow/model/Service_Item.dart';
import 'package:b2b_flutter_fixautonow/model/User.dart';
import 'package:b2b_flutter_fixautonow/model/Vehicle_Make.dart';
import 'package:b2b_flutter_fixautonow/model/WorkType.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_MessagesViewModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:b2b_flutter_fixautonow/model/Chat.dart';

class WebRepository{

  String url_read = "https://fixautonow.com/mobile/read.php";
  String url_write = "https://fixautonow.com/mobile/write.php";

  WebRepository();
  Future<ApiResponse> signIn(FormData formData) async{

      try{
        var output = await Dio().post(url_read, data: formData);
        print(output);
        if (output.toString().trim() == "empty_email") {
          return ApiResponse<CurrentUser>.error(message: "Email is empty");
        } else if (output.toString().trim() == "empty_password") {
          return ApiResponse<CurrentUser>.error(message: "Password is empty");
        } else if (output.toString().trim() == "invalid_email") {
          return ApiResponse<CurrentUser>.error(message: "Email format is invalid");
        } else if (output.toString().trim() == "failed") {
          return ApiResponse<CurrentUser>.error(message: "Something happened");
        } else if (output.toString().trim() == "not_exist") {
          return ApiResponse<CurrentUser>.error(message: "We dont recognize this account");
        } else if (output.toString().trim() == "not_match") {
          return ApiResponse<CurrentUser>.error(message: "Password not match");
        } else {
          var jsonData = json.decode(output.toString());
          return ApiResponse<CurrentUser>.completed(CurrentUser.fromJson(jsonData));
        }


      }catch(e){
        return ApiResponse.error();
      }
  }
  Future<ApiResponse> signUp() async{
    try{
      return ApiResponse.loading();
    }catch(e){
      return ApiResponse.error();
    }
  }


  Future<ApiResponse<List<DashBoardBook>>> fetchDashboardItems() async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.getString('current_company'),
        "func": "main_dashboard"
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data == "no_data") {
          return ApiResponse<List<DashBoardBook>>.empty();
        } else {

          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];
          return ApiResponse<List<DashBoardBook>>.completed(list
              .map((dashboardItem) => DashBoardBook.fromJson(dashboardItem))
              .toList());
        }
      } else {
        return ApiResponse<List<DashBoardBook>>.error(message:"Check your internet ");
      }
    }catch(e){
      return ApiResponse<List<DashBoardBook>>.error(message:"Check your internet ");
    }

  }

  Future<ApiResponse<List<ServiceItem>>> fetchServiceItem(String query) async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.getString('current_company'),
        "query": query,
        "lat": "",
        "lng": "",
        "func": "service_item"
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data == "no_data") {
          return ApiResponse.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];
          return ApiResponse.completed(list
              .map((serviceItem) => ServiceItem.fromJson(serviceItem))
              .toList());
        }
      } else {
        return ApiResponse<List<ServiceItem>>.error(message:"Check your internet ");
      }
    }catch(e){
      return ApiResponse<List<ServiceItem>>.error(message:"Check your internet ");
    }

  }

  Future<ApiResponse<List<AddOn>>> fetchAddOn() async{

      SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        var formData = new FormData.fromMap({
          "company_id": prefs.getString('current_company'),
          "func": "main_addon"
        });
        final response = await Dio().post(url_read, data: formData);
        if (response.statusCode == 200) {
          final data = response.data;
          print(data);
          if (response.data.toString().trim() == "no_data") {
            return ApiResponse<List<AddOn>>.empty();
          } else {
            var jsonData = json.decode(data);
            Iterable list = jsonData["data"];
            return ApiResponse<List<AddOn>>.completed(list.map((item) => AddOn.fromJson(item)).toList());
          }
        } else {
          return ApiResponse<List<AddOn>>.error(message:"Check your internet ");
        }
      }catch(e){
        return ApiResponse<List<AddOn>>.error(message:"Check your internet ");
      }


  }


  Future<ApiResponse<List<Branch>>> fetchBranch() async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.getString('current_company'),
        "func": "main_branches",
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];
          return ApiResponse.completed(list.map((item) => Branch.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<Branch>>.error(message:"Check your internet ");
      }
    }catch(e){
      return ApiResponse<List<Branch>>.error(message:"Check your internet ");
    }

  }


  Future<ApiResponse<Profile>> fetchDashboardProfile() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.get('current_company'),
        "func": "main_profile",
        "user_id": prefs.getString('current_id'),
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data == "no_data") {
          return ApiResponse<Profile>.empty();
        } else {
          var jsonData = json.decode(response.data);
          return ApiResponse<Profile>.completed(Profile.fromJson(jsonData));
        }
      }else{
        return ApiResponse<Profile>.error(message: "Check your internet");

      }
    }catch(e){
      return ApiResponse<Profile>.error(message: "Check your internet");
    }

  }

  Future<ApiResponse<List<User>>> fetchUser() async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.getString('current_company'),
        "func": "main_users"
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<List<User>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];
          return ApiResponse<List<User>>.completed(list.map((item) => User.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<User>>.error(message: "Check your internet");
      }
    }catch(e){
      return ApiResponse<List<User>>.error(message: "Check your internet");
    }
  }

  Future<ApiResponse<List<User>>> fetchBranchUser(String branch_id) async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var formData = new FormData.fromMap(
          {"branch": branch_id, "func": "fetch_branchusers"});
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<List<User>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];
          return ApiResponse<List<User>>.completed(list.map((item) => User.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<User>>.error(message: "Check your internet");
      }
    }catch(e){
      return ApiResponse<List<User>>.error(message: "Check your internet");
    }
  }

  Future<ApiResponse<List<Outliers>>> fetchOutliers() async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.getString('current_company'),
        "func": "main_outliers"
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data == "no_data") {
          return ApiResponse<List<Outliers>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];
          return ApiResponse<List<Outliers>>.completed(list.map((item) => Outliers.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<Outliers>>.error(message: "Check your internet");
      }
    } catch(e){
      return ApiResponse<List<Outliers>>.error(message: "Check your internet");
    }
  }

  Future<ApiResponse<List<Service>>> fetchService() async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.getString('current_company'),
        "func": "main_service"
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print("SErvice data "+data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<List<Service>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];
          return ApiResponse<List<Service>>.completed(list.map((item) => Service.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<Service>>.error(message: "Check your internet");
      }
    }catch(e){

      return ApiResponse<List<Service>>.error(message: "Check your internet");
    }
  }

  Future<ApiResponse<List<ReceiveBooking>>> fetchReceive() async {
    // return List<ServiceItem>.empty();
    print("HERE");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.getString('current_company'),
        "func": "main_receive"
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data == "no_data") {
          return ApiResponse<List<ReceiveBooking>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];

          return ApiResponse<List<ReceiveBooking>>.completed(list.map((item) => ReceiveBooking.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<ReceiveBooking>>.error(message: "");
      }
    }catch(e){
      return ApiResponse<List<ReceiveBooking>>.error(message: "");
    }
  }
  Future<ApiResponse<List<SentBooking>>> fetchSent() async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.getString('current_company'),
        "func": "main_sent"
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data == "no_data") {
          return ApiResponse<List<SentBooking>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];

          return ApiResponse<List<SentBooking>>.completed(list.map((item) => SentBooking.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<SentBooking>>.error(message: "");
      }
    }catch(e){
      return ApiResponse<List<SentBooking>>.error(message: "");
    }
  }


  Future<ApiResponse<DashboardCount>> fetchDashboardCount() async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "company_id": prefs.getString('current_company'),
        "func": "fetch_dashboard_data"
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);

        var jsonData = json.decode(response.data);

        return ApiResponse<DashboardCount>.completed(DashboardCount.fromJson(jsonData));
      } else {
        return ApiResponse<DashboardCount>.error(message: "");
      }
    }catch(e){
      return ApiResponse<DashboardCount>.error(message: "");
    }
  }

  Future<ApiResponse<List<WorkType>>> fetchWorkTypes(String service_id) async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap(
          {"work_type": service_id, "func": "fetch_worktypes"});
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data == "no_data") {
          return ApiResponse<List<WorkType>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];

          return ApiResponse<List<WorkType>>.completed(list.map((item) => WorkType.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<WorkType>>.error(message: "");
      }
    }catch(e){
      return ApiResponse<List<WorkType>>.error(message: "");
    }
  }

  Future<ApiResponse<List<Company_WorkType>>> fetchCompanyWorkTypes(
      String service_id) async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap(
          {"work_type": service_id, "func": "fetch_worktypes_company"});
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data == "no_data") {
          return ApiResponse<List<Company_WorkType>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable list = jsonData["data"];
          return ApiResponse<List<Company_WorkType>>.completed(list.map((item) => Company_WorkType.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<Company_WorkType>>.error(message: "");
      }
    }catch(e){
      return ApiResponse<List<Company_WorkType>>.error(message: "");
    }
  }
  //STOP HERE


  Future<ApiResponse<Invoice_Information>> fetchInvoiceInformation(String book_id) async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData =
      new FormData.fromMap({"id": book_id, "func": "show_invoice"});
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        var data = response.data;
        data = data.toString().trim();
        return ApiResponse<Invoice_Information>.completed(Invoice_Information.fromJson(json.decode(data)));
      } else {
        return ApiResponse<Invoice_Information>.error(message: "");
      }
    }catch(e){
      return ApiResponse<Invoice_Information>.error(message: "");
    }
  }

  Future<ApiResponse<BookReceive_Info>> fetchReceiveBookingInformation(
      String book_id) async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData =
      new FormData.fromMap({"id": book_id, "func": "receive_info"});
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        var data = response.data;
        data = data.toString().trim();
        print(data);
        return ApiResponse<BookReceive_Info>.completed(BookReceive_Info.fromJson(json.decode(data)));
      } else {
        return ApiResponse<BookReceive_Info>.error(message: "");
      }
    }catch(e){
      return ApiResponse<BookReceive_Info>.error(message: "");
    }
  }

  Future<ApiResponse<BookReceive_Info>> fetchDashboardBookInfo(
      String book_id) async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData =
      new FormData.fromMap({"id": book_id, "func": "main_booking_info"});
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        var data = response.data;
        data = data.toString().trim();
        print(data);
        return ApiResponse<BookReceive_Info>.completed(BookReceive_Info.fromJson(json.decode(data)));
      } else {
        return ApiResponse<BookReceive_Info>.error(message: "");
      }
    }catch(e){
      return ApiResponse<BookReceive_Info>.error(message: "");
    }
  }
  Future<ApiResponse<BookReceive_Info>> fetchReceiveBookingInformationSent(
      String book_id,String type) async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData =
      new FormData.fromMap({"id": book_id, "func" : "receive_info_sent","type":type});
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        var data = response.data;
        data = data.toString().trim();

        return ApiResponse<BookReceive_Info>.completed(BookReceive_Info.fromJson(json.decode(data)));
      } else {
        return ApiResponse<BookReceive_Info>.error(message: "");
      }
    }catch(e){
      return ApiResponse<BookReceive_Info>.error(message: "");
    }
  }
  Future<ApiResponse<Booking_Information>> fetchBookingInformation(String book_id) async {
    // return List<ServiceItem>.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData =
      new FormData.fromMap({"id": book_id, "func": "booking_information"});
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        var data = response.data;
        data = data.toString().trim();
        print(data);
        return ApiResponse<Booking_Information>.completed(Booking_Information.fromJson(json.decode(data)));
      } else {
        return ApiResponse<Booking_Information>.error(message: "");
      }
    }catch(e){
      return ApiResponse<Booking_Information>.error(message: "");
    }
  }

  Future<ApiResponse<Branch>> fetchBranchInformation(String id) async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("ID IS : " + id);
    try {
      var formData = new FormData.fromMap(
          {"company_id": id, "func": "get_branch_information"});
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<Branch>.empty();
        } else {
          var jsonData = json.decode(response.data);
          return ApiResponse<Branch>.completed(Branch.fromJson(jsonData));
        }
      } else {
        return ApiResponse<Branch>.error(message: "");
      }
    }catch(e){
      return ApiResponse<Branch>.error(message: "");
    }
  }

  Future<ApiResponse<User>> fetchUserInformation(String id) async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("ID IS : " + id);
    try {
      var formData = new FormData.fromMap({
        "id": id,
        "func": "get_user_information",
        "company_id": prefs.getString('current_company'),
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<User>.error();
        } else {
          var jsonData = json.decode(response.data);
          return ApiResponse<User>.completed(User.fromJson(jsonData));
        }
      } else {

        return ApiResponse<User>.error(message: "");
      }
    }catch(e){
      return ApiResponse<User>.error(message: "");
    }
  }

  Future<ApiResponse<Outliers>> fetchOutlierInformation(String id) async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("ID IS : " + id);
    try {
      var formData = new FormData.fromMap({
        "id": id,
        "func": "get_outlier_information",
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<Outliers>.empty();
        } else {
          var jsonData = json.decode(response.data);
          return ApiResponse<Outliers>.completed(Outliers.fromJson(jsonData));
        }
      } else {
        return ApiResponse<Outliers>.error(message: "");
      }
    }catch(e){

      return ApiResponse<Outliers>.error(message: "");
    }
  }

  Future<ApiResponse<Service>> fetchServiceInformation(String id) async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("ID IS qweqw : " + id);
    try {
      var formData = new FormData.fromMap({
        "id": id,
        "func": "get_services_information",
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<Service>.empty();
        } else {
          var jsonData = json.decode(response.data);
          return ApiResponse<Service>.completed(Service.fromJson(jsonData));
        }
      } else {
        return ApiResponse<Service>.error(message: "");
      }
    }catch(e){
      return ApiResponse<Service>.error(message: "");
    }
  }

  Future<ApiResponse<AddOn>> fetchAddOnInformation(String id) async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "id": id,
        "func": "get_addon_information",
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<AddOn>.empty();
        } else {
          var jsonData = json.decode(response.data);
          return ApiResponse<AddOn>.completed(AddOn.fromJson(jsonData));
        }
      } else {
        return ApiResponse<AddOn>.error(message: "");
      }
    }catch(e){
      return ApiResponse<AddOn>.error(message: "");
    }
  }

  Future<ApiResponse<List<Service_Category>>> fetchServiceCategory() async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "func": "get_servicescategory",
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<List<Service_Category>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable data = jsonData["data"];
          return ApiResponse<List<Service_Category>>.completed(data.map((item) => Service_Category.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<Service_Category>>.error(message: "");
      }
    }catch(e){
      return ApiResponse<List<Service_Category>>.error(message: "");
    }
  }

  Future<ApiResponse<List<Company>>> fetchCompany() async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "func": "get_company_search",
        "company_id": prefs.getString('current_company'),
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<List<Company>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable data = jsonData["data"];
          return ApiResponse<List<Company>>.completed(data.map((item) => Company.fromJson(item)).toList());
        }
      } else {
        return ApiResponse<List<Company>>.error(message: "");
      }
    }catch(e){
      return ApiResponse<List<Company>>.error(message: "");
    }
  }

  Future<ApiResponse<List<Book_WorkType_Selection>>> fetchBookWorkType() async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "func": "get_servicestype_book",
      });
      final response = await Dio().post(
        url_read,
        data: formData,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<List<Book_WorkType_Selection>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable data = jsonData["data"];
          return ApiResponse<List<Book_WorkType_Selection>>.completed(data
              .map((item) => Book_WorkType_Selection.fromJson(item))
              .toList());
        }
      } else {
        return ApiResponse<List<Book_WorkType_Selection>>.error(message: "");
      }
    } catch(e){
      return ApiResponse<List<Book_WorkType_Selection>>.error(message: "");
    }
  }

  Future<ApiResponse<List<Vehicle_Make>>> fetchVehicleModel() async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "func": "get_vehiclemodel",

      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<List<Vehicle_Make>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable iterable = jsonData["data"];
          return ApiResponse<List<Vehicle_Make>>.completed(iterable.map((e) => Vehicle_Make.fromJson(e)).toList());
        }
      } else {
        return ApiResponse<List<Vehicle_Make>>.error(message: "");
      }
    }catch(e){

      return ApiResponse<List<Vehicle_Make>>.error(message: "");
    }
  }

  Future<ApiResponse<EmployeeDashboard_Count>> fetchEmployeeDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "func": "get_job_count",
        "current_id": prefs.getString('current_id'),
      });
      final response = await Dio().post(url_read, data: formData);
      print(response);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.data);
        return ApiResponse<EmployeeDashboard_Count>.completed(EmployeeDashboard_Count.fromJson(jsonData));
      } else {
        return ApiResponse<EmployeeDashboard_Count>.error(message: "");
      }
    } catch(e){
      return ApiResponse<EmployeeDashboard_Count>.error(message: "");
    }
  }

  Future<ApiResponse<List<Job>>> fetchJob(String type) async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "func": "get_job",
        "type": type,
        "current_id": prefs.getString('current_id'),
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<List<Job>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable iterable = jsonData["data"];
          return ApiResponse.completed(iterable.map((e) => Job.fromJson(e)).toList());
        }
      } else {
        return ApiResponse<List<Job>>.error(message: "");

      }
    }catch(e){
      return ApiResponse<List<Job>>.error(message: "");
    }
  }


  Future<ApiResponse<List<Messages>>> fetchMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "func": "fetch_message",
        "company_id": prefs.getString('current_company'),
      });
      final response = await Dio().post(url_read, data: formData);
      print(response);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.data);
        Iterable iterable = jsonData["data"];
        return ApiResponse<List<Messages>>.completed(iterable.map((e) => Messages.fromJson(e)).toList());
      } else {
        return ApiResponse<List<Messages>>.error(message: "");
      }
    } catch(e){
      return ApiResponse<List<Messages>>.error(message: "");
    }
  }
  Future<ApiResponse<List<Chat>>> fetchChats({String booking_id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "func": "fetch_chat",
        "company_id": prefs.getString('current_company'),
        "booking_id":booking_id
      });
      final response = await Dio().post(url_read, data: formData);
      print(response);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.data);
        Iterable iterable = jsonData["data"];
        return ApiResponse<List<Chat>>.completed(iterable.map((e) => Chat.fromJson(e)).toList());
      } else {
        return ApiResponse<List<Chat>>.error(message: "");
      }
    } catch(e){
      return ApiResponse<List<Chat>>.error(message: "");
    }
  }


  Future<ApiResponse<List<Job>>> fetchUserProfile() async {
    // return List<ServiceItem>.empty();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var formData = new FormData.fromMap({
        "func": "get_user_profile",
        "current_id": prefs.getString('current_id'),
      });
      final response = await Dio().post(url_read, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (response.data.toString().trim() == "no_data") {
          return ApiResponse<List<Job>>.empty();
        } else {
          var jsonData = json.decode(response.data);
          Iterable iterable = jsonData["data"];
          return ApiResponse<List<Job>>.completed(iterable.map((e) => Job.fromJson(e)).toList());
        }
      } else {
        return ApiResponse<List<Job>>.error(message: "");
      }
    }catch(e){
      return ApiResponse<List<Job>>.error(message: "");
    }
  }

  Future<ApiResponse<String>> saveBooking(FormData formData) async {
    // return List<ServiceItem>.empty();

    try {
      final response = await Dio().post(url_write, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return ApiResponse<String>.completed(data);
      } else {
        return ApiResponse<String>.error(message: "");

      }
    }catch(e){
      return ApiResponse<String>.error(message: "");
    }
  }
  Future<ApiResponse<String>> saveAddOn(FormData formData) async {
    // return List<ServiceItem>.empty();

    try {
      final response = await Dio().post(url_write, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return data;
      } else {
        return ApiResponse<String>.error(message: "");
      }
    }catch(e){
      return ApiResponse<String>.error(message: "");
    }
  }
  Future<ApiResponse<String>> saveBranch(FormData formData) async {
    // return List<ServiceItem>.empty();

    try {
      final response = await Dio().post(url_write, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        return ApiResponse<String>.completed(data);
      } else {
        return ApiResponse<String>.error(message: "");
      }
    }catch(e){
      return ApiResponse<String>.error(message: "");

    }
  }
  Future<ApiResponse<String>> saveOutliers(FormData formData) async {
    // return List<ServiceItem>.empty();

    try {
      final response = await Dio().post(url_write, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        return ApiResponse<String>.completed(data);
      } else {
        return ApiResponse<String>.error(message: "");
      }
    }catch(e){
      return ApiResponse<String>.error(message: "");
    }
  }
  Future<ApiResponse<String>> saveService(FormData formData) async {
    // return List<ServiceItem>.empty();

    try {
      final response = await Dio().post(url_write, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        return ApiResponse<String>.completed(data);
      } else {
        return ApiResponse<String>.error(message: "");
      }
    }catch(e){
      return ApiResponse<String>.error(message: "");
    }
  }
  Future<ApiResponse<String>> saveUser(FormData formData) async {
    // return List<ServiceItem>.empty();

    try {
      final response = await Dio().post(url_write, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        return ApiResponse<String>.completed(data);
      } else {
        return ApiResponse<String>.error(message: "");
      }
    } catch(e){
      return ApiResponse<String>.error(message: "");
    }
  }

  Future<ApiResponse<String>> deleteData(FormData formData) async {
    try {
      final response = await Dio().post(url_write, data: formData);
      if (response.statusCode == 200) {
        final data = response.data;
        return ApiResponse<String>.completed(data);
      } else {

        return ApiResponse<String>.error(message: "");
      }
    }catch(e){
      return ApiResponse<String>.error(message: "");
    }
  }

}