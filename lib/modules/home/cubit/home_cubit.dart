import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/io/data.dart';
import 'package:mobile_assessment/configs/app_startup.dart';
import 'package:mobile_assessment/modules/home/models/employee.model.dart';
import '../services/api_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  final HomeDataService dataService;

  HomeCubit({required this.dataService}) : super(HomeInitial());

  Future<void> loadEmployees() async {
    try {
      emit(HomeLoading());
      final employees = await dataService.fetchEmployees();
      getIt.registerSingleton<List<Employee>>(employees);
      emit(HomeSuccess(employees));
    } catch (error) {
      emit(HomeError(errorMessage: "An error occurred"));
    }
  }


  Future<void> triggerError() async {
    emit(HomeLoading());
    try {
      await dataService.simulateError();
    } catch (error) {
      if (error is Exception) {
        final errorResponse = Api.errorRexponse;
        emit(HomeError(
          errorMessage: "Error: ${errorResponse['message']}",
          errors: errorResponse['errors'],
        ));
      } else {
        emit(HomeError(errorMessage: "An unexpected error occurred"));
      }
    }
  }

}