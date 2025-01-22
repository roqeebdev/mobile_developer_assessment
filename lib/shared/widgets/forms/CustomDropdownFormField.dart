import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CustomDropdownFormField<T, K> extends StatelessWidget {
  final K value;
  final List<T> items;
  final String? hint;
  final Key? fieldKey;
  final String? label;
  final IconData? icon;
  final Widget? prefix;
  final bool disabled;
  final Function? onTap;
  final Icon? prefixIcon;
  final double? itemHeight;
  final Function(K?)? onChange;
  final String? Function(K?)? validator;
  final bool hasPlaceholder;
  final String? errorMessage;
  final bool isUpperCaseLabel;
  final Function(T) textExtractor;
  final Function(T) valueExtractor;
  final bool usePlaceholderItemValue;

  const CustomDropdownFormField({
    Key? key,
    required this.value,
    this.label,
    required this.items,
    this.onTap,
    this.fieldKey,
    this.prefix,
    this.validator,
    this.errorMessage,
    this.isUpperCaseLabel = false,
    required this.onChange,
    this.hint,
    this.icon,
    this.disabled = false,
    required this.textExtractor,
    required this.valueExtractor,
    this.itemHeight,
    this.hasPlaceholder = false,
    this.prefixIcon,
    this.usePlaceholderItemValue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // const SizedBox(height: 12.0),
        Text(
          label ?? '', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 5.h),
        DropdownButtonFormField(
          value: value,
          isExpanded: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          items: <DropdownMenuItem<K>>[
            for (var item in (items)) () {
              bool isPlaceholder = hasPlaceholder && items.indexOf(item) == 0;
              return DropdownMenuItem<K>(
                value: isPlaceholder && !usePlaceholderItemValue ? '' : valueExtractor(item),
                child: SizedBox(
                  height: itemHeight,
                  child: Text(
                    textExtractor(item),
                    style: TextStyle(
                        fontSize: 12.sp,
                    ),
                  ),
                ),
              );
            }()
          ],
          onChanged: disabled ? null : onChange,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            prefix: prefix,
            prefixIcon: prefixIcon,
            labelText: null,
            fillColor: Theme.of(context).cardColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ],
    );
  }
}
