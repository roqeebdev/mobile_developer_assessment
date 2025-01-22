part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}


class HomeLoading extends HomeState {
  List<Object?> get props => [];
}

class HomeSuccess extends HomeState {
  final List<Employee> employees;

  HomeSuccess(this.employees);

  List<Object?> get props => [employees];
}

class HomeError extends HomeState {
  final String errorMessage;
  final List<dynamic>? errors;

  HomeError({required this.errorMessage, this.errors});
}
