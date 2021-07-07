import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class NotificationListItemView extends StatelessWidget {
  Company_DashBoardModel dashboardModel;

  NotificationListItemView({Key key, this.dashboardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var date = DateTime.parse(dashboardModel.dashBoardBook.timestamp);
    var amPm = DateFormat("a").format(date);



    return PhysicalModel(
        elevation: 6.0,
        shape: BoxShape.rectangle,
        shadowColor: Colors.black54,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        child: Card(
            elevation: 0,
            child: IntrinsicHeight(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dashboardModel.dashBoardBook.company_name,style: TextStyle(fontSize: 13)),
                  const SizedBox(height: 2,),
                  Container(
                    child: Text(dashboardModel.dashBoardBook.category_name,style: TextStyle(color: Colors.white,fontSize: 10),),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                    margin: EdgeInsets.only(right: 5),
                  ),
                  const SizedBox(height: 2,),
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(child: FaIcon(
                          FontAwesomeIcons.calendarAlt,
                          size: 15,
                          color: Colors.grey,
                        )),
                        WidgetSpan(child: SizedBox(width: 5,)),
                        TextSpan(text: dashboardModel.dashBoardBook.timestamp+" "+amPm,style: TextStyle(fontSize: 13,color:Colors.grey )),
                        WidgetSpan(child: SizedBox(width: 5,)),

                      ],
                    ))

                    ],
              ),
            ))));
  }
}
