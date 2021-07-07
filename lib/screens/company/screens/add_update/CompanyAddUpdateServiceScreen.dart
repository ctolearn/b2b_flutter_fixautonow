import 'dart:developer';

import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/dropdownbutton_formfield_vehicletype.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/Service.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ServiceListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_ServiceListenerViewModel.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/VehicleDropdownListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/ImagePickListener.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/circular_image.dart';
class CompanyAddUpdateServiceScreen extends StatefulWidget {
  CompanyAddUpdateServiceScreen({this.id});

  String id;

  @override
  _CompanyAddUpdateService_ScreenState createState() =>
      _CompanyAddUpdateService_ScreenState();
}

class _CompanyAddUpdateService_ScreenState
    extends State<CompanyAddUpdateServiceScreen> implements MessageCallBack {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ImagePickListener>(context,listen: false).removeFile();
    Future.delayed(
        Duration.zero,
        () => Provider.of<Company_AddUpdate_ServiceListenerViewModel>(context,
                listen: false)
            .resetStatus());
    if (widget.id != null) {
      Provider.of<Company_ServiceListViewModel>(context, listen: false)
          .fetchService(id: widget.id);
    }
/*    Provider.of<Company_ServiceCategoryViewModelList>(context, listen: false)
        .fetchServiceCategory();*/
  }

  List<String> vehicleTypeList = <String>[
    'Coupe',
    "SUV",
    "Minivan",
    "Sedan",
    "Truck"
  ];
  String _vehicleType = 'Coupe';
  TextEditingController serviceName_controller = TextEditingController();
  TextEditingController serviceCategory_controller = TextEditingController();
  TextEditingController serviceStart_controller = TextEditingController();
  TextEditingController serviceEnd_controller = TextEditingController();
  TextEditingController duration_controller = TextEditingController();
  TextEditingController description_controller = TextEditingController();

  TextEditingController name_controller = TextEditingController();
  VoidCallback saveCallBack;

  final vehiclekey = new GlobalKey<DropDownButton_Formfield_VehicleTypeState>();

  void _updateService() {
    var service = Service();

    Provider.of<Company_AddUpdate_ServiceListenerViewModel>(context,
            listen: false)
        .saveService();
  }

  void _saveService() {
    var service = Service();
    service.service_name = serviceName_controller.text;
    service.vehicle_type = _vehicleType;
    service.service_category_id = _serviceCategoryId;
    service.service_start = serviceStart_controller.text;
    service.service_end = serviceEnd_controller.text;
    service.service_approximate = duration_controller.text;
    service.service_description = description_controller.text;

    Provider.of<Company_AddUpdate_ServiceListenerViewModel>(context,
            listen: false)
        .saveService();
  }

  String _serviceCategoryId;

  @override
  Widget build(BuildContext context) {
    var serviceListener = Provider.of<Company_ServiceListViewModel>(context);
    if (widget.id != null) {
      if (serviceListener.fetchResponse.data != null) {
        switch (serviceListener.fetchResponse.status) {
          case Status.COMPLETED:
            Service service = serviceListener.fetchResponse.data;
            _vehicleType = service.vehicle_type;
            serviceName_controller.text = service.service_name;
            serviceCategory_controller.text = service.service_category_name;
            serviceStart_controller.text = service.service_start;
            serviceEnd_controller.text = service.service_end;
            duration_controller.text = service.service_approximate;
            description_controller.text = service.service_description;
            /*** update listener */
            Provider.of<VehicleDropdownListener>(context, listen: false)
                .changeVehicle(vehicle: _vehicleType);
            Provider.of<ImagePickListener>(context,listen: false).changeImage(imagePath: service.service_photo);

/*    if (serviceListener.saveResponse.status != null) {
              switch (serviceListener.saveResponse.status) {
                case Status.COMPLETED:
                  break;
                case Status.ERROR:
                  break;
                case Status.EMPTY:
                  break;
                case Status.LOADING:
                  break;
              }
            }*/

            break;
          case Status.ERROR:
            //show error dialog to reload
            //saveCallBack = _updateAdDOn;
            break;
          case Status.EMPTY:
            //show error cant continue;
            //saveCallBack = _updateAdDOn;
            break;
          case Status.LOADING:
            saveCallBack = null;
            break;
        }
      }
    } else {
      _vehicleType = 'Coupe';
      serviceName_controller.clear();
      serviceCategory_controller.clear();
      serviceStart_controller.clear();
      serviceEnd_controller.clear();
      duration_controller.clear();
      description_controller.clear();
      Provider.of<VehicleDropdownListener>(context,listen: false).changeVehicle(vehicle:  _vehicleType);
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.id == null ? "New Service" : "Update Service"),
        ),
        body: Container(
            color: Colors.white,
            child: ListView(
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                children: [

                  Circular_Image(),
                  Text("Service Name").blackColor().boldText(),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: serviceName_controller,
                    labelText: "",
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //insert contact here
                  Text("Vehicle Type").blackColor().boldText(),
                  DropDownButton_Formfield_VehicleType(
                    key: vehiclekey,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text("Service Opening Time").blackColor().boldText(),
                          CircularTextField(
                            isEnabled: false,
                            descorationSize: DecorationSize.SMALL,
                            controller: serviceStart_controller,
                            hintText: "",
                            color: Colors.white,
                          ),
                        ],
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Text("Service Closing Time").blackColor().boldText(),
                          CircularTextField(
                            isEnabled: false,
                            descorationSize: DecorationSize.SMALL,
                            controller: serviceEnd_controller,
                            hintText: "",
                            color: Colors.white,
                          ),
                        ],
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Approximate Service Duration in Hours")
                      .blackColor()
                      .boldText(),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: duration_controller,
                    hintText: "",
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Description").blackColor().boldText(),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: description_controller,
                    hintText: "",
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<Company_AddUpdate_ServiceListenerViewModel>(
                    builder: (context, value, child) {
                      VoidCallback transactCallback;
                      if (widget.id == null) {
                        transactCallback =
                            (value.saveResponse.status == Status.LOADING
                                ? null
                                : saveCallBack);
                      } else {
                        if (serviceListener.fetchResponse.status ==
                                Status.COMPLETED &&
                            value.saveResponse.status != Status.LOADING) {
                          transactCallback = _updateService;
                        } else {
                          transactCallback = null;
                        }
                      }
                      return ElevatedButton(
                          onPressed: transactCallback,
                          child: Text(widget.id == null
                              ? "Save Service"
                              : "Update Service"));
                    },
                  )
                ])));
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
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
}
