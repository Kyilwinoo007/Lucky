import 'package:flutter/cupertino.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier{
  double totalCash = 0.0;
  double totalEmoney = 0.0;
  late BalanceDao  balanceDao;
  late BuildContext context;
  void getAllBalance(BuildContext context) async{
    this.context = context;
    double totalCash = 0.0;
    double totalEmoney = 0.0;
    balanceDao = Provider.of<BalanceDao>(context,listen: false);
    List<BalanceData> result = await balanceDao.getAllBalance;
    for(int i = 0 ; i< result.length ; i ++){
      totalCash += result[i].cash;
      totalEmoney += result[i].eMoney;
    }
    this.totalCash = totalCash;
    this.totalEmoney = totalEmoney;
    notifyListeners();
  }
}