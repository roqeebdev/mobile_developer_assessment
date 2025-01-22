import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_assessment/modules/home/routes/route.dart';
import 'package:mobile_assessment/shared/navigation/navigation_service.dart';
import 'package:mobile_assessment/shared/navigation/routes.dart';
import 'package:mobile_assessment/shared/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';


class MobileAssessmentApp extends StatelessWidget {
  const MobileAssessmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (BuildContext context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assessment',
        theme: ThemeData(
          useMaterial3: false,
          textTheme: GoogleFonts.montserratTextTheme(),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.backgroundColor,
            shadowColor: Colors.black12,
            iconTheme: IconThemeData(color: Colors.grey.shade700),
            titleTextStyle: GoogleFonts.libreBaskerville(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        navigatorKey: GetIt.I<NavigationService>().navigatorKey,
        initialRoute: HomeRoutes.homeRoot,
        onGenerateRoute: routes,
      ),
    );
  }
}
