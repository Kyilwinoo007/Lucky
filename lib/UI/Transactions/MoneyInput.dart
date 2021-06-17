import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/AgentViewModel.dart';
import 'package:lucky/Repository/MoneyInputViewModel.dart';
import 'package:lucky/UI/Widgets/CustomButton.dart';
import 'package:lucky/UI/Widgets/CustomTextInput.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/UI/Widgets/Wrapper.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_widgets/responsive_widgets.dart';

class MoneyInput extends StatefulWidget{
  final int type;
  final int index;
  const MoneyInput({
    Key? key,
    required  this.type,
    required this.index,
  }) : super(key: key);

  @override
  _MoneyInputState createState() => _MoneyInputState();
}

class _MoneyInputState extends State<MoneyInput> {
  late BalanceDao balanceDao ;
   late TextEditingController _cashInputController;
   late TextEditingController _eMoneyInputController;
  late Wrapper _cashInputErrMessage;
   late Wrapper _eMoneyInputErrMessage;
  final List<String> imageList = [
    "assets/images/wave(512).jpg",
    "assets/images/kbzpayicon.jpg",
    "assets/images/cbpay.jpg",
    "assets/images/truemoney.jpg"
  ];
  final MoneyInputViewModel model = serviceLocator<MoneyInputViewModel>();
  bool isUpdated = false;

  @override
  void initState() {
    super.initState();
    this._cashInputController = new TextEditingController(text: "");
    this._eMoneyInputController = new TextEditingController(text: "");
    this._cashInputErrMessage = new Wrapper("");
    this._eMoneyInputErrMessage = new Wrapper("");
    balanceDao = Provider.of<BalanceDao>(context,listen: false);
    model.getBalanceByAgentId(widget.type, context);
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
    var submitBtn = OutlineBlackButton(
      title: "Add",
      clickHandler: () async {
       if(checkValid()){
          saveData();
          clearInputs();
        }
      },
    );
    var reduceAmountBtn = OutlineBlackButton(
      title: "Reduce",
      clickHandler: () async {
        // if (await isReduceAmountValid()) {
        //   await this.saveReduceData();
        //   this.clearInputs();
        //   hideKeyboard(context);
        // }
      },
    );
    var eMoneyInput = CustomTextInput(
      errorMessage: _eMoneyInputErrMessage.value,
      controller: this._eMoneyInputController,
      isRequired: true,
      inputType: TextInputType.number,
      label: "E-Money Amount",
      hintText: "Enter E-Money Amount",
      leadingIcon: Icon(
        LineAwesomeIcons.wallet,
      ),
    );
    // var moneyHistory = buildMoneyInputRecordSection();
    var cashInput = CustomTextInput(
      errorMessage: this._cashInputErrMessage.value,
      controller: this._cashInputController,
      isRequired: true,
      inputType: TextInputType.number,
      label: "Cash Amount",
      hintText: "Enter Cash Amount",
      leadingIcon: Icon(
        LineAwesomeIcons.alternate_wavy_money_bill,
      ),
    );
    var leading = InkWell(
      onTap: () {
        // FocusScope.of(context).requestFocus(new FocusNode());
        Navigator.of(context).pop(isUpdated);
      },
      child: Icon(
        Icons.arrow_back,
        size: 25.0,
        color: Colors.white,
      ),
    );
    return ChangeNotifierProvider<MoneyInputViewModel>(
    create: (context)=> model,
      child: WillPopScope(
        onWillPop: () async{
          Navigator.of(context).pop(isUpdated);
          return true;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: luckyAppbar(title: "Set Money", context: context,leading: leading),
            body: MediaQuery.of(context).orientation == Orientation.portrait
                ? buildPortraitView(
              submitBtn,
              eMoneyInput,
              cashInput,
              reduceAmountBtn,
            )
                : buildLandscapeView(
              submitBtn,
              eMoneyInput,
              cashInput,
              reduceAmountBtn,
            ),
        ),
      ),
    );
  }

