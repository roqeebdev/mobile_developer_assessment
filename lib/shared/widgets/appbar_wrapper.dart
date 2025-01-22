import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWrapper {
  final String? title;
  final List<Tab>? tabs;
  final BuildContext? context;
  final TabController? tabController;
  final Widget? leading;
  final List<Widget>? action;
  final bool automaticallyImplyLeading;

  AppBarWrapper({
    this.title, this.tabs, this.tabController, this.context, this.leading, this.action, required  this.automaticallyImplyLeading,
  }) : assert((tabController != null) || (tabs == null && tabController == null));

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: 5.0,
      titleSpacing: 10.w,
      title: Text(title!, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
      leading: leading,
      actions: action,

      bottom: tabController == null ? null : TabBar(
        tabs: tabs!,
        controller: tabController,
      ),
    );
  }
}
