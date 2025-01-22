import 'package:get_it/get_it.dart';
import 'package:mobile_assessment/modules/home/di.dart';
import '../shared/di.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

class AppStartUp {
  Future<void> setUp() async {
    getIt.allowReassignment = true;
    await registerServices(getIt);
  }

  Future<void> registerServices(ioc) async {
    setupSharedServices(ioc);
    setupHome(ioc);
  }
}