   buildPortraitView(OutlineBlackButton submitBtn, CustomTextInput eMoneyInput,
       CustomTextInput cashInput,
       OutlineBlackButton reduceAmountBtn) {
     return SingleChildScrollView(
       child: Container(
         height: MediaQuery.of(context).size.height,
         margin: EdgeInsets.symmetric(horizontal: 10.0),
         padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                      image: AssetImage(imageList[widget.index]),
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                Consumer<MoneyInputViewModel>(builder: (context, model, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Text("Remaining Cash : "),
                            Text(model.cash.toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Text("Remaining E-Money : "),
                            Text(model.eMoney.toString()),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: eMoneyInput,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: cashInput,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: submitBtn,
                        ),
                      ),
                      Expanded(
                        child: reduceAmountBtn,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Expanded(
            //   child: moneyInputHistory,
            // )
          ],
        ),
      ),
     );
   }

   buildLandscapeView(OutlineBlackButton submitBtn, CustomTextInput eMoneyInput,
       CustomTextInput cashInput,
       OutlineBlackButton reduceAmountBtn) {
     return SingleChildScrollView(
       child: Container(
         margin: EdgeInsets.symmetric(horizontal: 10.0),
         height: MediaQuery.of(context).size.height * 0.8,
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Expanded(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   // Expanded(
                   //   child: Container(
                   //     margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
                   //     child: ClipRRect(
                   //       borderRadius: BorderRadius.circular(15.0),
                   //       child: Image(
                   //         image: AssetImage(imageList[widget.index]),
                   //         height: 150,
                   //         width: 150,
                   //       ),
                   //     ),
                   //   ),
                   // ),
                   eMoneyInput,
                   cashInput,
                   Row(
                     children: <Widget>[
                       Expanded(
                         child: submitBtn,
                       ),
                       Expanded(
                         child: Padding(
                           padding: EdgeInsets.only(left: 10.0),
                           child: reduceAmountBtn,
                         ),
                       )
                     ],
                   ),
                 ],
               ),
             ),
             // Expanded(
             //   child: Padding(
             //     padding: EdgeInsets.only(top: 20.0),
             //     child: moneyInputHistory,
             //   ),
             // )
           ],
         ),
       ),
     );


   }

  bool checkValid() {
    bool isValid = true;

    String cashErrorMsg = "";
    String eMoneyErrorMsg = "";
    if (this._cashInputController.text.trim().isNotEmpty ) {
      double cash = double.parse(this._cashInputController.text.trim());
      if (cash < 1) {
        cashErrorMsg = "Invalid";
        isValid = false;
      }
    }
      if(_eMoneyInputController.text.trim().isNotEmpty){
        double Emoney = double.parse(this._eMoneyInputController.text.trim());
        if (Emoney < 1) {
          eMoneyErrorMsg = "Invalid";
          isValid = false;
        }
    }
      if(_cashInputController.text.trim().isEmpty && _eMoneyInputController.text.trim().isEmpty) {
        isValid = false;
        eMoneyErrorMsg = "Required";
        cashErrorMsg = "Required";
    }

    setState(() {
      this._cashInputErrMessage.value = cashErrorMsg;
      this._eMoneyInputErrMessage.value = eMoneyErrorMsg;
    });
    return isValid;
  }

  void saveData() async{
     var result ;
    double cash =
        this._cashInputController.text.trim().isNotEmpty ? double.parse(this._cashInputController.text.trim()) : 0.0;
    double eMoney = this._eMoneyInputController.text.trim().isNotEmpty ?
        double.parse(this._eMoneyInputController.text.trim()) : 0.0;
    BalanceData balanceData =
    await balanceDao.getBalanceViaAgentId(this.widget.type.toString());
    if(balanceData != null){
      print(Utils.getCurrentDate());
      if (balanceData.date == Utils.getCurrentDate()) {
        cash += balanceData.cash;
        eMoney += balanceData.e_money;
      }

      result = await model.updateBalance(
        BalanceData(id: balanceData.id,cash: cash, e_money: eMoney, date: Utils.getCurrentDate(), agentId: this.widget.type.toString()),
      );

      }else{
      result = await model.insertBalance(
        BalanceData(cash: cash, e_money: eMoney, date: Utils.getCurrentDate(), agentId: this.widget.type.toString()),
      );
      }
    isUpdated = result;
     if(result){
       Utils.successDialog(context, "Success!", "Successfully Added");
     }else{
       Utils.errorDialog(context, "Something went wrong!");


     }

  }

  void clearInputs() {
    setState(() {
      this._cashInputController.text = "";
      this._cashInputErrMessage.value = "";
      this._eMoneyInputErrMessage.value = "";
      this._eMoneyInputController.text = "";
    });
  }
  }