// ignore: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import 'package:mobile_assessment/modules/home/routes/route.dart';
import 'package:mobile_assessment/modules/home/widgets/presentation/home.dart';
import 'package:mobile_assessment/shared/navigation/animations/slide_up.dart';


var routes = (RouteSettings settings) {
  switch (settings.name) {
    case HomeRoutes.homeRoot:
      return SlideUpRoute(
        page: const HomeScreen(),
      );
  }

  return null;
};
