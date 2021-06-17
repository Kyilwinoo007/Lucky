import 'package:flutter/cupertino.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:provider/provider.dart';

class MoneyInputViewModel extends ChangeNotifier{
  double cash = 0.0;
  double eMoney = 0.0;
  late BalanceDao  balanceDao;
  late BuildContext context;
  late int id;
  void getBalanceByAgentId(int id,BuildContext context) async {
    this.context = context;
    this.id = id;
    balanceDao = Provider.of<BalanceDao>(context,listen: false);

    String agentId = id.toString();
    BalanceData result =await balanceDao.getBalanceViaAgentId(agentId);
    if(result != null){
      this.cash = result.cash;
      this.eMoney = result.e_money;
    }
    notifyListeners();
  }

  Future<bool> updateBalance(BalanceData balanceData) async{
    var result = await balanceDao.updateBalance(balanceData);
    getBalanceByAgentId(id, context);
    return result;
  }

  Future<bool> insertBalance(BalanceData balanceData) async{
    var result = await balanceDao.insertBalance(balanceData);  //result code 4 for successful
    getBalanceByAgentId(id, context);
    return result == Constants.InsertSuccessCode;
  }

}