import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/UI/History/MoneyAddReduceHistory.dart';
import 'package:lucky/UI/History/OpeningClosingHistory.dart';
import 'package:lucky/UI/History/TransactionHistory.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';

class HistoryTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HistoryTabState();

}

class _HistoryTabState extends State<HistoryTab> with SingleTickerProviderStateMixin {
  var controller;
  @override
  void initState() {
    super.initState();
    controller =  TabController(length: 3 ,vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: luckyAppbar(
          bottomWidget: TabBar(
            onTap: (index) {
              // Tab index when user select it, it start from zero
            },
            controller: controller,
            tabs: [
              Tab(text: "Transaction",),
              Tab(text: "Money\nInputs",),
              Tab(text: "Opening\nClosing",),
            ],
          ),
          title:"History", context: context,
        ),
        body: TabBarView(
          controller: controller,
          children: [
            TransactionHistory(),
            MoneyAddReduceHistory(),
            OpeningClosingHistory(),
          ],
        ),
      ),
    );


  }
}