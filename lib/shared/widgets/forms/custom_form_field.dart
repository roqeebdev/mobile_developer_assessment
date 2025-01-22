import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CustomFormField extends StatefulWidget {
  final String? hint;
  final bool filled;
  final Key? fieldKey;
  final String? label;
  final int minLines;
  final bool isDense;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final bool disabled;
  final Function()? onTap;
  final Color? fillColor;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final Function? onBlur;
  final bool? obscureText;
  //final Function onChange;
  final Function(String)? onChange;
  final InputBorder? border;
  final String? counterText;
  final String? Function(String? input)? validator;
  final FocusNode? focusNode;
  final String? errorMessage;
  final bool isUpperCaseLabel;
  final Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextCapitalization capitalization;
  final Function(String value)? onSubmitted;

  CustomFormField({Key? key,
    this.label,
    this.controller,
    this.readOnly = false,
    this.keyboardType,
    this.minLines = 1,
    this.obscureText = false,
    this.onTap,
    this.prefix,
    this.validator,
    this.errorMessage,
    this.capitalization = TextCapitalization.none,
    this.isUpperCaseLabel = false,
    this.hint,
    this.disabled = false,
    this.focusNode,
    this.onBlur,
    this.onChange,
    this.prefixIcon,
    this.filled = false,
    this.fillColor = const Color.fromRGBO(0, 0, 0, .05),
    this.isDense = false,
    this.counterText,
    this.suffix,
    this.onSubmitted,
    this.suffixIcon,
    this.onSaved,
    this.onEditingComplete,
    this.textInputAction,
    this.fieldKey,
    this.border,
  }) : assert(

  (onBlur != null && focusNode != null) || onBlur == null), super(key: key) {
    if (onBlur != null) focusNode!.addListener(() => onBlur!());
  }

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  var _submitted = false;
  var _isFocused = false;
  InputBorder outlinedInputBorder =
  OutlineInputBorder(borderRadius: BorderRadius.circular(5.r));

  Color cursorColor = Colors.black;

  InputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.r),
    borderSide: BorderSide(color: Colors.black),
  );

  InputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.r),
    borderSide: BorderSide(color: Colors.grey),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 12.h),
        Text(
          widget.label ?? '', style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),),
        SizedBox(height: 5.h),
        Container(
          // height: 50.w,
          // width: 328.w,
          clipBehavior: widget.border == null && widget.filled
              ? Clip.hardEdge
              : Clip.none,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: TextFormField(
            cursorColor: cursorColor,
            onTap: widget.onTap,
            key: widget.fieldKey,
            onSaved: widget.onSaved,
            enabled: !widget.disabled,
            minLines: widget.minLines,
            readOnly: widget.readOnly,
            onChanged: widget.onChange,
            validator: widget.validator,
            focusNode: widget.focusNode,
            controller: widget.controller,
            obscureText: widget.obscureText!,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.capitalization,
            onEditingComplete: widget.onEditingComplete,
            maxLines: widget.minLines > 1 ? widget.minLines + 1 : 1,
            autovalidateMode: _submitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            onFieldSubmitted: (value) {
              (widget.onSubmitted ?? (_) {})(value);
              setState(() => _submitted = true);
            },
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: _isFocused ? '' : widget.hint,
              filled: widget.filled,
              prefix: widget.prefix,
              suffix: widget.suffix,
              isDense: widget.isDense,
              fillColor: widget.fillColor,
              errorStyle: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.error,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: outlinedInputBorder ,
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              counterText: widget.counterText,
              hintStyle: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
                color: Color.fromRGBO(196, 196, 196, 1)
    ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}