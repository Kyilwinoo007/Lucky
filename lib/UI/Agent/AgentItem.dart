import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/AgentViewModel.dart';
import 'package:lucky/UI/Agent/Agent.dart';
import 'package:lucky/UI/Transactions/MoneyInput.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

import 'AgentMoneyStatus.dart';

class AgentItem extends StatefulWidget {
  final String name;
  final Function? callback;
  final int type;
  final int index;

  const AgentItem({
    Key? key,
    required this.name,
    this.callback,
    required this.type,
    required this.index,
  }) : super(key: key);

  @override
  _AgentItemState createState() => _AgentItemState();
}

class _AgentItemState extends State<AgentItem> {
  BalanceData? moneyAmount;
  double transferAmount = 0.0;
  double withdrawAmount = 0.0;
  double chargesAmount = 0.0;
  double commissionAmount = 0.0;
  bool updated = false;
  final AgentViewModel model = serviceLocator<AgentViewModel>();

  @override
  void initState() {
    super.initState();
    model.getBalanceByAgentId(this.widget.name, context);
    model.getTransactionByAgent(this.widget.name,context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    return ChangeNotifierProvider<AgentViewModel>(
        create: (context) => model,
        child: Consumer<AgentViewModel>(builder: (context, model, child) {
          return Container(
            child: Card(
              elevation: 6,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                     var result = await  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoneyInput(
                                      name: this.widget.name,
                                      index: this.widget.index,
                                    )));
                     if(result){
                       model.getBalanceByAgentId(this.widget.name, context);
                     }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 9.0, left: 14, bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              this.widget.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: AgentMoneyStatus(
                                    title: "Transfer",
                                    amountColor: Colors.amber,
                                    amount: model.transfer,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: AgentMoneyStatus(
                                    title: "Withdraw",
                                    amountColor: Colors.deepPurple,
                                    amount: model.withdraw,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: AgentMoneyStatus(
                                    title: "Remaining EMoney",
                                    amountColor: Colors.deepOrange,
                                    amount: model.eMoney,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: AgentMoneyStatus(
                                    title: "Charges",
                                    amountColor: Colors.green,
                                    amount: model.charges,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: AgentMoneyStatus(
                                    title: "Commission",
                                    amountColor: Colors.blue,
                                    amount: model.commission,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: AgentMoneyStatus(
                                    title: "Remaining Cash",
                                    amountColor: Colors.brown,
                                    amount: model.cash,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
