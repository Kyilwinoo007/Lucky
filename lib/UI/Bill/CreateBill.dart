import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/TransactionViewModel.dart';
import 'package:lucky/UI/Widgets/CustomButton.dart';
import 'package:lucky/UI/Widgets/CustomTextInput.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/UI/Widgets/Wrapper.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/Utils/styles.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class CreateBill extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateBillState();

}

class _CreateBillState extends State<CreateBill> {
  late List<DropdownMenuItem<String>> _agentDropDownMenuItems =
  getDropDownMenuItems();
  String? _selectedAgent = Constants.agentList[0];
  late BalanceData balancedata;

  final TransactionViewModel model = serviceLocator<TransactionViewModel>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController commissionController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController chargesController = new TextEditingController();

  Wrapper _nameErrMessage = new Wrapper("");
  Wrapper _phoneErrMessage = new Wrapper("");
  Wrapper _amountErrMessage = new Wrapper("");
  Wrapper _commissionErrMessage = new Wrapper("");
  Wrapper _chargesErrMessage = new Wrapper("");

  var _date = new DateTime.now();

  @override
  void initState() {
    super.initState();
    getBalanceByAgentName();
  }
  static List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String agent in Constants.agentList) {
      items.add(
        new DropdownMenuItem(
          value: agent,
          child: new Text(
            agent,
            style: formLabelTextStyle.copyWith(
              color: Colors.black,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }
    return items;
  }


  @override
  Widget build(BuildContext context) {
    final nameInput = CustomTextInput(
      controller: this.nameController,
      errorMessage: this._nameErrMessage.value,
      label: "Bill Name",
      isRequired: true,
      hintText: "Enter Bill Name",
      leadingIcon: Icon(
        LineAwesomeIcons.user,
        size: 25.0,
      ),
    );

    final phNoInput = CustomTextInput(
      inputType: TextInputType.number,
      controller: this.phoneController,
      errorMessage: this._phoneErrMessage.value,
      isRequired: false,
      label: "Phone No.",
      hintText: "eg.09***",
      leadingIcon: Icon(
        LineAwesomeIcons.phone,
        size: 25.0,
      ),
    );
    final commissionInput = CustomTextInput(
      controller: this.commissionController,
      errorMessage: this._commissionErrMessage.value,
      label: "Commission",
      inputType: TextInputType.number,
      leadingIcon: Icon(
        LineAwesomeIcons.hand_holding_us_dollar,
        size: 25.0,
      ),
      hintText: 'eg.1000',
    );
    final chargesInput = CustomTextInput(
      errorMessage: this._chargesErrMessage.value,
      inputType: TextInputType.number,
      controller: this.chargesController,
      isRequired: false,
      label: "Fees",
      hintText: "eg.1000",
      leadingIcon: Icon(
        LineAwesomeIcons.alternate_wavy_money_bill,
        size: 25.0,
      ),
    );

    final amountInput = CustomTextInput(
      inputType: TextInputType.number,
      isRequired: true,
      controller: this.amountController,
      errorMessage: this._amountErrMessage.value,
      label: "Amount",
      hintText: "eg.12000",
      leadingIcon: Icon(
        LineAwesomeIcons.wavy_money_bill,
        size: 25.0,
      ),
    );
    final dateInput = InkWell(
      onTap: () {
        DatePicker.showDatePicker(
          context,
          theme: Utils.kDateTimePickerTheme,
          showTitleActions: true,
          onConfirm: (date) {
            setState(() {
              this._date = date;
            });
          },
          currentTime: this._date,
        );
      },
      child: MyCustomInput(
        label: "Date",
        isRequired: false,
        errorMessage: '',
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  LineAwesomeIcons.calendar,
                  color: Colors.grey,
                  size: 25.0,
                ),
              ),
              Center(
                child: Text(
                  this._date == null
                      ? "Choose Date"
                      : "${this._date.day}-${this._date.month}-${this._date.year}",
                  style: formLabelTextStyle.copyWith(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    final agentInput = MyCustomInput(
      isRequired: false,
      label: 'Select Agent',
      errorMessage: '',
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              LineAwesomeIcons.alternate_sync,
              size: 25.0,
              color: Colors.grey,
            ),
          ),
          Center(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                elevation: 0,
                value: _selectedAgent,
                items: _agentDropDownMenuItems,
                onChanged: (selectedItem) {
                  setState(() {
                    _selectedAgent = selectedItem;
                    getBalanceByAgentName();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );

    final submitButton = SolidGreenButton(
      title: "Submit",
      clickHandler: () async {
        if (isValid()) {
          updateBalance();
          saveTransaction();
        }
      },
    );
    final cancelButton = OutlineGreenElevatedButton(
      title: "Cancel",
      clickHandler: () {
        Navigator.of(context).pop();
      },
    );
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

    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: luckyAppbar(
        context: context,
        title: "Create Bill Top Up",
      ),
      body: orientation == Orientation.landscape
          ? buildLandscapeView(
          name: nameInput,
          phoneNo: phNoInput,
          amount: amountInput,
          commission: commissionInput,
          charge:chargesInput,
          agent: agentInput,
          date: dateInput,
          submitButton: submitButton,
          cancelButton: cancelButton)
          : buildPortraitView(
          name: nameInput,
          phoneNo: phNoInput,
          amount: amountInput,
          commision: commissionInput,
          charge:chargesInput,
          agent: agentInput,
          date: dateInput,
          submitButton: submitButton,
          cancelButton: cancelButton),
    );
  }

  void getBalanceByAgentName() async{
    balancedata =
        await model.getBalanceByAgentName(_selectedAgent.toString(), context);
  }

  bool isValid() {
    bool isNameValid, isAmountValid;
    bool isCommissionValid = true;
    bool isChargeValid = true;
    bool isPhoneValid = true;
    String nameErrorMsg = '', amountErrorMsg = '' ,commissionErrorMsg = '',phoneErrorMsg = '',chargeErrorMsg = '';
    if (nameController.text.trim().isNotEmpty) {
      isNameValid = true;
    } else {
      nameErrorMsg = "Required";
      isNameValid = false;
    }

    if (amountController.text.trim().isNotEmpty) {
      double amount = double.parse(amountController.text.trim());
      if(amount > 1) {
        if (balancedata != null) {
          if (amount > balancedata.eMoney) {
            amountErrorMsg = "Exceeded max amount";
            isAmountValid = false;
          } else {
            isAmountValid = true;
          }
        } else {
          amountErrorMsg = "Not enough amount.";
          isAmountValid = false;
        }
      }else{
        amountErrorMsg = "Invalid";
        isAmountValid = false;
      }
    } else {
      amountErrorMsg = "Required";
      isAmountValid = false;
    }
    if(commissionController.text.trim().isNotEmpty){
      double commission = double.parse(commissionController.text.trim());
      if(commission < 1){
        isCommissionValid = false;
        commissionErrorMsg = "Invalid";
      }
    }

    if(chargesController.text.trim().isNotEmpty){
      double charge = double.parse(chargesController.text.trim());
      if(charge < 1){
        isChargeValid = false;
        chargeErrorMsg = "Invalid";
      }
    }
    if(phoneController.text.trim().isNotEmpty){
      if(!Utils.validatePhone(phoneController.text.trim())){
        isPhoneValid = false;
        phoneErrorMsg = "Invalid phone number !";
      }
    }

    setState(() {
      _commissionErrMessage.value = commissionErrorMsg;
      _nameErrMessage.value = nameErrorMsg;
      _amountErrMessage.value = amountErrorMsg;
      _phoneErrMessage.value = phoneErrorMsg;
      _chargesErrMessage.value = chargeErrorMsg;
    });

    return isNameValid && isAmountValid && isCommissionValid && isPhoneValid && isChargeValid;
  }

  void updateBalance() {
    //add cash
    //reduce eMoney
    //add Commission to eMoney
    double commission = this.commissionController.text.trim().isNotEmpty
        ? double.parse(this.commissionController.text.trim())
        : 0.0;
    double charges = this.chargesController.text.trim().isNotEmpty
        ? double.parse(this.chargesController.text.trim())
        : 0.0;
    double amount = double.parse(this.amountController.text.trim());
    double cash = balancedata.cash + amount + charges;
    double eMoney = (balancedata.eMoney - amount) + commission;
    model.updateBalance(BalanceData(
        id: balancedata.id,
        cash: cash,
        eMoney: eMoney,
        date: Utils.getCurrentDate(),
        agent: balancedata.agent));
  }

  void saveTransaction() async{
    double commission = this.commissionController.text.trim().isNotEmpty
        ? double.parse(this.commissionController.text.trim())
        : 0.0;
    var result = await model.saveTransaction(
        context,
        Transaction(
            bank: "",
            partner: "",
            phone: "",
            fromCustomerName: nameController.text,
            toCustomerName: "",
            fromPhone: phoneController.text.isEmpty ? "" : phoneController.text,
            toPhone: "",
            agent: _selectedAgent.toString(),
            transactionsType: Constants.BILL_TOP_UP,
            date: Utils.formatDate(_date),
            time: Utils.formatTime(DateTime.now()),
            amount: double.parse(amountController.text.trim()),
            commission: commission,
            transferrorType: Constants.CustomerType,
            charges: chargesController.text.trim().isNotEmpty ? double.parse(chargesController.text) : 0.0));
    if (result) {
      Utils.successDialog(context, "Success!", "Successfully Added")
          .then((value) {
        if (value != null) {
          Navigator.of(context).pop(true);
        }
      });
    } else {
      Utils.errorDialog(context, "Something went wrong!");
    }
  }

  buildLandscapeView(
      {required CustomTextInput name,
      required CustomTextInput phoneNo,
      required CustomTextInput amount,
      required CustomTextInput commission,
      required MyCustomInput agent,
      required InkWell date,
      required SolidGreenButton submitButton,
      required OutlineGreenElevatedButton cancelButton, required CustomTextInput charge}) {

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 16),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: name,
              ),
              Expanded(
                child: phoneNo,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: amount,
              ),
              Expanded(child: charge),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: commission,
              ),
              Expanded(
                child: agent,
              ),
              Expanded(
                child: date,
              )
            ],
          ),
        ),
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: submitButton),
              SizedBox(
                width: 10,
              ),
              Expanded(child: cancelButton),
            ],
          ),
        )
      ],
    );

  }

  buildPortraitView(
      {required CustomTextInput name,
      required CustomTextInput phoneNo,
      required CustomTextInput amount,
      required CustomTextInput commision,
      required MyCustomInput agent,
      required InkWell date,
      required SolidGreenButton submitButton,
      required OutlineGreenElevatedButton cancelButton, required CustomTextInput charge}) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 16,
          bottom: 16
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            name,
            SizedBox(height: 10,),
            phoneNo,
            SizedBox(height: 10,),
            amount,
            SizedBox(height: 10,),
            charge,
            SizedBox(height: 10,),
            commision,
            SizedBox(height: 10,),
            Row(
                children: <Widget>[
                  Expanded(
                    child: agent,
                  ),
                  Expanded(
                    child: date,
                  ),
                ],
              ),
            SizedBox(height: 32,),
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: submitButton,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: cancelButton,
                  ),
                ],
              ),
          ],
        ),
      ),
    );

  }
}