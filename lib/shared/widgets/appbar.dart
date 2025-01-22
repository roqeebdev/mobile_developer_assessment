import 'package:flutter/material.dart';
import 'package:mobile_assessment/shared/utils/colors.dart';
import 'package:mobile_assessment/shared/widgets/appbar_wrapper.dart';


class AssessmentScaffold extends StatelessWidget {
  final Widget? body;
  final Drawer? drawer;
  final String? appBarTitle;
  final List<Tab>? appBarTabs;
  final GlobalKey? scaffoldKey;
  final FloatingActionButton? fab;
  final TabController? appBarTabController;
  final BottomNavigationBar? bottomNavigationBar;
  final Widget? leading;
  final List<Widget>? action;
  final bool automaticallyImplyLeading;

  const AssessmentScaffold({super.key, required this.appBarTitle, this.appBarTabs, this.appBarTabController, this.leading,this.action,
    this.fab, this.bottomNavigationBar, this.body,  this.drawer, this.scaffoldKey,required this.automaticallyImplyLeading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
     // backgroundColor: Colors.blue[50],
      appBar: AppBarWrapper(
        tabs: appBarTabs,
        context: context,
        title: appBarTitle!,
        tabController: appBarTabController,
        leading: leading,
        action: action,
        automaticallyImplyLeading: automaticallyImplyLeading,
      ).renderAppBar(),
      body: body,
      drawer: drawer,
      floatingActionButton: fab,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
