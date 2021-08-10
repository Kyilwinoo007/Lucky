import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/TransactionViewModel.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/Utils/styles.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class OpeningClosingHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OpeningClosingHistoryState();
}

class _OpeningClosingHistoryState extends State<OpeningClosingHistory> {
  final TransactionViewModel model = serviceLocator<TransactionViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: model.getAllOpeningClosing(context),
          builder: (context, AsyncSnapshot<List<OpeningClosingData>> snapshot) {
            final openingClosingList = snapshot.data ?? [];
            return buildBody(openingClosingList);
          }),
    );
  }

  Widget buildBody(List<OpeningClosingData> openingClosingList) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return openingClosingList.length > 0
        ? (orientation == Orientation.landscape
            ? buildLandscapeLayout(
                openingClosingList,
              )
            : buildPortraitLayout(
                openingClosingList,
              ))
        : Utils.buildEmptyView(
            context: context,
            icon: LineAwesomeIcons.crying_face,
            title: "Empty History");
  }

  buildLandscapeLayout(List<OpeningClosingData> openingClosingList) {
    return ListView.builder(
      itemCount: openingClosingList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(
          //     builder: (context) => DepositeDetail(openingClosingList[index])));
        },
        child: Container(
          width: 20,
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Print',
                color: Colors.green,
                icon: Icons.print,
                onTap: () => {},
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                  deleteTransaction(openingClosingList[index]),
                },
              ),
            ],
            child: OpeningClosingItem(
              openingClosingData: openingClosingList[index],
            ),
          ),
        ),
      ),
    );
  }

  buildPortraitLayout(List<OpeningClosingData> openingClosingList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        itemCount: openingClosingList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
           //todo go to detail
          },
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Print',
                color: Colors.green,
                icon: Icons.print,
                onTap: () => {},
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                  deleteTransaction(openingClosingList[index]),
                },
              ),
            ],
            child: OpeningClosingItem(
              openingClosingData: openingClosingList[index],
            ),
          ),
        ),
      ),
    );
  }

  deleteTransaction(OpeningClosingData openingClosingList) {

  }
}

class OpeningClosingItem extends StatelessWidget {
  final OpeningClosingData openingClosingData;

  const OpeningClosingItem({Key? key, required this.openingClosingData})
      : super(key: key);

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
    return Container(
        child: Card(
          elevation: 6,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 12, bottom: 4,right: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        this.openingClosingData.agent,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        this.openingClosingData.date,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0 ,left: 14.0,right: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                     Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Opening E-Money",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  this
                                      .openingClosingData
                                      .openingEMoney
                                      .toString(),
                                  style: TextStyle(
                                    color: LuckyColors.splashScreenColors,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Opening Cash",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              this
                                  .openingClosingData
                                  .openingCash
                                  .toString(),
                              style: TextStyle(
                                color: LuckyColors.splashScreenColors,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0,left: 14.0,right: 14.0,bottom:8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Closing E-Money",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              this
                                  .openingClosingData
                                  .closingEMoney
                                  .toString(),
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w900,
                                fontSize: 14.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Closing Cash",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  this
                                      .openingClosingData
                                      .closingCash
                                      .toString(),
                                  // getFormattedCashAmount(amount),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14.0,
                                  ),
                                ),
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
