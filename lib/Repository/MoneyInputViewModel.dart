import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:provider/provider.dart';

class MoneyInputViewModel extends ChangeNotifier{
  double cash = 0.0;
  double eMoney = 0.0;
  late BalanceDao  balanceDao;
  late OpeningClosingDao openingClosingDao;
  late BalanceInputRecordsDao balanceInputRecordsDao;
  late BuildContext context;
  late String agent;
  void getBalanceByAgentId(String agent,BuildContext context) async {
    this.context = context;
    this.agent = agent;
    balanceDao = Provider.of<BalanceDao>(context,listen: false);

    BalanceData result =await balanceDao.getBalanceViaAgentId(agent);
    if(result != null){
      this.cash = result.cash;
      this.eMoney = result.eMoney;
    }
    notifyListeners();
  }

  Future<bool> updateBalance(BalanceData balanceData) async{
    var result = await balanceDao.updateBalance(balanceData);
    getBalanceByAgentId(balanceData.agent, context);
    return result;
  }

  Future<bool> insertBalance(BalanceData balanceData) async{
    var result = await balanceDao.insertBalance(balanceData);
    getBalanceByAgentId(balanceData.agent, context);
    return result > 0;
  }

  Future<bool> insertOpenClosingBalance(BuildContext context,OpeningClosingData openingClosingData) async{
    openingClosingDao = Provider.of<OpeningClosingDao>(context,listen: false);
    var result = await openingClosingDao.insertOpeningClosing(openingClosingData);
    return result > 0;
  }

  Future<List<BalanceData>> getBalanceByDate(BuildContext context, String currentDate) {
    this.context = context;
    balanceDao = Provider.of<BalanceDao>(context,listen: false);
    var result = balanceDao.getAllBalanceWithDate(currentDate);
    return result;
  }

  Future<List<OpeningClosingData>> getAllOpeningBalanceByDate(BuildContext context, String currentDate) async{
    openingClosingDao = Provider.of<OpeningClosingDao>(context,listen: false);
    var result = await openingClosingDao.getAllOpeningClosingViaDate(currentDate);
    return result;
  }

  Future<bool> updateOpenClosingBalance(OpeningClosingData openingClosingData) async{
    openingClosingDao = Provider.of<OpeningClosingDao>(context,listen: false);
    var result = await openingClosingDao.updateOpeningClosing(openingClosingData);
    return result;
  }

  Future<OpeningClosingData> getOpeningClosingByAgentAndDate(String agent, String date) async{
    openingClosingDao = Provider.of<OpeningClosingDao>(context,listen: false);
    var result = await openingClosingDao.getOpeningClosingByAgentAndDate(agent, date);
    return result;
  }

 Future<bool> insertBalanceRecords(BuildContext context, BalanceInputRecord balanceInputRecord) async{
    balanceInputRecordsDao = Provider.of<BalanceInputRecordsDao>(context,listen: false);
    var result = await balanceInputRecordsDao.insertBalanceInputRecord(balanceInputRecord);
    return result > 0;
  }

}