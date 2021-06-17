import 'package:flutter/cupertino.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:provider/provider.dart';

class WithdrawViewModel extends ChangeNotifier{

  late TransactionsDao transactionsDao;
  Stream<List<Transaction>>getTransactionByType(BuildContext context, int type) {
    transactionsDao =  Provider.of<TransactionsDao>(context,listen: false);
    var result = transactionsDao.watchAllTransactionWithType(type.toString());
    return result;
  }


}