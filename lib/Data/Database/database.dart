import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';
class Balance extends Table{
  IntColumn get id => integer().autoIncrement().nullable()();
  RealColumn get cash => real().withDefault(Constant(0.0))();
  RealColumn get eMoney => real().withDefault(Constant(0.0))();
  TextColumn get date => text()();
  TextColumn get agent => text()();
}
class BalanceInputRecords extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();

  TextColumn get agent => text().withLength(max: 50)();

  TextColumn get date => text()();

  RealColumn get eMoney => real()();

  RealColumn get cash => real()();
  TextColumn get inputType => text()();
  TextColumn get reason => text().nullable()();
}
class OpeningClosing extends Table{
  IntColumn get id => integer().autoIncrement().nullable()();
  RealColumn get openingCash => real().withDefault(Constant(0.0))();
  RealColumn get openingEMoney => real().withDefault(Constant(0.0))();
  RealColumn get closingCash => real().nullable().withDefault(Constant(0.0))();
  RealColumn get closingEMoney => real().nullable().withDefault(Constant(0.0))();
  TextColumn get date => text()();
  TextColumn get agent => text()();
}
class User extends Table{
  IntColumn get id => integer().autoIncrement().nullable()();
  TextColumn get userId => text()();
  TextColumn get parentId => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get userType => text()();
  BoolColumn get isActive => boolean()();
  BoolColumn get isDeactivate => boolean()();

}

class Transactions extends Table{
  IntColumn get id => integer().autoIncrement().nullable()();
  TextColumn get fromCustomerName => text()();
  TextColumn get toCustomerName => text()();
  TextColumn get fromPhone => text()();
  TextColumn get toPhone => text()();
  TextColumn get bank => text()();
  TextColumn get partner => text()();
  TextColumn get phone => text()();
  TextColumn get transferrorType => text()();

  TextColumn get agent => text()();
  TextColumn get transactionsType => text()();
  TextColumn get date => text()();
  TextColumn get time => text()();
  RealColumn get amount => real().withDefault(Constant(0.0))();
  RealColumn get commission => real().withDefault(Constant(0.0))();
  RealColumn get charges => real().withDefault(Constant(0.0))();

}
@UseMoor(tables:[Balance,Transactions,BalanceInputRecords,OpeningClosing,User],daos: [BalanceDao,TransactionsDao ,BalanceInputRecordsDao,OpeningClosingDao,UserDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
    path: 'lucky.sqlite',
  ));

  @override
  int get schemaVersion => 2;

}

@UseDao(tables: [User])
class UserDao extends DatabaseAccessor<MyDatabase>  with _$UserDaoMixin{
  UserDao(MyDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<UserData>> get getAllUser => (select(user)).get();
  Stream<List<UserData>> get watchAllModes => select(user).watch();
  Future<UserData>  getUserByUserId(String userId) => (select(user)..where((tbl) => tbl.userId.equals(userId))).getSingle();

  Future insertUser(UserData userData) =>
      into(user).insert(userData);

  Future updateUser(UserData userData) =>
      update(user).replace(userData);

  Future deleteUser(UserData userData) =>
      delete(user).delete(userData);
   deleteUserByParentId (String parentId) =>
      delete(user)..where((tbl) => tbl.parentId.equals(parentId));

}
@UseDao(tables: [OpeningClosing])
class OpeningClosingDao extends DatabaseAccessor<MyDatabase> with _$OpeningClosingDaoMixin{
  OpeningClosingDao(MyDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<OpeningClosingData>> get getAllOpeningClosing => (select(openingClosing)).get();
  Stream<List<OpeningClosingData>> get watchAllModes => select(openingClosing).watch();

  Future<OpeningClosingData> getOpeningClosingViaAgentId(String agent) =>
      (select(openingClosing)..where((tbl) => tbl.agent.equals(agent))).getSingle();

  Future<OpeningClosingData> getOpeningClosingByAgentAndDate(String agent,String date)=>
      (select(openingClosing)..where((tbl) => tbl.agent.equals(agent) & tbl.date.equals(date))).getSingle();

  Future<List<OpeningClosingData>> getAllOpeningClosingViaDate(String date) =>
      (select(openingClosing)..where((tbl) => tbl.date.equals(date))).get();

  Future insertOpeningClosing(OpeningClosingData openingClosingData) =>
      into(openingClosing).insert(openingClosingData);

  Future updateOpeningClosing(OpeningClosingData openingClosingData) =>
      update(openingClosing).replace(openingClosingData);

  Future deleteOpeningClosing(OpeningClosingData openingClosingData) =>
      delete(openingClosing).delete(openingClosingData);
}

@UseDao(tables: [BalanceInputRecords])
class BalanceInputRecordsDao extends DatabaseAccessor<MyDatabase> with _$BalanceInputRecordsDaoMixin{
  BalanceInputRecordsDao(MyDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<BalanceInputRecord>> get getAllBalanceInputRecord => (select(balanceInputRecords)).get();
  Stream<List<BalanceInputRecord>> get watchAllModes => select(balanceInputRecords).watch();

  Future<BalanceInputRecord> getBalanceInputRecordViaAgentId(String agent) =>
      (select(balanceInputRecords)..where((tbl) => tbl.agent.equals(agent))).getSingle();

  // Future<List<Transaction>> getAllTransactionWithType(bool isWithdraw) =>
  //     (select(transactions)..where((tbl) => tbl.isWithdraw.equals(isWithdraw)))
  //         .get();

  Future insertBalanceInputRecord(BalanceInputRecord balanceInputRecord) =>
      into(balanceInputRecords).insert(balanceInputRecord);

  Future updateBalanceInputRecord(BalanceInputRecord balanceInputRecord) =>
      update(balanceInputRecords).replace(balanceInputRecord);

  Future deleteBalanceInputRecord(BalanceInputRecord balanceInputRecord) =>
      delete(balanceInputRecords).delete(balanceInputRecord);

}



@UseDao(tables:[Balance])
class BalanceDao extends DatabaseAccessor<MyDatabase> with _$BalanceDaoMixin{
  BalanceDao(MyDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<BalanceData>> get getAllBalance => (select(balance)).get();
  Stream<List<BalanceData>> get watchAllModes => select(balance).watch();

  Future<BalanceData> getBalanceViaAgentId(String agent) =>
      (select(balance)..where((tbl) => tbl.agent.equals(agent))).getSingle();

  Future<List<BalanceData>> getAllBalanceWithDate(String date) =>
      (select(balance)..where((tbl) => tbl.date.equals(date)))
          .get();

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


  Stream<List<Transaction>> watchAllTransactionWithTransferorType(String type) =>
      (select(transactions)..where((tbl) => tbl.transferrorType.equals(type)))
          .watch();



  Future<Transaction> getTransactionViaAgentId(String agentId) =>
      (select(transactions)..where((tbl) => tbl.agent.equals(agentId))).getSingle();

  Future<List<Transaction>> getAllTransactionViaAgent(String agent) =>
      (select(transactions)..where((tbl) => tbl.agent.equals(agent))).get();

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
