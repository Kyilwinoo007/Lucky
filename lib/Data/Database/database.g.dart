// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class BalanceData extends DataClass implements Insertable<BalanceData> {
  final int? id;
  final double cash;
  final double eMoney;
  final String date;
  final String agent;
  BalanceData(
      {this.id,
      required this.cash,
      required this.eMoney,
      required this.date,
      required this.agent});
  factory BalanceData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    return BalanceData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      cash: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}cash']),
      eMoney:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}e_money']),
      date: stringType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      agent:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}agent']),
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
    if (!nullToAbsent || eMoney != null) {
      map['e_money'] = Variable<double>(eMoney);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || agent != null) {
      map['agent'] = Variable<String>(agent);
    }
    return map;
  }

  BalanceCompanion toCompanion(bool nullToAbsent) {
    return BalanceCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      cash: cash == null && nullToAbsent ? const Value.absent() : Value(cash),
      eMoney:
          eMoney == null && nullToAbsent ? const Value.absent() : Value(eMoney),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      agent:
          agent == null && nullToAbsent ? const Value.absent() : Value(agent),
    );
  }

  factory BalanceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BalanceData(
      id: serializer.fromJson<int?>(json['id']),
      cash: serializer.fromJson<double>(json['cash']),
      eMoney: serializer.fromJson<double>(json['eMoney']),
      date: serializer.fromJson<String>(json['date']),
      agent: serializer.fromJson<String>(json['agent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'cash': serializer.toJson<double>(cash),
      'eMoney': serializer.toJson<double>(eMoney),
      'date': serializer.toJson<String>(date),
      'agent': serializer.toJson<String>(agent),
    };
  }

  BalanceData copyWith(
          {int? id,
          double? cash,
          double? eMoney,
          String? date,
          String? agent}) =>
      BalanceData(
        id: id ?? this.id,
        cash: cash ?? this.cash,
        eMoney: eMoney ?? this.eMoney,
        date: date ?? this.date,
        agent: agent ?? this.agent,
      );
  @override
  String toString() {
    return (StringBuffer('BalanceData(')
          ..write('id: $id, ')
          ..write('cash: $cash, ')
          ..write('eMoney: $eMoney, ')
          ..write('date: $date, ')
          ..write('agent: $agent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(cash.hashCode,
          $mrjc(eMoney.hashCode, $mrjc(date.hashCode, agent.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BalanceData &&
          other.id == this.id &&
          other.cash == this.cash &&
          other.eMoney == this.eMoney &&
          other.date == this.date &&
          other.agent == this.agent);
}

class BalanceCompanion extends UpdateCompanion<BalanceData> {
  final Value<int?> id;
  final Value<double> cash;
  final Value<double> eMoney;
  final Value<String> date;
  final Value<String> agent;
  const BalanceCompanion({
    this.id = const Value.absent(),
    this.cash = const Value.absent(),
    this.eMoney = const Value.absent(),
    this.date = const Value.absent(),
    this.agent = const Value.absent(),
  });
  BalanceCompanion.insert({
    this.id = const Value.absent(),
    this.cash = const Value.absent(),
    this.eMoney = const Value.absent(),
    required String date,
    required String agent,
  })   : date = Value(date),
        agent = Value(agent);
  static Insertable<BalanceData> custom({
    Expression<int>? id,
    Expression<double>? cash,
    Expression<double>? eMoney,
    Expression<String>? date,
    Expression<String>? agent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cash != null) 'cash': cash,
      if (eMoney != null) 'e_money': eMoney,
      if (date != null) 'date': date,
      if (agent != null) 'agent': agent,
    });
  }

  BalanceCompanion copyWith(
      {Value<int?>? id,
      Value<double>? cash,
      Value<double>? eMoney,
      Value<String>? date,
      Value<String>? agent}) {
    return BalanceCompanion(
      id: id ?? this.id,
      cash: cash ?? this.cash,
      eMoney: eMoney ?? this.eMoney,
      date: date ?? this.date,
      agent: agent ?? this.agent,
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
    if (eMoney.present) {
      map['e_money'] = Variable<double>(eMoney.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (agent.present) {
      map['agent'] = Variable<String>(agent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalanceCompanion(')
          ..write('id: $id, ')
          ..write('cash: $cash, ')
          ..write('eMoney: $eMoney, ')
          ..write('date: $date, ')
          ..write('agent: $agent')
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
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _cashMeta = const VerificationMeta('cash');
  @override
  late final GeneratedRealColumn cash = _constructCash();
  GeneratedRealColumn _constructCash() {
    return GeneratedRealColumn('cash', $tableName, false,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _eMoneyMeta = const VerificationMeta('eMoney');
  @override
  late final GeneratedRealColumn eMoney = _constructEMoney();
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

  final VerificationMeta _agentMeta = const VerificationMeta('agent');
  @override
  late final GeneratedTextColumn agent = _constructAgent();
  GeneratedTextColumn _constructAgent() {
    return GeneratedTextColumn(
      'agent',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, cash, eMoney, date, agent];
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
      context.handle(_eMoneyMeta,
          eMoney.isAcceptableOrUnknown(data['e_money'], _eMoneyMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('agent')) {
      context.handle(
          _agentMeta, agent.isAcceptableOrUnknown(data['agent'], _agentMeta));
    } else if (isInserting) {
      context.missing(_agentMeta);
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
  final int? id;
  final String fromCustomerName;
  final String toCustomerName;
  final String fromPhone;
  final String toPhone;
  final String bank;
  final String partner;
  final String phone;
  final String transferrorType;
  final String agent;
  final String transactionsType;
  final String date;
  final String time;
  final double amount;
  final double commission;
  final double charges;
  Transaction(
      {this.id,
      required this.fromCustomerName,
      required this.toCustomerName,
      required this.fromPhone,
      required this.toPhone,
      required this.bank,
      required this.partner,
      required this.phone,
      required this.transferrorType,
      required this.agent,
      required this.transactionsType,
      required this.date,
      required this.time,
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
      bank: stringType.mapFromDatabaseResponse(data['${effectivePrefix}bank']),
      partner:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}partner']),
      phone:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}phone']),
      transferrorType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}transferror_type']),
      agent:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}agent']),
      transactionsType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}transactions_type']),
      date: stringType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      time: stringType.mapFromDatabaseResponse(data['${effectivePrefix}time']),
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
    if (!nullToAbsent || bank != null) {
      map['bank'] = Variable<String>(bank);
    }
    if (!nullToAbsent || partner != null) {
      map['partner'] = Variable<String>(partner);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || transferrorType != null) {
      map['transferror_type'] = Variable<String>(transferrorType);
    }
    if (!nullToAbsent || agent != null) {
      map['agent'] = Variable<String>(agent);
    }
    if (!nullToAbsent || transactionsType != null) {
      map['transactions_type'] = Variable<String>(transactionsType);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<String>(time);
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
      bank: bank == null && nullToAbsent ? const Value.absent() : Value(bank),
      partner: partner == null && nullToAbsent
          ? const Value.absent()
          : Value(partner),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      transferrorType: transferrorType == null && nullToAbsent
          ? const Value.absent()
          : Value(transferrorType),
      agent:
          agent == null && nullToAbsent ? const Value.absent() : Value(agent),
      transactionsType: transactionsType == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionsType),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
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
      id: serializer.fromJson<int?>(json['id']),
      fromCustomerName: serializer.fromJson<String>(json['fromCustomerName']),
      toCustomerName: serializer.fromJson<String>(json['toCustomerName']),
      fromPhone: serializer.fromJson<String>(json['fromPhone']),
      toPhone: serializer.fromJson<String>(json['toPhone']),
      bank: serializer.fromJson<String>(json['bank']),
      partner: serializer.fromJson<String>(json['partner']),
      phone: serializer.fromJson<String>(json['phone']),
      transferrorType: serializer.fromJson<String>(json['transferrorType']),
      agent: serializer.fromJson<String>(json['agent']),
      transactionsType: serializer.fromJson<String>(json['transactionsType']),
      date: serializer.fromJson<String>(json['date']),
      time: serializer.fromJson<String>(json['time']),
      amount: serializer.fromJson<double>(json['amount']),
      commission: serializer.fromJson<double>(json['commission']),
      charges: serializer.fromJson<double>(json['charges']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'fromCustomerName': serializer.toJson<String>(fromCustomerName),
      'toCustomerName': serializer.toJson<String>(toCustomerName),
      'fromPhone': serializer.toJson<String>(fromPhone),
      'toPhone': serializer.toJson<String>(toPhone),
      'bank': serializer.toJson<String>(bank),
      'partner': serializer.toJson<String>(partner),
      'phone': serializer.toJson<String>(phone),
      'transferrorType': serializer.toJson<String>(transferrorType),
      'agent': serializer.toJson<String>(agent),
      'transactionsType': serializer.toJson<String>(transactionsType),
      'date': serializer.toJson<String>(date),
      'time': serializer.toJson<String>(time),
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
          String? bank,
          String? partner,
          String? phone,
          String? transferrorType,
          String? agent,
          String? transactionsType,
          String? date,
          String? time,
          double? amount,
          double? commission,
          double? charges}) =>
      Transaction(
        id: id ?? this.id,
        fromCustomerName: fromCustomerName ?? this.fromCustomerName,
        toCustomerName: toCustomerName ?? this.toCustomerName,
        fromPhone: fromPhone ?? this.fromPhone,
        toPhone: toPhone ?? this.toPhone,
        bank: bank ?? this.bank,
        partner: partner ?? this.partner,
        phone: phone ?? this.phone,
        transferrorType: transferrorType ?? this.transferrorType,
        agent: agent ?? this.agent,
        transactionsType: transactionsType ?? this.transactionsType,
        date: date ?? this.date,
        time: time ?? this.time,
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
          ..write('bank: $bank, ')
          ..write('partner: $partner, ')
          ..write('phone: $phone, ')
          ..write('transferrorType: $transferrorType, ')
          ..write('agent: $agent, ')
          ..write('transactionsType: $transactionsType, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
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
                          bank.hashCode,
                          $mrjc(
                              partner.hashCode,
                              $mrjc(
                                  phone.hashCode,
                                  $mrjc(
                                      transferrorType.hashCode,
                                      $mrjc(
                                          agent.hashCode,
                                          $mrjc(
                                              transactionsType.hashCode,
                                              $mrjc(
                                                  date.hashCode,
                                                  $mrjc(
                                                      time.hashCode,
                                                      $mrjc(
                                                          amount.hashCode,
                                                          $mrjc(
                                                              commission
                                                                  .hashCode,
                                                              charges
                                                                  .hashCode))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.fromCustomerName == this.fromCustomerName &&
          other.toCustomerName == this.toCustomerName &&
          other.fromPhone == this.fromPhone &&
          other.toPhone == this.toPhone &&
          other.bank == this.bank &&
          other.partner == this.partner &&
          other.phone == this.phone &&
          other.transferrorType == this.transferrorType &&
          other.agent == this.agent &&
          other.transactionsType == this.transactionsType &&
          other.date == this.date &&
          other.time == this.time &&
          other.amount == this.amount &&
          other.commission == this.commission &&
          other.charges == this.charges);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int?> id;
  final Value<String> fromCustomerName;
  final Value<String> toCustomerName;
  final Value<String> fromPhone;
  final Value<String> toPhone;
  final Value<String> bank;
  final Value<String> partner;
  final Value<String> phone;
  final Value<String> transferrorType;
  final Value<String> agent;
  final Value<String> transactionsType;
  final Value<String> date;
  final Value<String> time;
  final Value<double> amount;
  final Value<double> commission;
  final Value<double> charges;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.fromCustomerName = const Value.absent(),
    this.toCustomerName = const Value.absent(),
    this.fromPhone = const Value.absent(),
    this.toPhone = const Value.absent(),
    this.bank = const Value.absent(),
    this.partner = const Value.absent(),
    this.phone = const Value.absent(),
    this.transferrorType = const Value.absent(),
    this.agent = const Value.absent(),
    this.transactionsType = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
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
    required String bank,
    required String partner,
    required String phone,
    required String transferrorType,
    required String agent,
    required String transactionsType,
    required String date,
    required String time,
    this.amount = const Value.absent(),
    this.commission = const Value.absent(),
    this.charges = const Value.absent(),
  })  : fromCustomerName = Value(fromCustomerName),
        toCustomerName = Value(toCustomerName),
        fromPhone = Value(fromPhone),
        toPhone = Value(toPhone),
        bank = Value(bank),
        partner = Value(partner),
        phone = Value(phone),
        transferrorType = Value(transferrorType),
        agent = Value(agent),
        transactionsType = Value(transactionsType),
        date = Value(date),
        time = Value(time);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<String>? fromCustomerName,
    Expression<String>? toCustomerName,
    Expression<String>? fromPhone,
    Expression<String>? toPhone,
    Expression<String>? bank,
    Expression<String>? partner,
    Expression<String>? phone,
    Expression<String>? transferrorType,
    Expression<String>? agent,
    Expression<String>? transactionsType,
    Expression<String>? date,
    Expression<String>? time,
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
      if (bank != null) 'bank': bank,
      if (partner != null) 'partner': partner,
      if (phone != null) 'phone': phone,
      if (transferrorType != null) 'transferror_type': transferrorType,
      if (agent != null) 'agent': agent,
      if (transactionsType != null) 'transactions_type': transactionsType,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (amount != null) 'amount': amount,
      if (commission != null) 'commission': commission,
      if (charges != null) 'charges': charges,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int?>? id,
      Value<String>? fromCustomerName,
      Value<String>? toCustomerName,
      Value<String>? fromPhone,
      Value<String>? toPhone,
      Value<String>? bank,
      Value<String>? partner,
      Value<String>? phone,
      Value<String>? transferrorType,
      Value<String>? agent,
      Value<String>? transactionsType,
      Value<String>? date,
      Value<String>? time,
      Value<double>? amount,
      Value<double>? commission,
      Value<double>? charges}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      fromCustomerName: fromCustomerName ?? this.fromCustomerName,
      toCustomerName: toCustomerName ?? this.toCustomerName,
      fromPhone: fromPhone ?? this.fromPhone,
      toPhone: toPhone ?? this.toPhone,
      bank: bank ?? this.bank,
      partner: partner ?? this.partner,
      phone: phone ?? this.phone,
      transferrorType: transferrorType ?? this.transferrorType,
      agent: agent ?? this.agent,
      transactionsType: transactionsType ?? this.transactionsType,
      date: date ?? this.date,
      time: time ?? this.time,
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
    if (bank.present) {
      map['bank'] = Variable<String>(bank.value);
    }
    if (partner.present) {
      map['partner'] = Variable<String>(partner.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (transferrorType.present) {
      map['transferror_type'] = Variable<String>(transferrorType.value);
    }
    if (agent.present) {
      map['agent'] = Variable<String>(agent.value);
    }
    if (transactionsType.present) {
      map['transactions_type'] = Variable<String>(transactionsType.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
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
          ..write('bank: $bank, ')
          ..write('partner: $partner, ')
          ..write('phone: $phone, ')
          ..write('transferrorType: $transferrorType, ')
          ..write('agent: $agent, ')
          ..write('transactionsType: $transactionsType, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
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
    return GeneratedIntColumn('id', $tableName, true,
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

  final VerificationMeta _bankMeta = const VerificationMeta('bank');
  @override
  late final GeneratedTextColumn bank = _constructBank();
  GeneratedTextColumn _constructBank() {
    return GeneratedTextColumn(
      'bank',
      $tableName,
      false,
    );
  }

  final VerificationMeta _partnerMeta = const VerificationMeta('partner');
  @override
  late final GeneratedTextColumn partner = _constructPartner();
  GeneratedTextColumn _constructPartner() {
    return GeneratedTextColumn(
      'partner',
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

  final VerificationMeta _transferrorTypeMeta =
      const VerificationMeta('transferrorType');
  @override
  late final GeneratedTextColumn transferrorType = _constructTransferrorType();
  GeneratedTextColumn _constructTransferrorType() {
    return GeneratedTextColumn(
      'transferror_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _agentMeta = const VerificationMeta('agent');
  @override
  late final GeneratedTextColumn agent = _constructAgent();
  GeneratedTextColumn _constructAgent() {
    return GeneratedTextColumn(
      'agent',
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

  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedTextColumn time = _constructTime();
  GeneratedTextColumn _constructTime() {
    return GeneratedTextColumn(
      'time',
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
        bank,
        partner,
        phone,
        transferrorType,
        agent,
        transactionsType,
        date,
        time,
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
    if (data.containsKey('bank')) {
      context.handle(
          _bankMeta, bank.isAcceptableOrUnknown(data['bank'], _bankMeta));
    } else if (isInserting) {
      context.missing(_bankMeta);
    }
    if (data.containsKey('partner')) {
      context.handle(_partnerMeta,
          partner.isAcceptableOrUnknown(data['partner'], _partnerMeta));
    } else if (isInserting) {
      context.missing(_partnerMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone'], _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('transferror_type')) {
      context.handle(
          _transferrorTypeMeta,
          transferrorType.isAcceptableOrUnknown(
              data['transferror_type'], _transferrorTypeMeta));
    } else if (isInserting) {
      context.missing(_transferrorTypeMeta);
    }
    if (data.containsKey('agent')) {
      context.handle(
          _agentMeta, agent.isAcceptableOrUnknown(data['agent'], _agentMeta));
    } else if (isInserting) {
      context.missing(_agentMeta);
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
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time'], _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
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

class BalanceInputRecord extends DataClass
    implements Insertable<BalanceInputRecord> {
  final int? id;
  final String agent;
  final DateTime date;
  final double eMoney;
  final double cash;
  BalanceInputRecord(
      {this.id,
      required this.agent,
      required this.date,
      required this.eMoney,
      required this.cash});
  factory BalanceInputRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    return BalanceInputRecord(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      agent:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}agent']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      eMoney:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}e_money']),
      cash: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}cash']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || agent != null) {
      map['agent'] = Variable<String>(agent);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || eMoney != null) {
      map['e_money'] = Variable<double>(eMoney);
    }
    if (!nullToAbsent || cash != null) {
      map['cash'] = Variable<double>(cash);
    }
    return map;
  }

  BalanceInputRecordsCompanion toCompanion(bool nullToAbsent) {
    return BalanceInputRecordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      agent:
          agent == null && nullToAbsent ? const Value.absent() : Value(agent),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      eMoney:
          eMoney == null && nullToAbsent ? const Value.absent() : Value(eMoney),
      cash: cash == null && nullToAbsent ? const Value.absent() : Value(cash),
    );
  }

  factory BalanceInputRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BalanceInputRecord(
      id: serializer.fromJson<int?>(json['id']),
      agent: serializer.fromJson<String>(json['agent']),
      date: serializer.fromJson<DateTime>(json['date']),
      eMoney: serializer.fromJson<double>(json['eMoney']),
      cash: serializer.fromJson<double>(json['cash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'agent': serializer.toJson<String>(agent),
      'date': serializer.toJson<DateTime>(date),
      'eMoney': serializer.toJson<double>(eMoney),
      'cash': serializer.toJson<double>(cash),
    };
  }

  BalanceInputRecord copyWith(
          {int? id,
          String? agent,
          DateTime? date,
          double? eMoney,
          double? cash}) =>
      BalanceInputRecord(
        id: id ?? this.id,
        agent: agent ?? this.agent,
        date: date ?? this.date,
        eMoney: eMoney ?? this.eMoney,
        cash: cash ?? this.cash,
      );
  @override
  String toString() {
    return (StringBuffer('BalanceInputRecord(')
          ..write('id: $id, ')
          ..write('agent: $agent, ')
          ..write('date: $date, ')
          ..write('eMoney: $eMoney, ')
          ..write('cash: $cash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(agent.hashCode,
          $mrjc(date.hashCode, $mrjc(eMoney.hashCode, cash.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BalanceInputRecord &&
          other.id == this.id &&
          other.agent == this.agent &&
          other.date == this.date &&
          other.eMoney == this.eMoney &&
          other.cash == this.cash);
}

class BalanceInputRecordsCompanion extends UpdateCompanion<BalanceInputRecord> {
  final Value<int?> id;
  final Value<String> agent;
  final Value<DateTime> date;
  final Value<double> eMoney;
  final Value<double> cash;
  const BalanceInputRecordsCompanion({
    this.id = const Value.absent(),
    this.agent = const Value.absent(),
    this.date = const Value.absent(),
    this.eMoney = const Value.absent(),
    this.cash = const Value.absent(),
  });
  BalanceInputRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String agent,
    required DateTime date,
    required double eMoney,
    required double cash,
  })   : agent = Value(agent),
        date = Value(date),
        eMoney = Value(eMoney),
        cash = Value(cash);
  static Insertable<BalanceInputRecord> custom({
    Expression<int>? id,
    Expression<String>? agent,
    Expression<DateTime>? date,
    Expression<double>? eMoney,
    Expression<double>? cash,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (agent != null) 'agent': agent,
      if (date != null) 'date': date,
      if (eMoney != null) 'e_money': eMoney,
      if (cash != null) 'cash': cash,
    });
  }

  BalanceInputRecordsCompanion copyWith(
      {Value<int?>? id,
      Value<String>? agent,
      Value<DateTime>? date,
      Value<double>? eMoney,
      Value<double>? cash}) {
    return BalanceInputRecordsCompanion(
      id: id ?? this.id,
      agent: agent ?? this.agent,
      date: date ?? this.date,
      eMoney: eMoney ?? this.eMoney,
      cash: cash ?? this.cash,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (agent.present) {
      map['agent'] = Variable<String>(agent.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (eMoney.present) {
      map['e_money'] = Variable<double>(eMoney.value);
    }
    if (cash.present) {
      map['cash'] = Variable<double>(cash.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalanceInputRecordsCompanion(')
          ..write('id: $id, ')
          ..write('agent: $agent, ')
          ..write('date: $date, ')
          ..write('eMoney: $eMoney, ')
          ..write('cash: $cash')
          ..write(')'))
        .toString();
  }
}

class $BalanceInputRecordsTable extends BalanceInputRecords
    with TableInfo<$BalanceInputRecordsTable, BalanceInputRecord> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BalanceInputRecordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _agentMeta = const VerificationMeta('agent');
  @override
  late final GeneratedTextColumn agent = _constructAgent();
  GeneratedTextColumn _constructAgent() {
    return GeneratedTextColumn('agent', $tableName, false, maxTextLength: 50);
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedDateTimeColumn date = _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _eMoneyMeta = const VerificationMeta('eMoney');
  @override
  late final GeneratedRealColumn eMoney = _constructEMoney();
  GeneratedRealColumn _constructEMoney() {
    return GeneratedRealColumn(
      'e_money',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cashMeta = const VerificationMeta('cash');
  @override
  late final GeneratedRealColumn cash = _constructCash();
  GeneratedRealColumn _constructCash() {
    return GeneratedRealColumn(
      'cash',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, agent, date, eMoney, cash];
  @override
  $BalanceInputRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'balance_input_records';
  @override
  final String actualTableName = 'balance_input_records';
  @override
  VerificationContext validateIntegrity(Insertable<BalanceInputRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('agent')) {
      context.handle(
          _agentMeta, agent.isAcceptableOrUnknown(data['agent'], _agentMeta));
    } else if (isInserting) {
      context.missing(_agentMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('e_money')) {
      context.handle(_eMoneyMeta,
          eMoney.isAcceptableOrUnknown(data['e_money'], _eMoneyMeta));
    } else if (isInserting) {
      context.missing(_eMoneyMeta);
    }
    if (data.containsKey('cash')) {
      context.handle(
          _cashMeta, cash.isAcceptableOrUnknown(data['cash'], _cashMeta));
    } else if (isInserting) {
      context.missing(_cashMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BalanceInputRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BalanceInputRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BalanceInputRecordsTable createAlias(String alias) {
    return $BalanceInputRecordsTable(_db, alias);
  }
}

class OpeningClosingData extends DataClass
    implements Insertable<OpeningClosingData> {
  final int? id;
  final double openingCash;
  final double openingEMoney;
  final double? closingCash;
  final double? closingEMoney;
  final String date;
  final String agent;
  OpeningClosingData(
      {this.id,
      required this.openingCash,
      required this.openingEMoney,
      this.closingCash,
      this.closingEMoney,
      required this.date,
      required this.agent});
  factory OpeningClosingData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    return OpeningClosingData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      openingCash: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}opening_cash']),
      openingEMoney: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}opening_e_money']),
      closingCash: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}closing_cash']),
      closingEMoney: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}closing_e_money']),
      date: stringType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      agent:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}agent']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || openingCash != null) {
      map['opening_cash'] = Variable<double>(openingCash);
    }
    if (!nullToAbsent || openingEMoney != null) {
      map['opening_e_money'] = Variable<double>(openingEMoney);
    }
    if (!nullToAbsent || closingCash != null) {
      map['closing_cash'] = Variable<double>(closingCash);
    }
    if (!nullToAbsent || closingEMoney != null) {
      map['closing_e_money'] = Variable<double>(closingEMoney);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || agent != null) {
      map['agent'] = Variable<String>(agent);
    }
    return map;
  }

  OpeningClosingCompanion toCompanion(bool nullToAbsent) {
    return OpeningClosingCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      openingCash: openingCash == null && nullToAbsent
          ? const Value.absent()
          : Value(openingCash),
      openingEMoney: openingEMoney == null && nullToAbsent
          ? const Value.absent()
          : Value(openingEMoney),
      closingCash: closingCash == null && nullToAbsent
          ? const Value.absent()
          : Value(closingCash),
      closingEMoney: closingEMoney == null && nullToAbsent
          ? const Value.absent()
          : Value(closingEMoney),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      agent:
          agent == null && nullToAbsent ? const Value.absent() : Value(agent),
    );
  }

  factory OpeningClosingData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return OpeningClosingData(
      id: serializer.fromJson<int?>(json['id']),
      openingCash: serializer.fromJson<double>(json['openingCash']),
      openingEMoney: serializer.fromJson<double>(json['openingEMoney']),
      closingCash: serializer.fromJson<double?>(json['closingCash']),
      closingEMoney: serializer.fromJson<double?>(json['closingEMoney']),
      date: serializer.fromJson<String>(json['date']),
      agent: serializer.fromJson<String>(json['agent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'openingCash': serializer.toJson<double>(openingCash),
      'openingEMoney': serializer.toJson<double>(openingEMoney),
      'closingCash': serializer.toJson<double?>(closingCash),
      'closingEMoney': serializer.toJson<double?>(closingEMoney),
      'date': serializer.toJson<String>(date),
      'agent': serializer.toJson<String>(agent),
    };
  }

  OpeningClosingData copyWith(
          {int? id,
          double? openingCash,
          double? openingEMoney,
          double? closingCash,
          double? closingEMoney,
          String? date,
          String? agent}) =>
      OpeningClosingData(
        id: id ?? this.id,
        openingCash: openingCash ?? this.openingCash,
        openingEMoney: openingEMoney ?? this.openingEMoney,
        closingCash: closingCash ?? this.closingCash,
        closingEMoney: closingEMoney ?? this.closingEMoney,
        date: date ?? this.date,
        agent: agent ?? this.agent,
      );
  @override
  String toString() {
    return (StringBuffer('OpeningClosingData(')
          ..write('id: $id, ')
          ..write('openingCash: $openingCash, ')
          ..write('openingEMoney: $openingEMoney, ')
          ..write('closingCash: $closingCash, ')
          ..write('closingEMoney: $closingEMoney, ')
          ..write('date: $date, ')
          ..write('agent: $agent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          openingCash.hashCode,
          $mrjc(
              openingEMoney.hashCode,
              $mrjc(
                  closingCash.hashCode,
                  $mrjc(closingEMoney.hashCode,
                      $mrjc(date.hashCode, agent.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is OpeningClosingData &&
          other.id == this.id &&
          other.openingCash == this.openingCash &&
          other.openingEMoney == this.openingEMoney &&
          other.closingCash == this.closingCash &&
          other.closingEMoney == this.closingEMoney &&
          other.date == this.date &&
          other.agent == this.agent);
}

class OpeningClosingCompanion extends UpdateCompanion<OpeningClosingData> {
  final Value<int?> id;
  final Value<double> openingCash;
  final Value<double> openingEMoney;
  final Value<double?> closingCash;
  final Value<double?> closingEMoney;
  final Value<String> date;
  final Value<String> agent;
  const OpeningClosingCompanion({
    this.id = const Value.absent(),
    this.openingCash = const Value.absent(),
    this.openingEMoney = const Value.absent(),
    this.closingCash = const Value.absent(),
    this.closingEMoney = const Value.absent(),
    this.date = const Value.absent(),
    this.agent = const Value.absent(),
  });
  OpeningClosingCompanion.insert({
    this.id = const Value.absent(),
    this.openingCash = const Value.absent(),
    this.openingEMoney = const Value.absent(),
    this.closingCash = const Value.absent(),
    this.closingEMoney = const Value.absent(),
    required String date,
    required String agent,
  })   : date = Value(date),
        agent = Value(agent);
  static Insertable<OpeningClosingData> custom({
    Expression<int>? id,
    Expression<double>? openingCash,
    Expression<double>? openingEMoney,
    Expression<double>? closingCash,
    Expression<double>? closingEMoney,
    Expression<String>? date,
    Expression<String>? agent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (openingCash != null) 'opening_cash': openingCash,
      if (openingEMoney != null) 'opening_e_money': openingEMoney,
      if (closingCash != null) 'closing_cash': closingCash,
      if (closingEMoney != null) 'closing_e_money': closingEMoney,
      if (date != null) 'date': date,
      if (agent != null) 'agent': agent,
    });
  }

  OpeningClosingCompanion copyWith(
      {Value<int?>? id,
      Value<double>? openingCash,
      Value<double>? openingEMoney,
      Value<double?>? closingCash,
      Value<double?>? closingEMoney,
      Value<String>? date,
      Value<String>? agent}) {
    return OpeningClosingCompanion(
      id: id ?? this.id,
      openingCash: openingCash ?? this.openingCash,
      openingEMoney: openingEMoney ?? this.openingEMoney,
      closingCash: closingCash ?? this.closingCash,
      closingEMoney: closingEMoney ?? this.closingEMoney,
      date: date ?? this.date,
      agent: agent ?? this.agent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (openingCash.present) {
      map['opening_cash'] = Variable<double>(openingCash.value);
    }
    if (openingEMoney.present) {
      map['opening_e_money'] = Variable<double>(openingEMoney.value);
    }
    if (closingCash.present) {
      map['closing_cash'] = Variable<double>(closingCash.value);
    }
    if (closingEMoney.present) {
      map['closing_e_money'] = Variable<double>(closingEMoney.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (agent.present) {
      map['agent'] = Variable<String>(agent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OpeningClosingCompanion(')
          ..write('id: $id, ')
          ..write('openingCash: $openingCash, ')
          ..write('openingEMoney: $openingEMoney, ')
          ..write('closingCash: $closingCash, ')
          ..write('closingEMoney: $closingEMoney, ')
          ..write('date: $date, ')
          ..write('agent: $agent')
          ..write(')'))
        .toString();
  }
}

class $OpeningClosingTable extends OpeningClosing
    with TableInfo<$OpeningClosingTable, OpeningClosingData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $OpeningClosingTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _openingCashMeta =
      const VerificationMeta('openingCash');
  @override
  late final GeneratedRealColumn openingCash = _constructOpeningCash();
  GeneratedRealColumn _constructOpeningCash() {
    return GeneratedRealColumn('opening_cash', $tableName, false,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _openingEMoneyMeta =
      const VerificationMeta('openingEMoney');
  @override
  late final GeneratedRealColumn openingEMoney = _constructOpeningEMoney();
  GeneratedRealColumn _constructOpeningEMoney() {
    return GeneratedRealColumn('opening_e_money', $tableName, false,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _closingCashMeta =
      const VerificationMeta('closingCash');
  @override
  late final GeneratedRealColumn closingCash = _constructClosingCash();
  GeneratedRealColumn _constructClosingCash() {
    return GeneratedRealColumn('closing_cash', $tableName, true,
        defaultValue: Constant(0.0));
  }

  final VerificationMeta _closingEMoneyMeta =
      const VerificationMeta('closingEMoney');
  @override
  late final GeneratedRealColumn closingEMoney = _constructClosingEMoney();
  GeneratedRealColumn _constructClosingEMoney() {
    return GeneratedRealColumn('closing_e_money', $tableName, true,
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

  final VerificationMeta _agentMeta = const VerificationMeta('agent');
  @override
  late final GeneratedTextColumn agent = _constructAgent();
  GeneratedTextColumn _constructAgent() {
    return GeneratedTextColumn(
      'agent',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, openingCash, openingEMoney, closingCash, closingEMoney, date, agent];
  @override
  $OpeningClosingTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'opening_closing';
  @override
  final String actualTableName = 'opening_closing';
  @override
  VerificationContext validateIntegrity(Insertable<OpeningClosingData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('opening_cash')) {
      context.handle(
          _openingCashMeta,
          openingCash.isAcceptableOrUnknown(
              data['opening_cash'], _openingCashMeta));
    }
    if (data.containsKey('opening_e_money')) {
      context.handle(
          _openingEMoneyMeta,
          openingEMoney.isAcceptableOrUnknown(
              data['opening_e_money'], _openingEMoneyMeta));
    }
    if (data.containsKey('closing_cash')) {
      context.handle(
          _closingCashMeta,
          closingCash.isAcceptableOrUnknown(
              data['closing_cash'], _closingCashMeta));
    }
    if (data.containsKey('closing_e_money')) {
      context.handle(
          _closingEMoneyMeta,
          closingEMoney.isAcceptableOrUnknown(
              data['closing_e_money'], _closingEMoneyMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('agent')) {
      context.handle(
          _agentMeta, agent.isAcceptableOrUnknown(data['agent'], _agentMeta));
    } else if (isInserting) {
      context.missing(_agentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OpeningClosingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return OpeningClosingData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $OpeningClosingTable createAlias(String alias) {
    return $OpeningClosingTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $BalanceTable balance = $BalanceTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $BalanceInputRecordsTable balanceInputRecords =
      $BalanceInputRecordsTable(this);
  late final $OpeningClosingTable openingClosing = $OpeningClosingTable(this);
  late final BalanceDao balanceDao = BalanceDao(this as MyDatabase);
  late final TransactionsDao transactionsDao =
      TransactionsDao(this as MyDatabase);
  late final BalanceInputRecordsDao balanceInputRecordsDao =
      BalanceInputRecordsDao(this as MyDatabase);
  late final OpeningClosingDao openingClosingDao =
      OpeningClosingDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [balance, transactions, balanceInputRecords, openingClosing];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$OpeningClosingDaoMixin on DatabaseAccessor<MyDatabase> {
  $OpeningClosingTable get openingClosing => attachedDatabase.openingClosing;
}
mixin _$BalanceInputRecordsDaoMixin on DatabaseAccessor<MyDatabase> {
  $BalanceInputRecordsTable get balanceInputRecords =>
      attachedDatabase.balanceInputRecords;
}
mixin _$BalanceDaoMixin on DatabaseAccessor<MyDatabase> {
  $BalanceTable get balance => attachedDatabase.balance;
}
mixin _$TransactionsDaoMixin on DatabaseAccessor<MyDatabase> {
  $TransactionsTable get transactions => attachedDatabase.transactions;
}
