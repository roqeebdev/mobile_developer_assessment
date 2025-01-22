import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_assessment/modules/home/models/employee.model.dart';
import 'package:mobile_assessment/modules/home/widgets/presentation/employee_details.dart';
import 'package:mobile_assessment/shared/utils/colors.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeDetails(details: employee),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.r),
          border: Border(
            bottom: BorderSide(
              color: AppColors.lightGreyColor,
              width: 1.w,
            ),
          ),
        ),
        padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.lightGreyColor,
              radius: 20.r,
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  color: AppColors.blackTextColor,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${employee.firstName} ${employee.lastName}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Designation: ${employee.designation}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Level: ${employee.level.toString()}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Platform.isIOS
                  ? CupertinoIcons.chevron_forward
                  : Icons.chevron_right_rounded,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
