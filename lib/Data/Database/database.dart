import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';
class Balance extends Table{
  IntColumn get id => integer().autoIncrement()();
  RealColumn get cash => real().withDefault(Constant(0.0))();
  RealColumn get e_money => real().withDefault(Constant(0.0))();
  TextColumn get date => text()();
  TextColumn get agentId => text()();
}
class Transactions extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fromCustomerName => text()();
  TextColumn get toCustomerName => text()();
  TextColumn get fromPhone => text()();
  TextColumn get toPhone => text()();
  TextColumn get agentId => text()();
  TextColumn get transactionsType => text()();
  TextColumn get date => text()();
  RealColumn get amount => real().withDefault(Constant(0.0))();
  RealColumn get commission => real().withDefault(Constant(0.0))();
  RealColumn get charges => real().withDefault(Constant(0.0))();

}
class BankTransactions extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fromBank => text()();
  TextColumn get toBank => text()();
  TextColumn get phone => text()();
  RealColumn get amount => real().withDefault(Constant(0.0))();
  RealColumn get commission => real().withDefault(Constant(0.0))();
  TextColumn get date => text()();
  TextColumn get bankId => text()();
  TextColumn get type => text()();

}

@UseMoor(tables:[Balance,Transactions,BankTransactions],daos: [BalanceDao,TransactionsDao,BankTransactionsDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
  ));

  @override
  int get schemaVersion => 1;

}



@UseDao(tables:[Balance])
class BalanceDao extends DatabaseAccessor<MyDatabase> with _$BalanceDaoMixin{
  BalanceDao(MyDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<BalanceData>> get getAllBalance => (select(balance)).get();
  Stream<List<BalanceData>> get watchAllModes => select(balance).watch();

  Future<BalanceData> getBalanceViaAgentId(String agentId) =>
      (select(balance)..where((tbl) => tbl.agentId.equals(agentId))).getSingle();

  // Future<List<Transaction>> getAllTransactionWithType(bool isWithdraw) =>
  //     (select(transactions)..where((tbl) => tbl.isWithdraw.equals(isWithdraw)))
  //         .get();

  Future insertBalance(BalanceData balanceData) =>
      into(balance).insert(balanceData);

  Future updateBalance(BalanceData balanceData) =>
      update(balance).replace(balanceData);

  Future deleteBalance(BalanceData balanceData) =>
      delete(balance).delete(balanceData);

}
@UseDao(tables:[Transactions])
class TransactionsDao extends DatabaseAccessor<MyDatabase> with _$TransactionsDaoMixin{
  TransactionsDao(MyDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<Transaction>> get getAllTransactions => (select(transactions)).get();
  Stream<List<Transaction>> get watchAllModes => select(transactions).watch();
  Stream<List<Transaction>> watchAllTransactionWithType(String type) =>
      (select(transactions)..where((tbl) => tbl.transactionsType.equals(type)))
          .watch();


  Future<Transaction> getTransactionViaAgentId(String agentId) =>
      (select(transactions)..where((tbl) => tbl.agentId.equals(agentId))).getSingle();

  Future<List<Transaction>> getAllTransactionWithType(String type) =>
      (select(transactions)..where((tbl) => tbl.transactionsType.equals(type)))
          .get();


  Future insertTransaction(Transaction transaction) =>
      into(transactions).insert(transaction);

  Future updateTransaction(Transaction transaction) =>
      update(transactions).replace(transaction);

  Future deleteTransaction(Transaction transaction) =>
      delete(transactions).delete(transaction);

}
@UseDao(tables:[BankTransactions])
class BankTransactionsDao extends DatabaseAccessor<MyDatabase> with _$BankTransactionsDaoMixin{
  BankTransactionsDao(MyDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<BankTransaction>> get getAllBankTransactions => (select(bankTransactions)).get();
  Stream<List<BankTransaction>> get watchAllModes => select(bankTransactions).watch();

  Future<BankTransaction> getBankTransactionViaBankId(String bankId) =>
      (select(bankTransactions)..where((tbl) => tbl.bankId.equals(bankId))).getSingle();

  Future<List<BankTransaction>> getAllBankTransactionWithType(String type) =>
      (select(bankTransactions)..where((tbl) => tbl.type.equals(type)))
          .get();


  Future insertBankTransaction(BankTransaction transaction) =>
      into(bankTransactions).insert(transaction);

  Future updateBankTransaction(BankTransaction transaction) =>
      update(bankTransactions).replace(transaction);

  Future deleteBankTransaction(BankTransaction transaction) =>
      delete(bankTransactions).delete(transaction);

}
