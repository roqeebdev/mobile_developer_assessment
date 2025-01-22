import 'package:get_it/get_it.dart';
import './services/api_service.dart';
import 'cubit/home_cubit.dart';


void setupHome(GetIt ioc){
  ioc.registerSingleton<HomeCubit>(HomeCubit(
    dataService: HomeDataService(),
  ));
}