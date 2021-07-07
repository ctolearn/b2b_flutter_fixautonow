import 'dart:convert';
import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/Service.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookVehicleModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ServiceListViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/book_uploadimage.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookServiceListViewModel.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/book_on.dart';
import 'BookServiceCategoryListScreen.dart';
import 'BookServiceDataSelectScreen.dart';
import 'BookServiceSelectScreen.dart';
import 'BookVehicleMakeSelectScreen.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/dropdownbutton_formfield_vehicletype.dart';
class BookScreen extends StatefulWidget {
  String service_id;

  BookScreen({this.service_id});

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> implements MessageCallBack {
  TextEditingController serviceCategory_controller =
      new TextEditingController();
  TextEditingController vehicleType_controller = new TextEditingController();
  TextEditingController vehicleMake_controller = new TextEditingController();
  TextEditingController companyName_controller = new TextEditingController();
  TextEditingController date_controller = new TextEditingController();
  TextEditingController duedate_controller = new TextEditingController();
  TextEditingController year_controller = new TextEditingController();
  TextEditingController time_controller = new TextEditingController();
  TextEditingController min_price_controller = new TextEditingController();
  TextEditingController max_price_controller = new TextEditingController();
  TextEditingController vin_controller = new TextEditingController();
  TextEditingController remarks_controller = new TextEditingController();
  TextEditingController vehicleModel_controller = new TextEditingController();
  String _serviceCategoryId, service_id;
  final vehicleTypeKey = new GlobalKey<DropDownButton_Formfield_VehicleTypeState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchDataModels(widget.service_id);
/*    service_id = widget.service_id;

    if (widget.service_id == null) {
      Provider.of<Company_ServiceListViewModel>(context, listen: false)
          .resetInformation();
      Provider.of<Company_BookViewModelListener>(context, listen: false)
          .fetchSelection();
    } else {
      Provider.of<Company_ServiceListViewModel>(context, listen: false)
          .resetInformation();
      Provider.of<Company_ServiceListViewModel>(context, listen: false)
          .fetchServiceInformation(widget.service_id);
    }
    Provider.of<Company_BookViewModelListener>(context, listen: false)
        .fetchVehicleModel();
    print(widget.service_id);*/
  }

