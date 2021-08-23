import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/AnalyticViewModel.dart';
import 'package:lucky/Utils/SaleData.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class DepositeChart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DepositeChartState();
}

class _DepositeChartState extends State<DepositeChart> {
  final Color leftBarColor = Colors.blue; //const Color(0xff53fdd7);
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  final defaultSaleData = [
    new SaleData('Wave Money', 0),
    new SaleData('Cb Pay', 0),
    new SaleData('True Money', 0),
    new SaleData('Kbz Pay', 0)
  ];

  late List<charts.Series<SaleData, String>> saleData;
  final AnalyticViewModel model = serviceLocator<AnalyticViewModel>();

  @override
  void initState() {
    saleData = [
      new charts.Series<SaleData, String>(
        id: 'deposite',
        domainFn: (SaleData sales, _) => sales.agent,
        measureFn: (SaleData sales, _) => sales.sales,
        data: defaultSaleData,
        labelAccessorFn: (SaleData sale, _) => '${sale.sales.toString()}',
      ),
    ];
    super.initState();
    this.loadChartData();

  }
  void loadChartData() async {
    List<Transaction> transactions = await model.getAllTransaction(context);

    var waveMoneyTransactions = transactions
        .where((transaction) {
          return transaction.agent == Constants.WAVEMONEY &&
              Utils.isEqualDateFilter(
                  new DateFormat("dd-MM-yyyy").parse(transaction.date),
                  this._fromDate,
                  this._toDate);
        })
        .toList()
        .where((transaction) =>
            transaction.transactionsType == Constants.DEPOSITE_TYPE)
        .toList();

    var kbzPayTransactions = transactions
        .where(
          (transaction) =>
      transaction.agent == Constants.KBZPAY &&
          Utils.isEqualDateFilter(new DateFormat("dd-MM-yyyy").parse(transaction.date),
              this._fromDate, this._toDate),
    )
        .toList()
        .where((transaction) =>
    transaction.transactionsType == Constants.DEPOSITE_TYPE)
        .toList();

    var trueMoneyTransactions = transactions
        .where(
          (transaction) =>
      transaction.agent == Constants.TRUEMONEY &&
          Utils.isEqualDateFilter(new DateFormat("dd-MM-yyyy").parse(transaction.date),
              this._fromDate, this._toDate),
    )
        .toList()
        .where((transaction) =>
    transaction.transactionsType == Constants.DEPOSITE_TYPE)
        .toList();

    var cbPayTransactions = transactions
        .where(
          (transaction) =>
      transaction.agent == Constants.CBPAY &&
          Utils.isEqualDateFilter(new DateFormat("dd-MM-yyyy").parse(transaction.date),
              this._fromDate, this._toDate),
    )
        .toList()
        .where((transaction) =>
    transaction.transactionsType == Constants.DEPOSITE_TYPE)
        .toList();

    double waveMoneyDepositeAmount =
    waveMoneyTransactions.fold(0, (sum, item) => sum + item.amount);
    double kbzPayDepositeAmount =
    kbzPayTransactions.fold(0, (sum, item) => sum + item.amount);
    double cbPayDepositeAmount =
    cbPayTransactions.fold(0, (sum, item) => sum + item.amount);

    double trueMoneyDepositeAmount =
    trueMoneyTransactions.fold(0, (sum, item) => sum + item.amount);

    final commissionData = [
      new SaleData('Wave Money', waveMoneyDepositeAmount),
      new SaleData('Cb Pay', cbPayDepositeAmount),
      new SaleData('True Money', trueMoneyDepositeAmount),
      new SaleData('Kbz Pay', kbzPayDepositeAmount),
    ];
    setState(() {
      saleData = [
        new charts.Series<SaleData, String>(
          id: 'deposite',
          measureFn: (SaleData sales, _) => sales.sales,
          data: commissionData,
          labelAccessorFn: (SaleData sale, _) => '${sale.sales.toString()}',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(leftBarColor),
          domainFn: (SaleData sales, _) => sales.agent,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      ResponsiveWidgets.init(
        context,
        height: 800,
        width: 480,
        allowFontScaling: true,
      );
    } else {
      ResponsiveWidgets.init(
        context,
        width: 800,
        height: 480,
        allowFontScaling: true,
      );
    }
    var chartWidget = charts.BarChart(
      saleData,
      animate: true,
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 17.sp.toInt(), // size in Pts.
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 16.sp.toInt(), // size in Pts.
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      barRendererDecorator: new charts.BarLabelDecorator<String>(
        insideLabelStyleSpec: new charts.TextStyleSpec(
            fontSize: 14.sp.toInt(),
            color: charts.Color(
              r: 255,
              g: 255,
              b: 255,
            ),
            fontWeight: "144"),
      ),
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          4.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            right: 16.0,
                          ),
                          child: Text(
                            "${this._fromDate.day} / ${this._fromDate.month} / ${this._fromDate.year}",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              currentTime: this._fromDate,
                              theme: Utils.kDateTimePickerTheme,
                              showTitleActions: true,
                              onConfirm: (date) {
                                setState(() {
                                  this._fromDate = date;
                                });
                                this.loadChartData();
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(7.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                            ),
                            child: Text(
                              "Change",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '-',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            right: 16.0,
                          ),
                          child: Text(
                            this._toDate != null
                                ? "${this._toDate.day} / ${this._toDate.month} / ${this._toDate.year}"
                                : "Select Date",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              currentTime: this._toDate,
                              theme: Utils.kDateTimePickerTheme,
                              minTime: this._fromDate,
                              showTitleActions: true,
                              onConfirm: (date) {
                                setState(() {
                                  this._toDate = date;
                                });
                                this.loadChartData();
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(7.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                            ),
                            child: Text(
                              "Change",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: chartWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
