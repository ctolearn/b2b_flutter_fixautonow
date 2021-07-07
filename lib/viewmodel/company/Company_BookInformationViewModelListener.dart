import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/AddOn.dart';
import 'package:b2b_flutter_fixautonow/model/BookReceive_Info.dart';
import 'package:b2b_flutter_fixautonow/model/Book_AddOn.dart';
import 'package:b2b_flutter_fixautonow/model/Book_WorkType.dart';
import 'package:b2b_flutter_fixautonow/model/Booking_Information.dart';
import 'package:b2b_flutter_fixautonow/model/Company_WorkType.dart';
import 'package:b2b_flutter_fixautonow/model/Invoice_Information.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookInformationViewModel.dart';

class Company_BookInformationViewModelListener extends ChangeNotifier {
  ApiResponse<Company_BookInformationViewModel> fetchBookingReceiveInformation =
  ApiResponse();
  ApiResponse<Company_BookInformationViewModel> fetchBookingSentInformation =
  ApiResponse();
  ApiResponse<Company_BookInformationViewModel> fetchInvoiceInformation =
  ApiResponse();

  ApiResponse<Company_BookInformationViewModel> fetchBookInformation =
  ApiResponse();

  void fetchReceiveBookingInformation(String booking_id) async {
    fetchBookingReceiveInformation = ApiResponse.loading();
    ApiResponse<BookReceive_Info> _apiResponse =
    await WebRepository().fetchReceiveBookingInformation(booking_id);
    notifyListeners();
    switch (_apiResponse.status) {
      case Status.COMPLETED:
        fetchBookingReceiveInformation = ApiResponse.completed(
            Company_BookInformationViewModel.setBookReceiveInformation(
                _apiResponse.data));
        break;
      case Status.EMPTY:
        fetchBookingReceiveInformation = ApiResponse.empty();
        break;
      case Status.ERROR:
        fetchBookingReceiveInformation = ApiResponse.error();
        break;
    }
  }

  void fetchSentBookingInformation(String booking_id, String type) async {
    fetchBookingSentInformation = ApiResponse.loading();

    ApiResponse<BookReceive_Info> _apiResponse = await WebRepository()
        .fetchReceiveBookingInformationSent(booking_id, type);
    notifyListeners();
    switch (_apiResponse.status) {
      case Status.COMPLETED:
        fetchBookingReceiveInformation = ApiResponse.completed(
            Company_BookInformationViewModel.setBookReceiveInformation(
                _apiResponse.data));
        break;
      case Status.EMPTY:
        fetchBookingReceiveInformation = ApiResponse.empty();
        break;
      case Status.ERROR:
        fetchBookingReceiveInformation = ApiResponse.error();
        break;
    }
  }

  void fetchBookingInvoiceInformation(String book_id) async {
    fetchInvoiceInformation = ApiResponse.loading();

    ApiResponse<Invoice_Information> _apiResponse =
    await WebRepository().fetchInvoiceInformation(book_id);
    notifyListeners();
    switch (_apiResponse.status) {
      case Status.COMPLETED:
        fetchInvoiceInformation = ApiResponse.completed(
            Company_BookInformationViewModel.setInvoiceInformation(
                _apiResponse.data));
        break;
      case Status.EMPTY:
        fetchInvoiceInformation = ApiResponse.empty();
        break;
      case Status.ERROR:
        fetchInvoiceInformation = ApiResponse.error();
        break;
    }
  }

  void fetchBookingInformation(String book_id) async {
    fetchBookInformation = ApiResponse.loading();

    ApiResponse<Booking_Information> _apiResponse =
    await WebRepository().fetchBookingInformation(book_id);
    notifyListeners();
    switch (_apiResponse.status) {
      case Status.COMPLETED:
        fetchBookInformation = ApiResponse.completed(
            Company_BookInformationViewModel.setBookingInformation(
                _apiResponse.data));
        break;
      case Status.EMPTY:
        fetchInvoiceInformation = ApiResponse.empty();
        break;
      case Status.ERROR:
        fetchInvoiceInformation = ApiResponse.error();
        break;
    }
  }


  /** work type */
  void selectedType(Company_WorkType company_workType) {
    List<Book_WorkType> workType =
        this.fetchInvoiceInformation.data.invoice_information.bookWorkTypes;
    var type = Book_WorkType(
        id: company_workType.work_id,
        name: company_workType.type_name,
        description: company_workType.type_description,
        price: company_workType.type_price);
    bool isExist = false;
    for (int i = 0; i < workType.length; i++) {
      if (workType[i].id == company_workType.work_id) {
        isExist = true;
        break;
      }
    }


    if (!isExist) {
      workType.add(type);
    }
    notifyListeners();
  }


  void deleteWorkType(String id) {
    List<Book_WorkType> workType =
        fetchInvoiceInformation.data.invoice_information.bookWorkTypes;

    for (int i = 0; i < workType.length; i++) {
      if (workType[i].id == id) {
        workType.removeAt(i);
        break;
      }
    }
    notifyListeners();
  }

