import 'package:mobile_assessment/common/io/data.dart';
import 'package:mobile_assessment/modules/home/models/employee.model.dart';
import 'package:mobile_assessment/modules/home/services/employee_database.dart';

class HomeDataService {
  final DatabaseHelper? dbHelper;

  HomeDataService({this.dbHelper});

  Future<List<Employee>> fetchEmployees() async {
    final response = Api.successResponse;

    if (response['statusCode'] == 200) {
      final employeesData = response['data'] as List<dynamic>;
      final employees = employeesData.map((e) => Employee.fromJson(e)).toList();
      await dbHelper?.saveEmployees(employees);
      return employees;
    } else {
      throw Exception(response['message']);
    }
  }


  Future<void> simulateError() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception(Api.errorRexponse);
  }

}