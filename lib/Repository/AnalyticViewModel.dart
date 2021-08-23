import 'package:flutter/cupertino.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:provider/provider.dart';

class AnalyticViewModel extends ChangeNotifier{
  late TransactionsDao transactionsDao;
 Future<List<Transaction>> getAllTransaction(BuildContext context) async{
    transactionsDao = Provider.of<TransactionsDao>(context, listen: false);
    List<Transaction> transactions = await transactionsDao.getAllTransactions;
    return transactions;
  }

  Future<List<Transaction>> getAllTransactionByTransactionType(BuildContext context, String selectedType) async{
   transactionsDao = Provider.of<TransactionsDao>(context,listen: false);
   List<Transaction> transactions = await transactionsDao.getAllTransactionWithType(selectedType);
   return transactions;
  }

}