import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_OutlierListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_OutliersListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/dropdownbutton_formfield_outliertype.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/OutlierTypeDropdownListener.dart';
class CompanyAddUpdateOutliersScreen extends StatefulWidget {
  CompanyAddUpdateOutliersScreen({this.id});

  String id;

  @override
  _CompanyAddUpdateOutlers_ScreenState createState() =>
      _CompanyAddUpdateOutlers_ScreenState();
}

class _CompanyAddUpdateOutlers_ScreenState
    extends State<CompanyAddUpdateOutliersScreen> implements MessageCallBack {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration.zero,
        () => Provider.of<Company_AddUpdate_OutliersListenerViewModel>(context,
                listen: false)
            .resetStatus());

    if (widget.id != null) {
      Provider.of<Company_OutlierListViewModel>(context, listen: false)
          .fetchOutlier(id: widget.id);
    }

    outlierCompany_controller = TextEditingController();
  }

  TextEditingController outlierCompany_controller;
  String _companyId, _type;
  final outlierTypeKey = GlobalKey<DropDownButton_Formfield_OutlierTypeState>();

  void _updateOutliers() {
    Provider.of<Company_AddUpdate_OutliersListenerViewModel>(context,
            listen: false)
        .saveOutlier();
/*    var company = Provider.of<Company_CompanyViewModelList>(context, listen: false).company;
    if (company == null && _companyId == null) {
      showMessage("Select company to make outlier");
    } else {
      var comp =  new Company();
      comp.company_id = _companyId;
      Provider.of<Company_OutlierListViewModel>(context, listen: false)
          .saveOutlier(id: widget.id, company_id: company == null ? comp.company_id : company.company_id, messageCallBack: this);
    }*/
  }

  void _saveOutliers() {
    Provider.of<Company_AddUpdate_OutliersListenerViewModel>(context,
            listen: false)
        .saveOutlier();
/*    var company = Provider.of<Company_CompanyViewModelList>(context, listen: false).company;
    if (company == null) {
      showMessage("Select company to make outlier");
    } else {
      Provider.of<Company_OutlierListViewModel>(context, listen: false)
          .saveOutlier(id: widget.id, company_id: company.company_id, messageCallBack: this);
    }*/
  }

  TextEditingController name_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var outlierListener = Provider.of<Company_OutlierListViewModel>(context);

    if (widget.id != null) {
      if (outlierListener.fetchResponse.data != null) {
        switch (outlierListener.fetchResponse.status) {
          case Status.COMPLETED:
            var outlierItem = outlierListener.fetchResponse.data;
            var name = outlierItem.no_parent.isNotEmpty
                ? outlierItem.no_parent
                : outlierItem.parent_name +
                    " " +
                    outlierItem.no_parent_state +
                    " " +
                    outlierItem.no_parent_city;
            outlierCompany_controller.text = name;
            _type = outlierItem.outlier_type;
            _companyId = outlierItem.outlier_id;
            /** listener **/
            Provider.of<OutlierTypeDropdownListener>(context,listen: false).changeOutlier(outlier:_type);
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
            break;
        }
      }
    } else {}

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.id == null ? "New Outlier" : "Update Outlier"),
        ),
        body: Container(
            color: Colors.white,
            child: ListView(
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  Text("Outlier Company").blackColor().boldText(),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: outlierCompany_controller,
                    hintText: "",
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //insert contact here
                  Text("Outlier Type").blackColor().boldText(),
                  DropDownButton_Formfield_OutlierType(
                    key: outlierTypeKey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<Company_AddUpdate_OutliersListenerViewModel>(
                    builder: (context, value, child) {
                      VoidCallback transactCallback;
                      if (widget.id == null) {
                        transactCallback =
                            (value.saveResponse.status == Status.LOADING
                                ? null
                                : _saveOutliers);
                      } else {
                        if (outlierListener.fetchResponse.status ==
                                Status.COMPLETED &&
                            value.saveResponse.status != Status.LOADING) {
                          transactCallback = _updateOutliers;
                        } else {
                          transactCallback = null;
                        }
                      }

                      return ElevatedButton(
                          onPressed: transactCallback,
                          child: Text(widget.id == null
                              ? "Save Outlier"
                              : "Update Outlier"));
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
