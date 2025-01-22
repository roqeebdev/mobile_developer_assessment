import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_assessment/modules/home/models/employee.model.dart';
import 'package:mobile_assessment/shared/utils/asset_images.dart';
import 'package:mobile_assessment/shared/utils/colors.dart';
import 'package:mobile_assessment/shared/utils/format_utils.dart';
import 'package:mobile_assessment/shared/widgets/appbar.dart';

class EmployeeDetails extends StatefulWidget {
  final Employee details;
  const EmployeeDetails({super.key, required this.details});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  Map<String, dynamic> determineStatus(double productivityScore) {
    final level = widget.details.level;
    if (productivityScore >= 80) {
      return {
        'status': 'Promotion',
        'color': AppColors.successColor,
        'promotedLevel': level < 5 ? level + 1 : level
      };
    } else if (productivityScore >= 50) {
      return {
        'status': 'No Change',
        'color': AppColors.successColor,
        'promotedLevel': level 
      };
    } else if (productivityScore >= 40) {
      return {
        'status': 'Demotion',
        'color': AppColors.errorColor,
        'promotedLevel': level > 0 ? level - 1 : 0 
      };
    } else {
      return {
        'status': level == 0 ? 'Termination' : 'Demotion',
        'color': AppColors.errorColor,
        'promotedLevel': level == 0 ? null : level - 1
      };
    }
  }
  
  String calculateNewSalary(String status) {
    final levelSalaries = {
      0: 70000,
      1: 100000,
      2: 120000,
      3: 180000,
      4: 200000,
      5: 250000,
    };

    int currentLevel = widget.details.level;
    if (status == 'Promotion' && currentLevel < 5) {
      currentLevel++;
    } else if (status == 'Demotion' && currentLevel > 0) {
      currentLevel--;
    } else if (status == 'Termination') {
      return '0';
    }

    return levelSalaries[currentLevel]!.toString();
  }
  
  Widget buildInfoRow(String title, String? value,
      {Color? valueColor, bool isCurrency = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        Text(
          isCurrency
              ? formatAmount(num.parse(value!.replaceAll(',', '')))
              : value!,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: valueColor ?? AppColors.blackTextColor,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusInfo = determineStatus(widget.details.productivityScore);
    final newSalary = calculateNewSalary(statusInfo['status']);
    final promotedLevel = statusInfo['promotedLevel']; // Get the promoted level

    return AssessmentScaffold(
      appBarTitle: 'Employee Details',
      automaticallyImplyLeading: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 44.h, left: 16.w, right: 16.w),
          child: Column(
            children: <Widget>[
              // Employee Avatar and Details
              Center(
                child: CircleAvatar(
                  backgroundColor: AppColors.lightGreyColor,
                  radius: 30.r,
                  child: ClipOval(
                    child: Icon(
                      Icons.person,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "${widget.details.firstName} ${widget.details.lastName}",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 5.h),
              Text(
                'Level ${widget.details.level.toString()}',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildInfoRow(
                    'Employee Status:',
                    statusInfo['status'],
                    valueColor: statusInfo['color'],
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
              Divider(color: AppColors.lightGreyColor, height: 2.h, thickness: 1),
              SizedBox(height: 20.h),
              if (statusInfo['status'] == 'Promotion')
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildInfoRow(
                      'Promoted Level:',
                      'Level $promotedLevel',
                      valueColor: AppColors.successColor,
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
              if (statusInfo['status'] == 'Promotion')
                Divider(color: AppColors.lightGreyColor, height: 2.h, thickness: 1),
              if (statusInfo['status'] == 'Promotion') SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildInfoRow(
                    'Current Salary:',
                    widget.details.currentSalary,
                    isCurrency: true,
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
              Divider(color: AppColors.lightGreyColor, height: 2.h, thickness: 1),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildInfoRow(
                    'New Salary:',
                    newSalary,
                    isCurrency: true,
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
              Divider(color: AppColors.lightGreyColor, height: 2.h, thickness: 1),
              SizedBox(height: 20.h),
              Image.asset(
                AssetResources.PERCENTAGE_ICON,
                height: 100.h,
                width: 100.w,
              ),
              SizedBox(height: 15.h),
              Text(
                'Productivity Score:',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15.h),
              Text(
                '${widget.details.productivityScore.round()} %',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  color: statusInfo['color'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
