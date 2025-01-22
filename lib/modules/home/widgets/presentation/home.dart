import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_assessment/configs/app_startup.dart';
import 'package:mobile_assessment/modules/home/cubit/home_cubit.dart';
import 'package:mobile_assessment/modules/home/models/employee.model.dart';
import 'package:mobile_assessment/modules/home/widgets/widget/employee_card.dart';
import 'package:mobile_assessment/modules/home/widgets/widget/filter_chips.dart';
import 'package:mobile_assessment/modules/home/widgets/widget/filter_modal.dart';
import 'package:mobile_assessment/shared/utils/colors.dart';
import 'package:mobile_assessment/shared/widgets/appbar.dart';
import 'package:mobile_assessment/shared/widgets/forms/custom_search_bar.dart';
import 'package:mobile_assessment/modules/home/widgets/widget/error_display_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;
  String searchQuery = '';
  String? selectedDesignation;
  List<Employee>? filteredEmployees;
  List<Employee>? employees;
  final TextEditingController _nameSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>();
    _homeCubit.loadEmployees();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      filteredEmployees = employees?.where((employee) {
        final matchesName = searchQuery.isEmpty ||
            (employee.firstName.toLowerCase())
                .contains(searchQuery.toLowerCase());
        final matchesDesignation = selectedDesignation == null ||
            employee.designation == selectedDesignation;
        return matchesName && matchesDesignation;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      searchQuery = '';
      selectedDesignation = null;
      _nameSearchController.clear();
      filteredEmployees = employees;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AssessmentScaffold(
      appBarTitle: 'XYZ Inc.',
      automaticallyImplyLeading: false,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        child: BlocProvider(
          create: (_) => _homeCubit,
          child: BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ErrorDialogWidget.showErrorDialog(
                    context: context,
                    errorMessage: state.errorMessage,
                    errors: state.errors,
                    onRetry: () async {
                      await _homeCubit.loadEmployees();
                    },
                  );
                });
              }
            },
            child: Column(
              children: [
                _buildSearchAndFilterSection(context),
                SizedBox(height: 10.h),
                FilterChips(
                  searchQuery: searchQuery,
                  selectedDesignation: selectedDesignation,
                  onClearName: () {
                    setState(() {
                      searchQuery = '';
                      _applyFilters();
                    });
                  },
                  onClearDesignation: () {
                    setState(() {
                      selectedDesignation = null;
                      _applyFilters();
                    });
                  },
                ),
                SizedBox(height: 5.h),
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is HomeSuccess) {
                        employees = state.employees;
                        filteredEmployees = employees;
                        if (filteredEmployees!.isEmpty) {
                          return Center(child: Text('No employees found.'));
                        }
                        return ListView.builder(
                          itemCount: filteredEmployees!.length,
                          itemBuilder: (context, index) {
                            return EmployeeCard(
                                employee: filteredEmployees![index]);
                          },
                        );
                      }
                      return Center(child: Text('An error occurred.'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      fab: FloatingActionButton(
        mini: false,
        onPressed: () {
          _homeCubit.triggerError();
        },
        tooltip: 'Simulate Error',
        shape: CircleBorder(),
        backgroundColor: AppColors.blackTextColor,
        child: Icon(
          Icons.error_outline,
          color: AppColors.scaffoldBackgroundColor,
          size: 26.sp,
        ),
      ),
    );
  }


  Widget _buildSearchAndFilterSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomSearchBar(
            onChange: (query) {
              setState(() {
                searchQuery = query;
                _applyFilters();
              });
            },
            hintText: 'Search for an employee ...',
          ),
        ),
        SizedBox(width: 5.w),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.backgroundColor,
              builder: (_) => FilterModal(
                employees: employees,
                selectedDesignation: selectedDesignation,
                onApply: (designation, name) {
                  setState(() {
                    searchQuery = name;
                    selectedDesignation = designation;
                    _applyFilters();
                  });
                },
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.filter_list,
              color: AppColors.blackTextColor,
            ),
          ),
        ),
        if (searchQuery.isNotEmpty || selectedDesignation != null)
          SizedBox(width: 5.w),
        if (searchQuery.isNotEmpty || selectedDesignation != null)
          GestureDetector(
            onTap: _clearFilters,
            child: Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.clear,
                color: AppColors.blackTextColor,
              ),
            ),
          ),
      ],
    );
  }
}
