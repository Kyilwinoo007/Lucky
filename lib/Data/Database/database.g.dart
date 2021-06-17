// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class BalanceData extends DataClass implements Insertable<BalanceData> {
  final int? id;
  final double cash;
  final double e_money;
  final String date;
  final String agentId;
  BalanceData(
      {this.id,
      required this.cash,
      required this.e_money,
      required this.date,
      required this.agentId});
  factory BalanceData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    return BalanceData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      cash: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}cash']),
      e_money:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}e_money']),
      date: stringType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      agentId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}agent_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || cash != null) {
      map['cash'] = Variable<double>(cash);
    }
    if (!nullToAbsent || e_money != null) {
      map['e_money'] = Variable<double>(e_money);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || agentId != null) {
      map['agent_id'] = Variable<String>(agentId);
    }
    return map;
  }

  BalanceCompanion toCompanion(bool nullToAbsent) {
    return BalanceCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      cash: cash == null && nullToAbsent ? const Value.absent() : Value(cash),
      e_money: e_money == null && nullToAbsent
          ? const Value.absent()
          : Value(e_money),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      agentId: agentId == null && nullToAbsent
          ? const Value.absent()
          : Value(agentId),
    );
  }

  factory BalanceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BalanceData(
      id: serializer.fromJson<int>(json['id']),
      cash: serializer.fromJson<double>(json['cash']),
      e_money: serializer.fromJson<double>(json['e_money']),
      date: serializer.fromJson<String>(json['date']),
      agentId: serializer.fromJson<String>(json['agentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cash': serializer.toJson<double>(cash),
      'e_money': serializer.toJson<double>(e_money),
      'date': serializer.toJson<String>(date),
      'agentId': serializer.toJson<String>(agentId),
    };
  }

  BalanceData copyWith(
          {int? id,
          double? cash,
          double? e_money,
          String? date,
          String? agentId}) =>
      BalanceData(
        id: id ?? this.id,
        cash: cash ?? this.cash,
        e_money: e_money ?? this.e_money,
        date: date ?? this.date,
        agentId: agentId ?? this.agentId,
      );
  @override
  String toString() {
    return (StringBuffer('BalanceData(')
          ..write('id: $id, ')
          ..write('cash: $cash, ')
          ..write('e_money: $e_money, ')
          ..write('date: $date, ')
          ..write('agentId: $agentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(cash.hashCode,
          $mrjc(e_money.hashCode, $mrjc(date.hashCode, agentId.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BalanceData &&
          other.id == this.id &&
          other.cash == this.cash &&
          other.e_money == this.e_money &&
          other.date == this.date &&
          other.agentId == this.agentId);
}

class BalanceCompanion extends UpdateCompanion<BalanceData> {
  final Value<int> id;
  final Value<double> cash;
  final Value<double> e_money;
  final Value<String> date;
  final Value<String> agentId;
  const BalanceCompanion({
    this.id = const Value.absent(),
    this.cash = const Value.absent(),
    this.e_money = const Value.absent(),
    this.date = const Value.absent(),
    this.agentId = const Value.absent(),
  });
  BalanceCompanion.insert({
    this.id = const Value.absent(),
    this.cash = const Value.absent(),
    this.e_money = const Value.absent(),
    required String date,
    required String agentId,
  })   : date = Value(date),
        agentId = Value(agentId);
  static Insertable<BalanceData> custom({
    Expression<int>? id,
    Expression<double>? cash,
    Expression<double>? e_money,
    Expression<String>? date,
    Expression<String>? agentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cash != null) 'cash': cash,
      if (e_money != null) 'e_money': e_money,
      if (date != null) 'date': date,
      if (agentId != null) 'agent_id': agentId,
    });
  }

  BalanceCompanion copyWith(
      {Value<int>? id,
      Value<double>? cash,
      Value<double>? e_money,
      Value<String>? date,
      Value<String>? agentId}) {
    return BalanceCompanion(
      id: id ?? this.id,
      cash: cash ?? this.cash,
      e_money: e_money ?? this.e_money,
      date: date ?? this.date,
      agentId: agentId ?? this.agentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cash.present) {
      map['cash'] = Variable<double>(cash.value);
    }
    if (e_money.present) {
      map['e_money'] = Variable<double>(e_money.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (agentId.present) {
      map['agent_id'] = Variable<String>(agentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalanceCompanion(')
          ..write('id: $id, ')
          ..write('cash: $cash, ')
          ..write('e_money: $e_money, ')
          ..write('date: $date, ')
          ..write('agentId: $agentId')
          ..write(')'))
        .toString();
  }
}

class $BalanceTable extends Balance with TableInfo<$BalanceTable, BalanceData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BalanceTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _cashMeta = const VerificationMeta('cash');
  @override
  late final GeneratedRealColumn cash = _constructCash();
  GeneratedRealColumn _constructCash() {
    return GeneratedRealColumn('cash', $tableName, false,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _e_moneyMeta = const VerificationMeta('e_money');
  @override
  late final GeneratedRealColumn e_money = _constructEMoney();
  GeneratedRealColumn _constructEMoney() {
    return GeneratedRealColumn('e_money', $tableName, false,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedTextColumn date = _constructDate();
  GeneratedTextColumn _constructDate() {
    return GeneratedTextColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _agentIdMeta = const VerificationMeta('agentId');
  @override
  late final GeneratedTextColumn agentId = _constructAgentId();
  GeneratedTextColumn _constructAgentId() {
    return GeneratedTextColumn(
      'agent_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, cash, e_money, date, agentId];
  @override
  $BalanceTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'balance';
  @override
  final String actualTableName = 'balance';
  @override
  VerificationContext validateIntegrity(Insertable<BalanceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('cash')) {
      context.handle(
          _cashMeta, cash.isAcceptableOrUnknown(data['cash'], _cashMeta));
    }
    if (data.containsKey('e_money')) {
      context.handle(_e_moneyMeta,
          e_money.isAcceptableOrUnknown(data['e_money'], _e_moneyMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('agent_id')) {
      context.handle(_agentIdMeta,
          agentId.isAcceptableOrUnknown(data['agent_id'], _agentIdMeta));
    } else if (isInserting) {
      context.missing(_agentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BalanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BalanceData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BalanceTable createAlias(String alias) {
    return $BalanceTable(_db, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final String fromCustomerName;
  final String toCustomerName;
  final String fromPhone;
  final String toPhone;
  final String agentId;
  final String transactionsType;
  final String date;
  final double amount;
  final double commission;
  final double charges;
  Transaction(
      {required this.id,
      required this.fromCustomerName,
      required this.toCustomerName,
      required this.fromPhone,
      required this.toPhone,
      required this.agentId,
      required this.transactionsType,
      required this.date,
      required this.amount,
      required this.commission,
      required this.charges});
  factory Transaction.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Transaction(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      fromCustomerName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}from_customer_name']),
      toCustomerName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}to_customer_name']),
      fromPhone: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}from_phone']),
      toPhone: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}to_phone']),
      agentId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}agent_id']),
      transactionsType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}transactions_type']),
      date: stringType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      amount:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      commission: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}commission']),
      charges:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}charges']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || fromCustomerName != null) {
      map['from_customer_name'] = Variable<String>(fromCustomerName);
    }
    if (!nullToAbsent || toCustomerName != null) {
      map['to_customer_name'] = Variable<String>(toCustomerName);
    }
    if (!nullToAbsent || fromPhone != null) {
      map['from_phone'] = Variable<String>(fromPhone);
    }
    if (!nullToAbsent || toPhone != null) {
      map['to_phone'] = Variable<String>(toPhone);
    }
    if (!nullToAbsent || agentId != null) {
      map['agent_id'] = Variable<String>(agentId);
    }
    if (!nullToAbsent || transactionsType != null) {
      map['transactions_type'] = Variable<String>(transactionsType);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || commission != null) {
      map['commission'] = Variable<double>(commission);
    }
    if (!nullToAbsent || charges != null) {
      map['charges'] = Variable<double>(charges);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      fromCustomerName: fromCustomerName == null && nullToAbsent
          ? const Value.absent()
          : Value(fromCustomerName),
      toCustomerName: toCustomerName == null && nullToAbsent
          ? const Value.absent()
          : Value(toCustomerName),
      fromPhone: fromPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(fromPhone),
      toPhone: toPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(toPhone),
      agentId: agentId == null && nullToAbsent
          ? const Value.absent()
          : Value(agentId),
      transactionsType: transactionsType == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionsType),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      commission: commission == null && nullToAbsent
          ? const Value.absent()
          : Value(commission),
      charges: charges == null && nullToAbsent
          ? const Value.absent()
          : Value(charges),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      fromCustomerName: serializer.fromJson<String>(json['fromCustomerName']),
      toCustomerName: serializer.fromJson<String>(json['toCustomerName']),
      fromPhone: serializer.fromJson<String>(json['fromPhone']),
      toPhone: serializer.fromJson<String>(json['toPhone']),
      agentId: serializer.fromJson<String>(json['agentId']),
      transactionsType: serializer.fromJson<String>(json['transactionsType']),
      date: serializer.fromJson<String>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      commission: serializer.fromJson<double>(json['commission']),
      charges: serializer.fromJson<double>(json['charges']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromCustomerName': serializer.toJson<String>(fromCustomerName),
      'toCustomerName': serializer.toJson<String>(toCustomerName),
      'fromPhone': serializer.toJson<String>(fromPhone),
      'toPhone': serializer.toJson<String>(toPhone),
      'agentId': serializer.toJson<String>(agentId),
      'transactionsType': serializer.toJson<String>(transactionsType),
      'date': serializer.toJson<String>(date),
      'amount': serializer.toJson<double>(amount),
      'commission': serializer.toJson<double>(commission),
      'charges': serializer.toJson<double>(charges),
    };
  }

  Transaction copyWith(
          {int? id,
          String? fromCustomerName,
          String? toCustomerName,
          String? fromPhone,
          String? toPhone,
          String? agentId,
          String? transactionsType,
          String? date,
          double? amount,
          double? commission,
          double? charges}) =>
      Transaction(
        id: id ?? this.id,
        fromCustomerName: fromCustomerName ?? this.fromCustomerName,
        toCustomerName: toCustomerName ?? this.toCustomerName,
        fromPhone: fromPhone ?? this.fromPhone,
        toPhone: toPhone ?? this.toPhone,
        agentId: agentId ?? this.agentId,
        transactionsType: transactionsType ?? this.transactionsType,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        commission: commission ?? this.commission,
        charges: charges ?? this.charges,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('fromCustomerName: $fromCustomerName, ')
          ..write('toCustomerName: $toCustomerName, ')
          ..write('fromPhone: $fromPhone, ')
          ..write('toPhone: $toPhone, ')
          ..write('agentId: $agentId, ')
          ..write('transactionsType: $transactionsType, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('commission: $commission, ')
          ..write('charges: $charges')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          fromCustomerName.hashCode,
          $mrjc(
              toCustomerName.hashCode,
              $mrjc(
                  fromPhone.hashCode,
                  $mrjc(
                      toPhone.hashCode,
                      $mrjc(
                          agentId.hashCode,
                          $mrjc(
                              transactionsType.hashCode,
                              $mrjc(
                                  date.hashCode,
                                  $mrjc(
                                      amount.hashCode,
                                      $mrjc(commission.hashCode,
                                          charges.hashCode)))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.fromCustomerName == this.fromCustomerName &&
          other.toCustomerName == this.toCustomerName &&
          other.fromPhone == this.fromPhone &&
          other.toPhone == this.toPhone &&
          other.agentId == this.agentId &&
          other.transactionsType == this.transactionsType &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.commission == this.commission &&
          other.charges == this.charges);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<String> fromCustomerName;
  final Value<String> toCustomerName;
  final Value<String> fromPhone;
  final Value<String> toPhone;
  final Value<String> agentId;
  final Value<String> transactionsType;
  final Value<String> date;
  final Value<double> amount;
  final Value<double> commission;
  final Value<double> charges;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.fromCustomerName = const Value.absent(),
    this.toCustomerName = const Value.absent(),
    this.fromPhone = const Value.absent(),
    this.toPhone = const Value.absent(),
    this.agentId = const Value.absent(),
    this.transactionsType = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.commission = const Value.absent(),
    this.charges = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String fromCustomerName,
    required String toCustomerName,
    required String fromPhone,
    required String toPhone,
    required String agentId,
    required String transactionsType,
    required String date,
    this.amount = const Value.absent(),
    this.commission = const Value.absent(),
    this.charges = const Value.absent(),
  })  : fromCustomerName = Value(fromCustomerName),
        toCustomerName = Value(toCustomerName),
        fromPhone = Value(fromPhone),
        toPhone = Value(toPhone),
        agentId = Value(agentId),
        transactionsType = Value(transactionsType),
        date = Value(date);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<String>? fromCustomerName,
    Expression<String>? toCustomerName,
    Expression<String>? fromPhone,
    Expression<String>? toPhone,
    Expression<String>? agentId,
    Expression<String>? transactionsType,
    Expression<String>? date,
    Expression<double>? amount,
    Expression<double>? commission,
    Expression<double>? charges,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromCustomerName != null) 'from_customer_name': fromCustomerName,
      if (toCustomerName != null) 'to_customer_name': toCustomerName,
      if (fromPhone != null) 'from_phone': fromPhone,
      if (toPhone != null) 'to_phone': toPhone,
      if (agentId != null) 'agent_id': agentId,
      if (transactionsType != null) 'transactions_type': transactionsType,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (commission != null) 'commission': commission,
      if (charges != null) 'charges': charges,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? fromCustomerName,
      Value<String>? toCustomerName,
      Value<String>? fromPhone,
      Value<String>? toPhone,
      Value<String>? agentId,
      Value<String>? transactionsType,
      Value<String>? date,
      Value<double>? amount,
      Value<double>? commission,
      Value<double>? charges}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      fromCustomerName: fromCustomerName ?? this.fromCustomerName,
      toCustomerName: toCustomerName ?? this.toCustomerName,
      fromPhone: fromPhone ?? this.fromPhone,
      toPhone: toPhone ?? this.toPhone,
      agentId: agentId ?? this.agentId,
      transactionsType: transactionsType ?? this.transactionsType,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      commission: commission ?? this.commission,
      charges: charges ?? this.charges,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromCustomerName.present) {
      map['from_customer_name'] = Variable<String>(fromCustomerName.value);
    }
    if (toCustomerName.present) {
      map['to_customer_name'] = Variable<String>(toCustomerName.value);
    }
    if (fromPhone.present) {
      map['from_phone'] = Variable<String>(fromPhone.value);
    }
    if (toPhone.present) {
      map['to_phone'] = Variable<String>(toPhone.value);
    }
    if (agentId.present) {
      map['agent_id'] = Variable<String>(agentId.value);
    }
    if (transactionsType.present) {
      map['transactions_type'] = Variable<String>(transactionsType.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (commission.present) {
      map['commission'] = Variable<double>(commission.value);
    }
    if (charges.present) {
      map['charges'] = Variable<double>(charges.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('fromCustomerName: $fromCustomerName, ')
          ..write('toCustomerName: $toCustomerName, ')
          ..write('fromPhone: $fromPhone, ')
          ..write('toPhone: $toPhone, ')
          ..write('agentId: $agentId, ')
          ..write('transactionsType: $transactionsType, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('commission: $commission, ')
          ..write('charges: $charges')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TransactionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _fromCustomerNameMeta =
      const VerificationMeta('fromCustomerName');
  @override
  late final GeneratedTextColumn fromCustomerName =
      _constructFromCustomerName();
  GeneratedTextColumn _constructFromCustomerName() {
    return GeneratedTextColumn(
      'from_customer_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _toCustomerNameMeta =
      const VerificationMeta('toCustomerName');
  @override
  late final GeneratedTextColumn toCustomerName = _constructToCustomerName();
  GeneratedTextColumn _constructToCustomerName() {
    return GeneratedTextColumn(
      'to_customer_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fromPhoneMeta = const VerificationMeta('fromPhone');
  @override
  late final GeneratedTextColumn fromPhone = _constructFromPhone();
  GeneratedTextColumn _constructFromPhone() {
    return GeneratedTextColumn(
      'from_phone',
      $tableName,
      false,
    );
  }

  final VerificationMeta _toPhoneMeta = const VerificationMeta('toPhone');
  @override
  late final GeneratedTextColumn toPhone = _constructToPhone();
  GeneratedTextColumn _constructToPhone() {
    return GeneratedTextColumn(
      'to_phone',
      $tableName,
      false,
    );
  }

  final VerificationMeta _agentIdMeta = const VerificationMeta('agentId');
  @override
  late final GeneratedTextColumn agentId = _constructAgentId();
  GeneratedTextColumn _constructAgentId() {
    return GeneratedTextColumn(
      'agent_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _transactionsTypeMeta =
      const VerificationMeta('transactionsType');
  @override
  late final GeneratedTextColumn transactionsType =
      _constructTransactionsType();
  GeneratedTextColumn _constructTransactionsType() {
    return GeneratedTextColumn(
      'transactions_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedTextColumn date = _constructDate();
  GeneratedTextColumn _constructDate() {
    return GeneratedTextColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedRealColumn amount = _constructAmount();
  GeneratedRealColumn _constructAmount() {
    return GeneratedRealColumn('amount', $tableName, false,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _commissionMeta = const VerificationMeta('commission');
  @override
  late final GeneratedRealColumn commission = _constructCommission();
  GeneratedRealColumn _constructCommission() {
    return GeneratedRealColumn('commission', $tableName, false,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _chargesMeta = const VerificationMeta('charges');
  @override
  late final GeneratedRealColumn charges = _constructCharges();
  GeneratedRealColumn _constructCharges() {
    return GeneratedRealColumn('charges', $tableName, false,
        defaultValue: Constant(0.0));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        fromCustomerName,
        toCustomerName,
        fromPhone,
        toPhone,
        agentId,
        transactionsType,
        date,
        amount,
        commission,
        charges
      ];
  @override
  $TransactionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'transactions';
  @override
  final String actualTableName = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('from_customer_name')) {
      context.handle(
          _fromCustomerNameMeta,
          fromCustomerName.isAcceptableOrUnknown(
              data['from_customer_name'], _fromCustomerNameMeta));
    } else if (isInserting) {
      context.missing(_fromCustomerNameMeta);
    }
    if (data.containsKey('to_customer_name')) {
      context.handle(
          _toCustomerNameMeta,
          toCustomerName.isAcceptableOrUnknown(
              data['to_customer_name'], _toCustomerNameMeta));
    } else if (isInserting) {
      context.missing(_toCustomerNameMeta);
    }
    if (data.containsKey('from_phone')) {
      context.handle(_fromPhoneMeta,
          fromPhone.isAcceptableOrUnknown(data['from_phone'], _fromPhoneMeta));
    } else if (isInserting) {
      context.missing(_fromPhoneMeta);
    }
    if (data.containsKey('to_phone')) {
      context.handle(_toPhoneMeta,
          toPhone.isAcceptableOrUnknown(data['to_phone'], _toPhoneMeta));
    } else if (isInserting) {
      context.missing(_toPhoneMeta);
    }
    if (data.containsKey('agent_id')) {
      context.handle(_agentIdMeta,
          agentId.isAcceptableOrUnknown(data['agent_id'], _agentIdMeta));
    } else if (isInserting) {
      context.missing(_agentIdMeta);
    }
    if (data.containsKey('transactions_type')) {
      context.handle(
          _transactionsTypeMeta,
          transactionsType.isAcceptableOrUnknown(
              data['transactions_type'], _transactionsTypeMeta));
    } else if (isInserting) {
      context.missing(_transactionsTypeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount'], _amountMeta));
    }
    if (data.containsKey('commission')) {
      context.handle(
          _commissionMeta,
          commission.isAcceptableOrUnknown(
              data['commission'], _commissionMeta));
    }
    if (data.containsKey('charges')) {
      context.handle(_chargesMeta,
          charges.isAcceptableOrUnknown(data['charges'], _chargesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Transaction.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(_db, alias);
  }
}

class BankTransaction extends DataClass implements Insertable<BankTransaction> {
  final int id;
  final String fromBank;
  final String toBank;
  final String phone;
  final double amount;
  final double commission;
  final String date;
  final String bankId;
  final String type;
  BankTransaction(
      {required this.id,
      required this.fromBank,
      required this.toBank,
      required this.phone,
      required this.amount,
      required this.commission,
      required this.date,
      required this.bankId,
      required this.type});
  factory BankTransaction.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return BankTransaction(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      fromBank: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}from_bank']),
      toBank:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}to_bank']),
      phone:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}phone']),
      amount:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      commission: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}commission']),
      date: stringType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      bankId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}bank_id']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || fromBank != null) {
      map['from_bank'] = Variable<String>(fromBank);
    }
    if (!nullToAbsent || toBank != null) {
      map['to_bank'] = Variable<String>(toBank);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || commission != null) {
      map['commission'] = Variable<double>(commission);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || bankId != null) {
      map['bank_id'] = Variable<String>(bankId);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    return map;
  }

  BankTransactionsCompanion toCompanion(bool nullToAbsent) {
    return BankTransactionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      fromBank: fromBank == null && nullToAbsent
          ? const Value.absent()
          : Value(fromBank),
      toBank:
          toBank == null && nullToAbsent ? const Value.absent() : Value(toBank),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      commission: commission == null && nullToAbsent
          ? const Value.absent()
          : Value(commission),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      bankId:
          bankId == null && nullToAbsent ? const Value.absent() : Value(bankId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory BankTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BankTransaction(
      id: serializer.fromJson<int>(json['id']),
      fromBank: serializer.fromJson<String>(json['fromBank']),
      toBank: serializer.fromJson<String>(json['toBank']),
      phone: serializer.fromJson<String>(json['phone']),
      amount: serializer.fromJson<double>(json['amount']),
      commission: serializer.fromJson<double>(json['commission']),
      date: serializer.fromJson<String>(json['date']),
      bankId: serializer.fromJson<String>(json['bankId']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromBank': serializer.toJson<String>(fromBank),
      'toBank': serializer.toJson<String>(toBank),
      'phone': serializer.toJson<String>(phone),
      'amount': serializer.toJson<double>(amount),
      'commission': serializer.toJson<double>(commission),
      'date': serializer.toJson<String>(date),
      'bankId': serializer.toJson<String>(bankId),
      'type': serializer.toJson<String>(type),
    };
  }

  BankTransaction copyWith(
          {int? id,
          String? fromBank,
          String? toBank,
          String? phone,
          double? amount,
          double? commission,
          String? date,
          String? bankId,
          String? type}) =>
      BankTransaction(
        id: id ?? this.id,
        fromBank: fromBank ?? this.fromBank,
        toBank: toBank ?? this.toBank,
        phone: phone ?? this.phone,
        amount: amount ?? this.amount,
        commission: commission ?? this.commission,
        date: date ?? this.date,
        bankId: bankId ?? this.bankId,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('BankTransaction(')
          ..write('id: $id, ')
          ..write('fromBank: $fromBank, ')
          ..write('toBank: $toBank, ')
          ..write('phone: $phone, ')
          ..write('amount: $amount, ')
          ..write('commission: $commission, ')
          ..write('date: $date, ')
          ..write('bankId: $bankId, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          fromBank.hashCode,
          $mrjc(
              toBank.hashCode,
              $mrjc(
                  phone.hashCode,
                  $mrjc(
                      amount.hashCode,
                      $mrjc(
                          commission.hashCode,
                          $mrjc(date.hashCode,
                              $mrjc(bankId.hashCode, type.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BankTransaction &&
          other.id == this.id &&
          other.fromBank == this.fromBank &&
          other.toBank == this.toBank &&
          other.phone == this.phone &&
          other.amount == this.amount &&
          other.commission == this.commission &&
          other.date == this.date &&
          other.bankId == this.bankId &&
          other.type == this.type);
}

class BankTransactionsCompanion extends UpdateCompanion<BankTransaction> {
  final Value<int> id;
  final Value<String> fromBank;
  final Value<String> toBank;
  final Value<String> phone;
  final Value<double> amount;
  final Value<double> commission;
  final Value<String> date;
  final Value<String> bankId;
  final Value<String> type;
  const BankTransactionsCompanion({
    this.id = const Value.absent(),
    this.fromBank = const Value.absent(),
    this.toBank = const Value.absent(),
    this.phone = const Value.absent(),
    this.amount = const Value.absent(),
    this.commission = const Value.absent(),
    this.date = const Value.absent(),
    this.bankId = const Value.absent(),
    this.type = const Value.absent(),
  });
  BankTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String fromBank,
    required String toBank,
    required String phone,
    this.amount = const Value.absent(),
    this.commission = const Value.absent(),
    required String date,
    required String bankId,
    required String type,
  })   : fromBank = Value(fromBank),
        toBank = Value(toBank),
        phone = Value(phone),
        date = Value(date),
        bankId = Value(bankId),
        type = Value(type);
  static Insertable<BankTransaction> custom({
    Expression<int>? id,
    Expression<String>? fromBank,
    Expression<String>? toBank,
    Expression<String>? phone,
    Expression<double>? amount,
    Expression<double>? commission,
    Expression<String>? date,
    Expression<String>? bankId,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromBank != null) 'from_bank': fromBank,
      if (toBank != null) 'to_bank': toBank,
      if (phone != null) 'phone': phone,
      if (amount != null) 'amount': amount,
      if (commission != null) 'commission': commission,
      if (date != null) 'date': date,
      if (bankId != null) 'bank_id': bankId,
      if (type != null) 'type': type,
    });
  }

  BankTransactionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? fromBank,
      Value<String>? toBank,
      Value<String>? phone,
      Value<double>? amount,
      Value<double>? commission,
      Value<String>? date,
      Value<String>? bankId,
      Value<String>? type}) {
    return BankTransactionsCompanion(
      id: id ?? this.id,
      fromBank: fromBank ?? this.fromBank,
      toBank: toBank ?? this.toBank,
      phone: phone ?? this.phone,
      amount: amount ?? this.amount,
      commission: commission ?? this.commission,
      date: date ?? this.date,
      bankId: bankId ?? this.bankId,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromBank.present) {
      map['from_bank'] = Variable<String>(fromBank.value);
    }
    if (toBank.present) {
      map['to_bank'] = Variable<String>(toBank.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (commission.present) {
      map['commission'] = Variable<double>(commission.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (bankId.present) {
      map['bank_id'] = Variable<String>(bankId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('fromBank: $fromBank, ')
          ..write('toBank: $toBank, ')
          ..write('phone: $phone, ')
          ..write('amount: $amount, ')
          ..write('commission: $commission, ')
          ..write('date: $date, ')
          ..write('bankId: $bankId, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $BankTransactionsTable extends BankTransactions
    with TableInfo<$BankTransactionsTable, BankTransaction> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BankTransactionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _fromBankMeta = const VerificationMeta('fromBank');
  @override
  late final GeneratedTextColumn fromBank = _constructFromBank();
  GeneratedTextColumn _constructFromBank() {
    return GeneratedTextColumn(
      'from_bank',
      $tableName,
      false,
    );
  }

  final VerificationMeta _toBankMeta = const VerificationMeta('toBank');
  @override
  late final GeneratedTextColumn toBank = _constructToBank();
  GeneratedTextColumn _constructToBank() {
    return GeneratedTextColumn(
      'to_bank',
      $tableName,
      false,
    );
  }

  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedTextColumn phone = _constructPhone();
  GeneratedTextColumn _constructPhone() {
    return GeneratedTextColumn(
      'phone',
      $tableName,
      false,
    );
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedRealColumn amount = _constructAmount();
  GeneratedRealColumn _constructAmount() {
    return GeneratedRealColumn('amount', $tableName, false,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _commissionMeta = const VerificationMeta('commission');
  @override
  late final GeneratedRealColumn commission = _constructCommission();
  GeneratedRealColumn _constructCommission() {
    return GeneratedRealColumn('commission', $tableName, false,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedTextColumn date = _constructDate();
  GeneratedTextColumn _constructDate() {
    return GeneratedTextColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bankIdMeta = const VerificationMeta('bankId');
  @override
  late final GeneratedTextColumn bankId = _constructBankId();
  GeneratedTextColumn _constructBankId() {
    return GeneratedTextColumn(
      'bank_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedTextColumn type = _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, fromBank, toBank, phone, amount, commission, date, bankId, type];
  @override
  $BankTransactionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'bank_transactions';
  @override
  final String actualTableName = 'bank_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<BankTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('from_bank')) {
      context.handle(_fromBankMeta,
          fromBank.isAcceptableOrUnknown(data['from_bank'], _fromBankMeta));
    } else if (isInserting) {
      context.missing(_fromBankMeta);
    }
    if (data.containsKey('to_bank')) {
      context.handle(_toBankMeta,
          toBank.isAcceptableOrUnknown(data['to_bank'], _toBankMeta));
    } else if (isInserting) {
      context.missing(_toBankMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone'], _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount'], _amountMeta));
    }
    if (data.containsKey('commission')) {
      context.handle(
          _commissionMeta,
          commission.isAcceptableOrUnknown(
              data['commission'], _commissionMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('bank_id')) {
      context.handle(_bankIdMeta,
          bankId.isAcceptableOrUnknown(data['bank_id'], _bankIdMeta));
    } else if (isInserting) {
      context.missing(_bankIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BankTransaction.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BankTransactionsTable createAlias(String alias) {
    return $BankTransactionsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $BalanceTable balance = $BalanceTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $BankTransactionsTable bankTransactions =
      $BankTransactionsTable(this);
  late final BalanceDao balanceDao = BalanceDao(this as MyDatabase);
  late final TransactionsDao transactionsDao =
      TransactionsDao(this as MyDatabase);
  late final BankTransactionsDao bankTransactionsDao =
      BankTransactionsDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [balance, transactions, bankTransactions];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$BalanceDaoMixin on DatabaseAccessor<MyDatabase> {
  $BalanceTable get balance => attachedDatabase.balance;
}
mixin _$TransactionsDaoMixin on DatabaseAccessor<MyDatabase> {
  $TransactionsTable get transactions => attachedDatabase.transactions;
}
mixin _$BankTransactionsDaoMixin on DatabaseAccessor<MyDatabase> {
  $BankTransactionsTable get bankTransactions =>
      attachedDatabase.bankTransactions;
}
