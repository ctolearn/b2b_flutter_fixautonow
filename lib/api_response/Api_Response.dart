import 'package:b2b_flutter_fixautonow/enum/Status.dart';

class ApiResponse<T>{
  ApiResponse({this.status});
  T data;
  Status status;
  String message;
  String crudType;
  ApiResponse.loading({this.crudType}): status = Status.LOADING;
  ApiResponse.completed(T data,{this.crudType}){
    this.data = data;
    this.status = Status.COMPLETED;
  }
  ApiResponse.error({this.message,this.crudType}){
    this.status = Status.ERROR;
  }
  ApiResponse.empty({this.crudType}){
    this.status = Status.EMPTY;
  }
}