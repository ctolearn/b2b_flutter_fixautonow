
import 'Job.dart';

class EmployeeDashboard_Count{
  String pending;
  String completed;
  List<Job> jobList ;
  EmployeeDashboard_Count();
  EmployeeDashboard_Count.fromJson(Map<String,dynamic> json):
      pending = json["pending"],
      completed= json["completed"],
      jobList = (json["data"] as Iterable).map((item) => Job.fromJson(item)).toList();

}