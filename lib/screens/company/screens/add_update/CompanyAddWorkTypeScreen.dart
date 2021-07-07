import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_WorkTypeListModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_WorkTypeModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_UsersListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_WorkTypeListenerViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/search/CompanyWorkTypesListScreen.dart';

class CompanyAddWorkType_Screen extends StatefulWidget {
  CompanyAddWorkType_Screen(this.service_id);

  String service_id;

  @override
  _CompanyAddWorkType_ScreenState createState() =>
      _CompanyAddWorkType_ScreenState();
}

class _CompanyAddWorkType_ScreenState extends State<CompanyAddWorkType_Screen> {
/*
  List<Company_WorkTypeModel> getAllSelected(
      List<Company_WorkTypeModel> selected) {
    List<Company_WorkTypeModel> selectedList = [];
    for (int i = 0; i < selected.length; i++) {
      if (selected[i].workType.selected == true) {
        selectedList.add(selected[i]);
      }
    }

    return selectedList;
  }

  List<TextEditingController> _controllers = [];
*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  showWorkTypeList() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new CompanyWorkTypesListScreen(
            service_id: widget.service_id,
          );
        },
        fullscreenDialog: true));
  }
  _saveWorkType(){
    Provider.of<Company_AddUpdate_WorkTypeListenerViewModel>(context,listen: false).saveWorkType();
  }
  List<TextEditingController> _controllers = [];

  @override
  Widget build(BuildContext context) {
    var workList = Provider.of<Company_WorkTypeListModel>(context);
    Widget itemWidget = Container();

    return Scaffold(
        floatingActionButton: SizedBox(
            width: 35,
            height: 35,
            child: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
                //show dialog
                showWorkTypeList();
              },
              child: const FaIcon(
                FontAwesomeIcons.plus,
                size: 14,
              ),
              backgroundColor: Colors.blue,
            )),
        appBar: AppBar(centerTitle: true,title: Text("New Work Type"),),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Expanded(
                  child: ListView.builder(
                itemCount: workList.choosenWorkModel.length,
                padding: EdgeInsets.all(8),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  _controllers.add(new TextEditingController());
                  return Row(
                    key: ValueKey(workList.choosenWorkModel[index].workType.id),
                    children: [
                      Expanded(
                          child: Text(
                              workList.choosenWorkModel[index].workType.name)),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: CupertinoTextField(
                        key: ValueKey(
                            workList.choosenWorkModel[index].workType.id),
                        placeholder: "Enter Price",
                        onChanged: (text) {
                          _controllers[index].text = text;
                        },
                        controller: _controllers[index],
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          workList.removeSelected(
                              workList.choosenWorkModel[index].workType.id);
                          _controllers.removeAt(index);
                        },
                        child: Text("Remove Item"),
                      )),
                    ],
                  );
                },
              )),
              Consumer<Company_AddUpdate_WorkTypeListenerViewModel>(builder: (context, value, child) {

                return ElevatedButton(
                  onPressed: value.saveResponse.status == Status.LOADING ? null : _saveWorkType ,
                  child: const Text('Save WorkType',),
                );
              },)
            ])));
  }
}