  void fetchDataModels(String service_id) {
    service_id = widget.service_id;
    if (widget.service_id != null) {
      /** */
      print("from service");
      Provider.of<Company_BookServiceListViewModel>(context, listen: false)
          .fetchServiceInformation(widget.service_id);
/*      Provider.of<Company_ServiceListViewModel>(context, listen: false)
          .resetInformation();
      Provider.of<Company_BookViewModelListener>(context, listen: false)
          .fetchSelection();*/
    } else {
      /** */

      print("normal");
/*      Provider.of<Company_ServiceListViewModel>(context, listen: false)
          .resetInformation();
      Provider.of<Company_ServiceListViewModel>(context, listen: false)
          .fetchServiceInformation(widget.service_id);*/
    }

  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  VoidCallback chooseType;

  void chooseBookWorkType() {
    showWorkType("category");
  }

  void chooseBookWorkTypeSelected() {
    showWorkType("");
  }

  Future<void> saveBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //for realtime
    var bookWorkSelectionModel =
        Provider.of<Company_BookViewModelListener>(context, listen: false);
    //for service
    var bookSelectedService =
        Provider.of<Company_BookServiceListViewModel>(context, listen: false);

    if (service_id == null) {
      String vehicle_make = vehicleMake_controller.text;
      String plate_number = vin_controller.text;
      String date = date_controller.text;
      String due_date = duedate_controller.text;
      String time = time_controller.text;
      String remarks = remarks_controller.text;
      String vehicle_year = year_controller.text;
      String min_price = min_price_controller.text;
      String max_price = max_price_controller.text;
      if (serviceCategory_controller.text.isEmpty) {
        showMessage("Choose service");
        return;
      } else if (vehicle_make.isEmpty) {
        showMessage("Choose vehicle make");
        return;
      } else if (vehicle_year.isEmpty) {
        showMessage("Vehicle year is empty");
        return;
      } else if (plate_number.isEmpty) {
        showMessage("Vehicle Identification number is empty");
        return;
      } else if (date.isEmpty) {
        showMessage("Date of service is empty");
        return;
      } else if (due_date.isEmpty) {
        showMessage("Due date of service is empty");
        return;
      } else if (time.isEmpty) {
        showMessage("Time of service is empty");
        return;
      } else if (vehicle_year.length < 4) {
        showMessage("Vehicle year is invalid");
        return;
      } else if (bookWorkSelectionModel.vehicleImages.length < 4) {
        showMessage(
            "Please upload image of your car front , left , right , back");
        return;
      } else if (bookWorkSelectionModel.workTypeSelectionList.length == 0) {
        showMessage("You must choose type on type of service");
        return;
      }
      Map<String, dynamic> mapData = new Map();
      print(min_price);
      if (bookWorkSelectionModel.isRange) {
        min_price = "";
        max_price = "";
        mapData.putIfAbsent("no_range", () => "1");
        mapData.putIfAbsent("min_price", () => min_price);
        mapData.putIfAbsent("max_price", () => max_price);
      } else {
        if (min_price.isEmpty) {
          showMessage("Min price is empty");
        } else if (max_price.isEmpty) {
          showMessage("Max price is empty");
        } else if (int.parse(max_price.replaceAll(",", "")) <=
            int.parse(min_price.replaceAll(",", ""))) {
          showMessage("Min price is greater than your max price");
        } else {
          mapData.putIfAbsent("no_range", () => "0");
          mapData.putIfAbsent("min_price", () => min_price);
          mapData.putIfAbsent("max_price", () => max_price);
        }
      }

      mapData.putIfAbsent("category_id", () => _serviceCategoryId);
      mapData.putIfAbsent("vehicle_make", () => vehicle_make);
      mapData.putIfAbsent("vehicle_type", () => vehicleTypeKey.currentState.dropDownVehicleType);
      mapData.putIfAbsent(
          "vehicle_model",
          () => vehicleModel_controller.text.isEmpty
              ? ""
              : vehicleModel_controller.text);
      mapData.putIfAbsent("vehicle_year", () => vehicle_year);
      mapData.putIfAbsent("plate_number", () => plate_number);
      mapData.putIfAbsent("date", () => date);
      mapData.putIfAbsent("due_date", () => due_date);
      mapData.putIfAbsent("time", () => time);
      mapData.putIfAbsent("remarks", () => remarks);
      // mapData.putIfAbsent("timestamp", () =>(Math.floor(DateTime.now().microsecondsSinceEpoch / 1000)))
      mapData.putIfAbsent("timestamp",
          () => (DateTime.now().microsecondsSinceEpoch / 1000).floor());
      mapData.putIfAbsent("array",
          () => json.encode(bookWorkSelectionModel.selected_bookWorkType));
      mapData.putIfAbsent("func", () => "book_realtime");
      mapData.putIfAbsent("module", () => "book");
      mapData.putIfAbsent(
          "company_id", () => prefs.getString('current_company'));
      mapData.putIfAbsent("user_id", () => prefs.getString('current_id'));

      /* final files = <MapEntry<String, MultipartFile>>[];
      bookWorkSelectionModel.vehicleImages.forEach((element)async{
        print("Path is : "+element.file.path);
        files.add(
            MapEntry('image_files[]',
              await MultipartFile.fromFile(element.file.path,filename:element.file.path.split("/").last),
            )
        );
      });
      */
      var formData = FormData.fromMap(mapData);
      /** to save image */
      bookWorkSelectionModel.vehicleImages.forEach((element) async {
        print("Path is : " + element.file.path);
        formData.files.add(MapEntry(
          'image_files[]',
          await MultipartFile.fromFile(element.file.path,
              filename: element.file.path.split("/").last),
        ));
      });

      bookWorkSelectionModel.uploadBook(formData);
    } else {
      Map<String, dynamic> mapData = new Map();
      String vehicle_make = vehicleMake_controller.text;
      String plate_number = vin_controller.text;
      String date = date_controller.text;
      String due_date = duedate_controller.text;
      String time = time_controller.text;
      String remarks = remarks_controller.text;
      String vehicle_year = year_controller.text;

      if (vehicle_make.isEmpty) {
        showMessage("Choose vehicle make");
        return;
      } else if (vehicle_year.isEmpty) {
        showMessage("Vehicle year is empty");
        return;
      } else if (plate_number.isEmpty) {
        showMessage("Vehicle Identification number is empty");
        return;
      } else if (date.isEmpty) {
        showMessage("Date of service is empty");
        return;
      } else if (due_date.isEmpty) {
        showMessage("Due date of service is empty");
        return;
      } else if (time.isEmpty) {
        showMessage("Time of service is empty");
        return;
      } else if (vehicle_year.length < 4) {
        showMessage("Vehicle year is invalid");
        return;
      } else if (bookWorkSelectionModel.vehicleImages.length < 4) {
        showMessage(
            "Please upload image of your car front , left , right , back");
        return;
      } else if (bookSelectedService.selected_companyWorkTypeList.length == 0) {
        showMessage("You must choose type on type of service");
        return;
      }

      mapData.putIfAbsent("service_id", () => service_id);
      mapData.putIfAbsent("category_id", () => service.service_category_id);
      mapData.putIfAbsent("vehicle_make", () => vehicle_make);
      mapData.putIfAbsent("vehicle_type", () => vehicleTypeKey.currentState.dropDownVehicleType);
      mapData.putIfAbsent(
          "vehicle_model",
          () => vehicleModel_controller.text.isEmpty
              ? ""
              : vehicleModel_controller.text);
      mapData.putIfAbsent("vehicle_year", () => vehicle_year);
      mapData.putIfAbsent("plate_number", () => plate_number);
      mapData.putIfAbsent("date", () => date);
      mapData.putIfAbsent("due_date", () => due_date);
      mapData.putIfAbsent("time", () => time);
      mapData.putIfAbsent("remarks", () => remarks);
      mapData.putIfAbsent("seller_id", () => service.company_id);
      mapData.putIfAbsent("func", () => "book_service");
      mapData.putIfAbsent("module", () => "book");
      mapData.putIfAbsent(
          "company_id", () => prefs.getString('current_company'));
      mapData.putIfAbsent("user_id", () => prefs.getString('current_id'));
      mapData.putIfAbsent("timestamp",
          () => (DateTime.now().microsecondsSinceEpoch / 1000).floor());
      mapData.putIfAbsent("array",
          () => json.encode(bookSelectedService.selected_companyWorkTypeList));
      var formData = new FormData.fromMap(mapData);
      /** to save image */
      bookWorkSelectionModel.vehicleImages.forEach((element) async {
        print("Path is : " + element.file.path);
        formData.files.add(MapEntry(
          'image_files[]',
          await MultipartFile.fromFile(element.file.path,
              filename: element.file.path.split("/").last),
        ));
      });
    }
  }

