import 'package:flutter/cupertino.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:provider/provider.dart';

class TransactionViewModel extends ChangeNotifier{

  late double cash;
  late double eMoney;
  late TransactionsDao transactionsDao;
  late OpeningClosingDao openingClosingDao;
  late BalanceDao balanceDao;
  Stream<List<Transaction>>getTransactionByType(BuildContext context, String type) {
    transactionsDao =  Provider.of<TransactionsDao>(context,listen: false);
    var result = transactionsDao.watchAllTransactionWithType(type);
    return result;
  }

  Stream<List<Transaction>>getBankTransactionByTransferorType(BuildContext context, String type) {
    transactionsDao =  Provider.of<TransactionsDao>(context,listen: false);
    var result = transactionsDao.watchAllTransactionWithTransferorType(type);
    return result;
  }
  Future<BalanceData> getBalanceByAgentName(String agent,BuildContext context) async {
    balanceDao = Provider.of<BalanceDao>(context,listen: false);

    BalanceData result =await balanceDao.getBalanceViaAgentId(agent);
    if(result != null){
      this.cash = result.cash;
      this.eMoney = result.eMoney;
    }
    return result;
  }

  Future<bool> saveTransaction(BuildContext context,Transaction transaction) async{
    transactionsDao = Provider.of<TransactionsDao>(context,listen: false);
    var result = await transactionsDao.insertTransaction(transaction);
    return result > 0;
  }

  void updateBalance(BalanceData balanceData) async{
    var result = await balanceDao.updateBalance(balanceData);

  }

  void insertBalance(BalanceData balanceData) async{
    var result = await balanceDao.insertBalance(balanceData);
  }

  void deleteTransaction(BuildContext context, Transaction transaction) async{
    transactionsDao = Provider.of<TransactionsDao>(context,listen: false);
    var result = await transactionsDao.deleteTransaction(transaction);
  }

  Stream<List<Transaction>> getAllTransaction(BuildContext context) {
    transactionsDao = Provider.of<TransactionsDao>(context,listen: false);
    var result = transactionsDao.watchAllModes;
    return result;
  }

  Stream<List<OpeningClosingData>> getAllOpeningClosing(BuildContext context) {
    openingClosingDao = Provider.of<OpeningClosingDao>(context,listen: false);
     var result = openingClosingDao.watchAllModes;
    return result;
  }

  Future<OpeningClosingData> getOpeningClosingByAgentAndDate(String agent, String date, BuildContext context) {
    openingClosingDao = Provider.of<OpeningClosingDao>(context,listen: false);
    var result = openingClosingDao.getOpeningClosingByAgentAndDate(agent, date);
    return result;
  }

  void updateOpeningClosing(OpeningClosingData openingClosingData) {
    openingClosingDao.updateOpeningClosing(openingClosingData);
  }

  void insertOpeningClosing(OpeningClosingData openingClosingData) {
    openingClosingDao.insertOpeningClosing(openingClosingData);
  }

 Stream<List<BalanceInputRecord>> getAllMoneyInputRecords(BuildContext context) {
    BalanceInputRecordsDao dao = Provider.of<BalanceInputRecordsDao>(context,listen: false);
    return dao.watchAllModes;
  }

  deleteOpeningClosingHistory(BuildContext context, OpeningClosingData openingClosing) async{
    openingClosingDao = Provider.of<OpeningClosingDao>(context,listen: false);
    var result = await openingClosingDao.deleteOpeningClosing(openingClosing);
    return result;
  }



}