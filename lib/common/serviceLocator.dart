import 'package:get_it/get_it.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/AgentViewModel.dart';
import 'package:lucky/Repository/AnalyticViewModel.dart';
import 'package:lucky/Repository/HomeViewModel.dart';
import 'package:lucky/Repository/MoneyInputViewModel.dart';
import 'package:lucky/Repository/TransactionViewModel.dart';
import 'package:lucky/UI/Home/home.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerFactory<AgentViewModel>(() => AgentViewModel());
  serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
  serviceLocator.registerFactory<MoneyInputViewModel>(() => MoneyInputViewModel());
  serviceLocator.registerFactory<TransactionViewModel>(() => TransactionViewModel());
  serviceLocator.registerFactory<AnalyticViewModel>(() => AnalyticViewModel());
}