  /** for formating controllers */
  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale)
      .format(int.parse(s.replaceAll(",", "")));

  Function onChangeInput(TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      String tempValue = _formatNumber(controller.text);
      controller.value = TextEditingValue(
          text: _formatNumber(
            tempValue,
          ),
          selection: TextSelection.collapsed(offset: tempValue.length));
    }
  }

  Service service;

  @override
  Widget build(BuildContext context) {
    //for future use
    final orientation = MediaQuery.of(context).orientation;
    var bookWorkSelectionModel =
        Provider.of<Company_BookViewModelListener>(context);
    var bookSelectedServiceModel =
        Provider.of<Company_BookServiceListViewModel>(context);
    var bookSelectedVehicleModel =
        Provider.of<Company_BookServiceListViewModel>(context);

    if (widget.service_id == null) {
      if (bookWorkSelectionModel.workType_Selection != null) {
        serviceCategory_controller.text =
            bookWorkSelectionModel.workType_Selection.service_name;
        _serviceCategoryId =
            bookWorkSelectionModel.workType_Selection.service_category_id;
      }
      chooseType = chooseBookWorkTypeSelected;
    } else {
      if (bookSelectedServiceModel.serviceInfoResponse.status == Status.COMPLETED) {
        service = bookSelectedServiceModel.serviceInfoResponse.data;
        serviceCategory_controller.text = service.service_name;
        vehicleType_controller.text = service.vehicle_type;
        companyName_controller.text = service.company_name;
      }
      chooseType = chooseBookWorkType;
    }
    if (bookWorkSelectionModel.vehicle_make != null) {
      vehicleMake_controller.text =
          bookWorkSelectionModel.vehicle_make.make_title;
    }

    if (bookWorkSelectionModel.isRange) {
      min_price_controller.clear();
      max_price_controller.clear();
    }

    Widget buttonBook = widget.service_id == null
        ? ElevatedButton(
            child: Text("Book Now"),
            onPressed: bookWorkSelectionModel.bookResponse.status ==
                        Status.COMPLETED &&
                    bookSelectedVehicleModel.fetchServiceResponse.status ==
                        Status.COMPLETED
                ? saveBooking
                : null)
        : ElevatedButton(
            child: Text("Book Now"),
            onPressed: bookSelectedVehicleModel.fetchServiceResponse.status ==
                    Status.COMPLETED
                ? saveBooking
                : null);

    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Book Service"),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            padding:
                const EdgeInsets.only(top: 70.0, left: 8, right: 8, bottom: 8),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.service_id == null ? "Service" : "Service Name")
                      .blackColor()
                      .boldText(),
                  SizedBox(
                    height: 5,
                  ),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: false,
                    controller: serviceCategory_controller,
                    hintText: "Choose Service",
                    onTap: widget.service_id == null
                        ? () {
                            showCategoryList();
                          }
                        : null,
                    color: Colors.white,
                  ),
                ],
              ),
              IntrinsicHeight(
                  child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding:
                          EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                    ),
                    child: Text(
                      "On",
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: widget.service_id == null
                        ? (_serviceCategoryId == null
                            ? null
                            : chooseBookWorkType)
                        : (bookSelectedServiceModel.serviceInfoResponse.status ==
                                Status.COMPLETED
                            ? chooseBookWorkTypeSelected
                            : null),
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Book_On(
                        service_id: widget.service_id,
                      )),
                ],
              )),
              SizedBox(
                height: 5,
              ),
              widget.service_id == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Company Name").blackColor().boldText(),
                        SizedBox(
                          height: 5,
                        ),
                        CircularTextField(
                          descorationSize: DecorationSize.SMALL,
                          isEnabled: false,
                          controller: companyName_controller,
                          hintText: "Company Name",
                          color: Colors.white,
                        )
                      ],
                    ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vehicle Type").blackColor().boldText(),
                  SizedBox(
                    height: 5,
                  ),
                  widget.service_id != null
                      ? CircularTextField(
                          descorationSize: DecorationSize.SMALL,
                          isEnabled: false,
                          controller: vehicleType_controller,
                          hintText: "eg 1",
                          color: Colors.white,
                        )
                      : DropDownButton_Formfield_VehicleType(),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vehicle Make").blackColor().boldText(),
                  SizedBox(
                    height: 5,
                  ),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: false,
                    controller: vehicleMake_controller,
                    hintText: "Choose Vehicle Make",
                    color: Colors.white,
                    onTap: () {
                      showVehicleMake();
                    },
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vehicle Model ( Optional ) ").blackColor().boldText(),
                  SizedBox(
                    height: 5,
                  ),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: vehicleModel_controller,
                    hintText: "e.g Tesla Model X",
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vehicle Year ").blackColor().boldText(),
                  SizedBox(
                    height: 5,
                  ),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: false,
                    controller: year_controller,
                    hintText: "e.g 2021",
                    color: Colors.white,
                    onTap: () {
                      _yearPickerDialoag();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              constraint.maxWidth > 400
                  ? Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date").blackColor().boldText(),
                              SizedBox(
                                height: 5,
                              ),
                              CircularTextField(
                                descorationSize: DecorationSize.SMALL,
                                isEnabled: false,
                                controller: date_controller,
                                hintText: "e.g 1",
                                color: Colors.white,
                                onTap: () {
                                  _datePickerDialog();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Due Date").blackColor().boldText(),
                              SizedBox(
                                height: 5,
                              ),
                              CircularTextField(
                                descorationSize: DecorationSize.SMALL,
                                isEnabled: false,
                                controller: duedate_controller,
                                hintText: "e.g 1",
                                color: Colors.white,
                                onTap: () {
                                  _dueDatePickerDialog();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Time").blackColor().boldText(),
                              SizedBox(
                                height: 5,
                              ),
                              CircularTextField(
                                descorationSize: DecorationSize.SMALL,
                                isEnabled: false,
                                controller: time_controller,
                                hintText: "e.g 1",
                                color: Colors.white,
                                onTap: () {
                                  _timePickerDialog();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date").blackColor().boldText(),
                        SizedBox(
                          height: 5,
                        ),
                        CircularTextField(
                          descorationSize: DecorationSize.SMALL,
                          isEnabled: false,
                          controller: date_controller,
                          hintText: "e.g 1",
                          color: Colors.white,
                          onTap: () {
                            _datePickerDialog();
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Due Date").blackColor().boldText(),
                            SizedBox(
                              height: 5,
                            ),
                            CircularTextField(
                              descorationSize: DecorationSize.SMALL,
                              isEnabled: false,
                              controller: duedate_controller,
                              hintText: "e.g 1",
                              color: Colors.white,
                              onTap: () {
                                _dueDatePickerDialog();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Time").blackColor().boldText(),
                            SizedBox(
                              height: 5,
                            ),
                            CircularTextField(
                              descorationSize: DecorationSize.SMALL,
                              isEnabled: false,
                              controller: time_controller,
                              hintText: "e.g 1",
                              color: Colors.white,
                              onTap: () {
                                _timePickerDialog();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

              SizedBox(
                width: 5,
              ),
              //2nd
              widget.service_id == null
                  ? constraint.maxWidth > 400
                      ? IntrinsicHeight(
                          child: Row(
                          children: [
                            Column(
                              children: <Widget>[
                                Text("No Range ? ").blackColor().boldText(),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  // add this
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Row(children: [
                                        SizedBox(
                                            height: 24.0,
                                            width: 24.0,
                                            child: Checkbox(
                                                value: bookWorkSelectionModel
                                                    .isRange,
                                                activeColor: Colors.blue,
                                                onChanged: (bool newValue) {
                                                  bookWorkSelectionModel
                                                      .setRange(newValue);
                                                  print("checked");
                                                })),
                                        Text("Check Me ")
                                            .blackColor()
                                            .boldText(),
                                      ])),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Minimum Price").blackColor().boldText(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CircularTextField(
                                    descorationSize: DecorationSize.SMALL,
                                    isEnabled: bookWorkSelectionModel.isRange
                                        ? false
                                        : true,
                                    controller: min_price_controller,
                                    hintText: "e.g 1",
                                    maxlength: 19,
                                    textInputType: TextInputType.number,
                                    color: Colors.white,
                                    onChange: (String val) {
                                      onChangeInput(min_price_controller);
                                    },
                                  ),
                                  /*       CupertinoTextField(
                                    placeholder: "eg 1",
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9,]')),
                                    ],
                                    onChanged: (String value) {
                                      onChangeInput(min_price_controller);
                                    },
                                    maxLength: 19,
                                    controller: min_price_controller,
                                    keyboardType: TextInputType.number,
                                    enabled: bookWorkSelectionModel.isRange
                                        ? false
                                        : true,
                                  ),*/
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Maximum Price").blackColor().boldText(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CircularTextField(
                                    descorationSize: DecorationSize.SMALL,
                                    isEnabled: bookWorkSelectionModel.isRange
                                        ? false
                                        : true,
                                    controller: max_price_controller,
                                    hintText: "e.g 1",
                                    maxlength: 19,
                                    textInputType: TextInputType.number,
                                    color: Colors.white,
                                    onChange: (String val) {
                                      onChangeInput(max_price_controller);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Row(
                                children: <Widget>[
                                  Text("No Range ?").blackColor().boldText(),
                                  Expanded(
                                    // add this
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Row(children: [
                                          SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: Checkbox(
                                                  value: bookWorkSelectionModel
                                                      .isRange,
                                                  activeColor: Colors.blue,
                                                  onChanged: (bool newValue) {
                                                    bookWorkSelectionModel
                                                        .setRange(newValue);
                                                  })),
                                          Text("Check Me")
                                              .blackColor()
                                              .boldText(),
                                        ])),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Minimum Price").blackColor().boldText(),
                              SizedBox(
                                height: 5,
                              ),
                              CircularTextField(
                                descorationSize: DecorationSize.SMALL,
                                isEnabled: bookWorkSelectionModel.isRange
                                    ? false
                                    : true,
                                controller: min_price_controller,
                                hintText: "e.g 1",
                                maxlength: 19,
                                textInputType: TextInputType.number,
                                color: Colors.white,
                                onChange: (String val) {
                                  onChangeInput(min_price_controller);
                                },
                              )
                              /* CupertinoTextField(
                                placeholder: "eg 1",
                                maxLength: 19,
                                controller: min_price_controller,
                                keyboardType: TextInputType.number,
                                onChanged: (String value) {
                                  onChangeInput(max_price_controller);
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp('^[0-9,]')),
                                ],
                                enabled: bookWorkSelectionModel.isRange
                                    ? false
                                    : true,
                              )*/
                              ,
                              SizedBox(
                                height: 5,
                              ),
                              Text("Maximum Price").blackColor().boldText(),
                              SizedBox(
                                height: 5,
                              ),
                              CircularTextField(
                                descorationSize: DecorationSize.SMALL,
                                isEnabled: bookWorkSelectionModel.isRange
                                    ? false
                                    : true,
                                controller: max_price_controller,
                                hintText: "e.g 1",
                                maxlength: 19,
                                textInputType: TextInputType.number,
                                color: Colors.white,
                                onChange: (String val) {
                                  onChangeInput(max_price_controller);
                                },
                              ),
                            ])
                  : Container(),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vehicle Identification Number").blackColor().boldText(),
                  SizedBox(
                    height: 5,
                  ),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: vin_controller,
                    hintText: "e.g 3688P",
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Remarks").blackColor().boldText(),
                  SizedBox(
                    height: 5,
                  ),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: remarks_controller,
                    hintText: "Add Remarks If Any",
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding:
                          EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                    ),
                    icon: FaIcon(Icons.image_outlined),
                    label: Text(
                      "Upload",
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: press,
                  ),
                  Flexible(fit: FlexFit.tight, child: Book_UploadImage())
                ],
              ),

              bookWorkSelectionModel.vehicleImages.length == 0
                  ? Container()
                  : GridView.builder(
                      padding: const EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bookWorkSelectionModel.vehicleImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                            key: ValueKey(
                                bookWorkSelectionModel.vehicleImages[index].id),
                            child: Stack(children: [
                              Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.file(
                                    bookWorkSelectionModel
                                        .vehicleImages[index].file,
                                    height: 190,
                                    fit: BoxFit.fill,
                                  )),
                              Positioned(
                                  right: 0.0,
                                  child: InkResponse(
                                      child: GestureDetector(
                                    onTap: () => bookWorkSelectionModel
                                        .removeImage(bookWorkSelectionModel
                                            .vehicleImages[index]),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              "x",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ))),
                            ]));
                      }),
              buttonBook
            ],
          ),
        );
      }),
    ));
  }

  showCategoryList() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new BookServiceCategoryListScreen();
        },
        fullscreenDialog: true));
  }

  showWorkType(String type) {
    if (type == "category") {
      Navigator.of(context).push(new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return new BookServiceSelectScreen(
              category_id: _serviceCategoryId,
            );
          },
          fullscreenDialog: true));
    } else {
      Navigator.of(context).push(new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return new BookServiceDataSelectScreen();
          },
          fullscreenDialog: true));
    }
  }

  showVehicleMake() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new BookVehicleMakeSelectScreen();
        },
        fullscreenDialog: true));
  }

  void press() async {
    Provider.of<Company_BookViewModelListener>(context, listen: false)
        .pickImages(messageCallBack: this);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)))));
  }

  DateTime _selectedDate = DateTime.now();

  void _yearPickerDialoag() {
    DatePicker.showPicker(context, showTitleActions: true, onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      year_controller.text = DateFormat('yyyy').format(date);
      print(DateFormat('yyyy').format(date));
    },
        pickerModel: YearMonthModel(currentTime: DateTime.now()),
        locale: LocaleType.en);
  }

  void _datePickerDialog() async {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(DateTime.now().year + 1, 1), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      date_controller.text = DateFormat('yyyy-MM-dd').format(date);
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void _dueDatePickerDialog() async {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(DateTime.now().year + 1, 1), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      duedate_controller.text = DateFormat('yyyy-MM-dd').format(date);
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void _timePickerDialog() async {
    DatePicker.showTime12hPicker(context, showTitleActions: true,
/*        minTime: DateTime.now(),
        maxTime: DateTime(DateTime.now().year + 1, 1),*/
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      time_controller.text = DateFormat('hh:mm:a').format(date);
      print(DateFormat('hh:mm:a').format(date));
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}

class YearMonthModel extends DatePickerModel {
  YearMonthModel(
      {DateTime currentTime,
      DateTime maxTime,
      DateTime minTime,
      LocaleType locale})
      : super(
            currentTime: currentTime,
            maxTime: maxTime,
            minTime: minTime,
            locale: locale);

  @override
  List<int> layoutProportions() {
    // TODO: implement layoutProportions

    return [1, 0, 0];
  }
}
