class CustomDialogViewModel {
  String type;

  CustomDialogViewModel({this.type});

  String getTitle() {
    switch (type) {
      case "cancel":
        return "Cancel Order";
        break;
      case "delete":
        return "Deleting Item";
        break;
      case "decline":
        return "Declining Item";
        break;
      case "accept":
        return "Accepting Booking";
        break;
      case "accomplish":
        return "Accomplishing Order";
        break;
        case "complete":
        return "Completing Order";
        break;
    }
  }

  String getMessage() {
    switch (type) {
      case "cancel":
        return "Do you want to cancel this order?";
        break;
      case "delete":
        return "Do you want to delete this item?";
        break;

      case "decline":
        return "Do you want to decline this item";
        break;
      case "accept":
        return "Do you want to accept this booking?";
        break;
      case "accomplish":
        return "Do you want to accomplish this order ?";
        break;
      case "complete":
        return "Do you want to complete this order ?";
        break;
    }
  }
}
