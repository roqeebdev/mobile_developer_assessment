import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_assessment/shared/utils/colors.dart';
import 'package:mobile_assessment/shared/widgets/button_widget.dart';

class ErrorDialogWidget {
  static void showErrorDialog({
    required BuildContext context,
    required String errorMessage,
    List<dynamic>? errors,
    required VoidCallback onRetry,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          backgroundColor: AppColors.scaffoldBackgroundColor,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 16.h),
                Text(
                  'Error Simulation',
                  style:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8.h),
                if (errors != null) ...[
                  SizedBox(height: 10.h),
                  ...errors.map(
                        (e) => Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: Text(
                        "- ${e['message']}",
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  // Reduced padding
                  child: Text(
                    errorMessage,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.h), // Increased space before the button
                Align(
                  alignment: Alignment.center, // Center the button
                  child: ButtonWidget(
                    onClick: (){
                      onRetry();
                      Navigator.of(context).pop();
                  },
                    colors: AppColors.blackTextColor,
                    textColor: AppColors.scaffoldBackgroundColor,
                    btnText: 'Retry',
                  ),
                )
              ],
            ),
          ),
          title: Text(
            'Error',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

        );
      },
    );
  }
}
