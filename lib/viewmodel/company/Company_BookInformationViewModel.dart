

import 'package:b2b_flutter_fixautonow/model/BookReceive_Info.dart';
import 'package:b2b_flutter_fixautonow/model/Booking_Information.dart';
import 'package:b2b_flutter_fixautonow/model/Invoice_Information.dart';

class Company_BookInformationViewModel {
  Invoice_Information invoice_information;
  BookReceive_Info bookReceive_Info;
  Booking_Information booking_information;

  Company_BookInformationViewModel.setInvoiceInformation(
      Invoice_Information invoice_information) {
    this.invoice_information = invoice_information;
  }

  Company_BookInformationViewModel.setBookReceiveInformation(BookReceive_Info bookReceive_Info) {
    this.bookReceive_Info = bookReceive_Info;
  }

  Company_BookInformationViewModel.setBookingInformation(
      Booking_Information booking_information) {
    this.booking_information = booking_information;
  }

  String companyNameTo() {
    String name = invoice_information.name.isNotEmpty
        ? invoice_information.name
        : invoice_information.parent_name +
            " " +
            invoice_information.state +
            " " +
            invoice_information.city;
    return name;
  }

  String companyNameFrom() {
    String name = invoice_information.seller_name.isNotEmpty
        ? invoice_information.seller_name
        : invoice_information.seller_parent_name +
            " " +
            invoice_information.seller_state +
            " " +
            invoice_information.seller_city;
    return name;
  }

  String bookCompanyNameTo() {
    String name = booking_information.name.isNotEmpty
        ? booking_information.name
        : booking_information.parent_name +
            " " +
            booking_information.state +
            " " +
            booking_information.city;
    return name;
  }

}
