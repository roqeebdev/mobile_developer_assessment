import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomSearchBar extends StatefulWidget {
  final String? hintText;
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
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? onBlur;
  final bool? obscureText;
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

  CustomSearchBar({super.key,    this.label,
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
    this.fillColor = Colors.white,
    this.isDense = false,
    this.counterText,
    this.suffix,
    this.onSubmitted,
    this.suffixIcon,
    this.onSaved,
    this.onEditingComplete,
    this.textInputAction,
    this.fieldKey,
    this.border, this.hintText,
  }) : assert(

  (onBlur != null && focusNode != null) || onBlur == null) {
    if (onBlur != null) focusNode!.addListener(() => onBlur!());
  }

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  var _submitted = false;

  InputBorder outlinedInputBorder =
  OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), );

  Color cursorColor = Colors.black;

  InputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.r),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );

  InputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.r),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // padding: EdgeInsets.only(left: 16.w),
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
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
            style: TextStyle(
              fontSize: 10.sp,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              filled: widget.filled,
              prefix: widget.prefix,
              suffix: widget.suffix,
              isDense: widget.isDense,
              fillColor: widget.fillColor,
              errorStyle: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.error,
              ),
              labelText: null,
              border: outlinedInputBorder,
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              counterText: widget.counterText,
              // hintStyle:  TextStyle(
              //     color: const Color.fromRGBO(0, 0, 0, .3), fontSize: 13.sp),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
      ],
    );
  }
}
