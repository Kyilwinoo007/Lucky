import 'package:flutter/cupertino.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:provider/provider.dart';

class AgentViewModel extends ChangeNotifier{
  double cash = 0.0;
  double eMoney = 0.0;
  double transfer = 0.0,withdraw = 0.0,charges = 0.0,commission = 0.0, deposite = 0.0;
  late BalanceDao  balanceDao;
  late BuildContext context;
  late String id;
  void getBalanceByAgentId(String agentId,BuildContext context) async {
    this.context = context;
    this.id = agentId;
    balanceDao = Provider.of<BalanceDao>(context,listen: false);

   BalanceData result =await balanceDao.getBalanceViaAgentId(agentId);
    if(result != null){
      this.cash = result.cash;
      this.eMoney = result.eMoney;
    }
    notifyListeners();
  }

 Future<bool> updateBalance(BalanceData balanceData) async{
    var result = await balanceDao.updateBalance(balanceData);
    getBalanceByAgentId(id, context);
    return result;
  }

  Future<bool> insertBalance(BalanceData balanceData) async{
    var result = await balanceDao.insertBalance(balanceData);
    getBalanceByAgentId(id, context);
    return result  > 0;
 }

  void getTransactionByAgent(String name, BuildContext context) async{
    double transfer = 0.0,withdraw = 0.0,charges = 0.0,commission = 0.0 ,deposite = 0.0;
    TransactionsDao transactionsDao = Provider.of<TransactionsDao>(context,listen: false);
    List<Transaction> result = await transactionsDao.getAllTransactionViaAgent(name);
    if(result != null){
      for(int i = 0; i< result.length ; i ++){
        var transaction = result [i];
        charges += transaction.charges;
        commission += transaction.commission;
        if(transaction.transactionsType == Constants.TRANSFER_TYPE || transaction.transactionsType == Constants.BANK_TRANSFER_TYPE
          || transaction.transactionsType == Constants.PARTNER_TRANSFER_TYPE){
          transfer += transaction.amount;
        }else if(transaction.transactionsType == Constants.DEPOSITE_TYPE){
          deposite += transaction.amount;
        }else{
          withdraw += transaction.amount;

        }
      }
      this.transfer = transfer;
      this.withdraw = withdraw;
      this.charges = charges;
      this.commission = commission;
      this.deposite = deposite;
    }
    notifyListeners();
  }
}