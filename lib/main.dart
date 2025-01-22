import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_assessment/root_widget.dart';
import 'configs/app_startup.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft]);
    await AppStartUp().setUp();
    runApp(const MobileAssessmentApp());
  }, (exception, stackTrace) async {});
}