  /** work addOn */
  void deleteAddOn(String id) {
    List<Book_AddOn> addons =
        fetchInvoiceInformation.data.invoice_information.bookAddOns;
    if (addons != null) {
      for (int i = 0; i < addons.length; i++) {
        if (addons[i].addon_id == id) {
          if (int.parse(addons[i].count) == 1) {
            addons.removeAt(i);
          } else {
            addons[i].count = (int.parse(addons[i].count) - 1).toString();
          }
          /*      addons[i].count = (int.parse(addons[i].count) + 1).toString();
          addons[i].total =
              (int.parse(addons[i].price) * int.parse(addons[i].count))
                  .toString();*/
        }
      }
    }
    notifyListeners();
  }

  void selectAddOn(AddOn addOn) async {
    List<Book_AddOn> addons =
        fetchInvoiceInformation.data.invoice_information.bookAddOns;
    if (addons == null) {
      addons.add(Book_AddOn(
          count: "1",
          total: addOn.addon_price,
          name: addOn.addon_name,
          description: addOn.addon_description,
          addon_id: addOn.addon_id));
      print("here");
      notifyListeners();
    } else {
      if (addons.length == 0) {
        print("here");

        addons.add(Book_AddOn(
            count: "1",
            total: addOn.addon_price,
            name: addOn.addon_name,
            description: addOn.addon_description,
            addon_id: addOn.addon_id,
            price: addOn.addon_price));
      } else {
        bool isExist = false;
        for (int i = 0; i < addons.length; i++) {
          if (addons[i].addon_id == addOn.addon_id) {
            addons[i].count = (int.parse(addons[i].count) + 1).toString();
            addons[i].total =
                (int.parse(addons[i].price) * int.parse(addons[i].count))
                    .toString();

            isExist = true;
            break;
          }
        }
        if (!isExist) {
          addons.add(Book_AddOn(
              count: "1",
              total: addOn.addon_price,
              name: addOn.addon_name,
              description: addOn.addon_description,
              addon_id: addOn.addon_id,
              price: addOn.addon_price));
        }
      }

      notifyListeners();
    }
  }

  /*FOR CREATION OF INVOICE*/
  void selectedTypeCreate(Company_WorkType company_workType) {

    List<Book_WorkType> workType =
        this.fetchBookInformation.data.booking_information.bookWorkTypes;
    var type = Book_WorkType(
        id: company_workType.work_id,
        name: company_workType.type_name,
        description: company_workType.type_description,
        price: company_workType.type_price);
    bool isExist = false;

    for (int i = 0; i < workType.length; i++) {
      if (workType[i].id == company_workType.work_id) {
        isExist = true;
        break;
      }
    }
    if (!isExist) {
      workType.add(type);
    }


    /*for (int i = 0; i < workType.length; i++) {
      if (workType[i].id == company_workType.work_id) {
        isExist = true;
        break;
      }
    }*/
    /*if (!isExist) {
      workType.add(type);
    }*/
    notifyListeners();
    /*book_viewModel.invoice_information.bookWorkTypes.contains()
    for(int i = 0 ; i < book_viewModel.invoice_information.bookWorkTypes.length;i++){
      if(id == book_viewModel.invoice_information.bookWorkTypes[i].id)
    }
*/
  }

  void selectAddOnCreate(AddOn addOn) async {
    List<Book_AddOn> addons =
        this.fetchBookInformation.data.booking_information.bookAddOns;
    if (addons == null) {
      addons.add(Book_AddOn(
          count: "1",
          total: addOn.addon_price,
          name: addOn.addon_name,
          description: addOn.addon_description,
          addon_id: addOn.addon_id));
      print("here");
      notifyListeners();
    } else {
      if (addons.length == 0) {
        print("here");

        addons.add(Book_AddOn(
            count: "1",
            total: addOn.addon_price,
            name: addOn.addon_name,
            description: addOn.addon_description,
            addon_id: addOn.addon_id,
            price: addOn.addon_price));
      } else {
        bool isExist = false;
        for (int i = 0; i < addons.length; i++) {
          if (addons[i].addon_id == addOn.addon_id) {
            addons[i].count = (int.parse(addons[i].count) + 1).toString();
            addons[i].total =
                (int.parse(addons[i].price) * int.parse(addons[i].count))
                    .toString();
            isExist = true;
            break;
          }
        }
        if (!isExist) {
          addons.add(Book_AddOn(
              count: "1",
              total: addOn.addon_price,
              name: addOn.addon_name,
              description: addOn.addon_description,
              addon_id: addOn.addon_id,
              price: addOn.addon_price));
        }
      }

      notifyListeners();
    }
  }

  void deleteWorkTypeCreate(String id) {
    List<Book_WorkType> workType =
        this.fetchBookInformation.data.booking_information.bookWorkTypes;

    for (int i = 0; i < workType.length; i++) {
      if (workType[i].id == id) {
        workType.removeAt(i);
        break;
      }
    }
    notifyListeners();
  }

  void deleteAddOnCreate(String id) {
    List<Book_AddOn> addons =
        this.fetchBookInformation.data.booking_information.bookAddOns;
    if (addons != null) {
      for (int i = 0; i < addons.length; i++) {
        if (addons[i].addon_id == id) {
          if (int.parse(addons[i].count) == 1) {
            addons.removeAt(i);
          } else {
            addons[i].count = (int.parse(addons[i].count) - 1).toString();
          }
          /*      addons[i].count = (int.parse(addons[i].count) + 1).toString();
          addons[i].total =
              (int.parse(addons[i].price) * int.parse(addons[i].count))
                  .toString();*/
        }
      }
    }
    notifyListeners();
  }
}
