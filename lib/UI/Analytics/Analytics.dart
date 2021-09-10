import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucky/UI/Analytics/BankTransferChart.dart';
import 'package:lucky/UI/Analytics/PartnerTransferChart.dart';
import 'package:lucky/UI/Analytics/ProfitChart.dart';
import 'package:lucky/UI/Analytics/DepositeChart.dart';
import 'package:lucky/UI/Analytics/TransferChart.dart';
import 'package:lucky/UI/Analytics/WithdrawChart.dart';
import 'package:responsive_widgets/responsive_widgets.dart';


class Analytics extends StatefulWidget {
  @override
  _AnalyticState createState() => _AnalyticState();
}

class _AnalyticState extends State<Analytics> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(
      text: "Deposit",
    ),
    Tab(
      text: "Transfer",
    ),
    Tab(
      text: "Withdraw",
    ),
    Tab(
      text: "Bank",
    ),
    Tab(text: "Partner",
    ),
    Tab(
      text: "Profit",
    ),
  ];

  List<Widget> screens = [
    DepositeChart(),
    TransferChart(),
    WithdrawChart(),
    BankTransferChart(),
    PartnerTransferChart(),
    ProfitChart(),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _tabController = TabController(length: list.length, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    this._tabController.dispose();
    super.dispose();
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
    return ColorfulSafeArea(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          // title: Text(
          //   "Analytics",
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 23.0,
          //   ),
          // ),
          // centerTitle: true,
          child: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey[600],
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _tabController,
            tabs: list,
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: screens[_selectedIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}