import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_assessment/modules/home/models/employee.model.dart';
import 'package:mobile_assessment/shared/widgets/button_widget.dart';
import 'package:mobile_assessment/shared/widgets/forms/CustomDropdownFormField.dart';
import 'package:mobile_assessment/shared/widgets/forms/custom_form_field.dart';

class FilterModal extends StatefulWidget {
  final List<Employee>? employees;
  final String? selectedDesignation;
  final Function(String? designation, String name) onApply;

  const FilterModal({
    Key? key,
    required this.employees,
    this.selectedDesignation,
    required this.onApply,
  }) : super(key: key);

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late TextEditingController _nameController;
  String? _selectedDesignation;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _selectedDesignation = widget.selectedDesignation;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String?> designations = widget.employees != null
        ? widget.employees!
        .map((employee) => employee.designation)
        .toSet()
        .toList()
        : [];

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Options',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            CustomFormField(
              label: 'Enter employee name',
              hint: 'Enter name...',
              controller: _nameController,
            ),
            SizedBox(height: 15.h),
            CustomDropdownFormField(
              label: 'Designation',
              value: _selectedDesignation,
              hint: 'Select a Designation',
              hasPlaceholder: true,
              items: designations.map((designation) {
                return {
                  'label': designation ?? 'Unknown',
                  'value': designation,
                };
              }).toList(),
              textExtractor: (item) => item['label']!,
              valueExtractor: (item) => item['value'],
              onChange: (value) {
                setState(() {
                  _selectedDesignation = value;
                });
              },
            ),
            SizedBox(height: 20.h),

            ButtonWidget(
              height: 52.h,
              width: 155.w,
              btnText: 'Apply Filter',
              onClick: () {
                widget.onApply(
                  _selectedDesignation,
                  _nameController.text.trim(),
                );
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
