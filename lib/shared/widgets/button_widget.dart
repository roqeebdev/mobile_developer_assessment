import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_assessment/shared/utils/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String? btnText;
  final bool isLoading;
  final VoidCallback? onClick;
  final double borderRadius;
  final bool showLoadingIndicator;
  final Color? colors;
  final Color? textColor;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final Color? borderColor;

  ButtonWidget({
    Key? key,
    this.btnText,
    this.onClick,
    this.colors,
    this.textColor,
    this.height,
    this.padding,
    this.borderColor,
    this.width,
    this.isLoading = false,
    this.borderRadius = 4,
    this.showLoadingIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.3.h,
          backgroundColor: colors ?? AppColors.inputDropDownborderColor,
          padding: padding,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: borderColor ?? Colors.transparent )
          ),

        ),
        onPressed: onClick,
        child: Center(
          child: Text(
              btnText!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor ?? Colors.white
              )
          ),
        ),
      ),
    );
  }
}
