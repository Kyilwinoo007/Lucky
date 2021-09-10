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

class CreateTransfer extends StatefulWidget {
  @override
  _CreateTransferState createState() => _CreateTransferState();
}

class _CreateTransferState extends State<CreateTransfer> {
  late List<DropdownMenuItem<String>> _agentDropDownMenuItems =
      getDropDownMenuItems();
  String? _selectedAgent = Constants.agentList[0];
  late BalanceData balancedata;

  final TransactionViewModel model = serviceLocator<TransactionViewModel>();

  TextEditingController recipientNameController = new TextEditingController();
  TextEditingController transferorNameController = new TextEditingController();
  TextEditingController transferorPhoneNumberController =
      new TextEditingController();
  TextEditingController recipientPhoneNumberController =
      new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController transferAgentController = new TextEditingController();
  TextEditingController commissionController = new TextEditingController();
  TextEditingController chargesController = new TextEditingController();

  Wrapper _transferorPhoneNumberErrMessage = new Wrapper("");
  Wrapper _transferorNameErrMessage = new Wrapper("");
  Wrapper _recipientPhoneNumberErrMessage = new Wrapper("");
  Wrapper _amountErrMessage = new Wrapper("");
  Wrapper _chargesErrMessage = new Wrapper("");
  Wrapper _commissionErrMessage = new Wrapper("");

  var _date = new DateTime.now();
  var _time = new DateTime.now();

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
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
  void initState() {
    super.initState();
    getBalanceByAgentName();
  }

  @override
  Widget build(BuildContext context) {
    final recipientNameInput = CustomTextInput(
      controller: this.recipientNameController,
      label: "Recipient Name",
      hintText: "Enter Recipient Name",
      leadingIcon: Icon(
        LineAwesomeIcons.user,
        size: 25.0,
      ),
      errorMessage: '',
    );
    final transferorNameInput = CustomTextInput(
      isRequired: true,
      controller: this.transferorNameController,
      errorMessage: _transferorNameErrMessage.value,
      label: "Transferor Name",
      hintText: "Enter Transferor Name",
      leadingIcon: Icon(
        LineAwesomeIcons.user,
        size: 25.0,
      ),
    );

    final recipientPhNoInput = CustomTextInput(
      inputType: TextInputType.number,
      controller: this.recipientPhoneNumberController,
      errorMessage: this._recipientPhoneNumberErrMessage.value,
      isRequired: true,
      label: "Recipient Phone No.",
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
      inputType: TextInputType.phone,
      leadingIcon: Icon(
        LineAwesomeIcons.hand_holding_us_dollar,
        size: 25.0,
      ),
      hintText: 'eg.1000',
    );
    final transferorPhoneNoInput = CustomTextInput(
      controller: this.transferorPhoneNumberController,
      errorMessage: this._transferorPhoneNumberErrMessage.value,
      isRequired: true,
      inputType: TextInputType.number,
      label: "Tranferor Phone No.",
      hintText: "eg.09***",
      leadingIcon: Icon(
        LineAwesomeIcons.phone,
        size: 25.0,
      ),
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
    final transferAmountInput = CustomTextInput(
      inputType: TextInputType.number,
      isRequired: true,
      controller: this.amountController,
      errorMessage: this._amountErrMessage.value,
      // onChangeHandler: this.amountChangeHandler,
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
    final timeInput = InkWell(
      onTap: () {
        DatePicker.showTime12hPicker(context,
            theme: Utils.kDateTimePickerTheme,
            showTitleActions: true, onConfirm: (date) {
          setState(() {
            this._time = date;
          });
        }, currentTime: this._time);
      },
      child: MyCustomInput(
        isRequired: false,
        label: "Time",
        errorMessage: '',
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  LineAwesomeIcons.clock,
                  color: Colors.grey,
                  size: 25.0,
                ),
              ),
              Center(
                child: Text(
                  this._time == null ? "Choose Time" : Utils.formatTime(_time),
                  style: formLabelTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    final userAgentInput = MyCustomInput(
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
      title: "Create",
      clickHandler: () async {
        if (isValid()) {
          updateBalance();
          saveTransaction();
        }
      },
    );
    final clearButton = OutlineGreenElevatedButton(
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
        title: "Create Transfer",
      ),
      body: orientation == Orientation.landscape
          ? buildLandscapeView(
              commissionInput: commissionInput,
              transferorNameInput: transferorNameInput,
              recipientNameInput: recipientNameInput,
              recipientPhNoInput: recipientPhNoInput,
              transferorPhoneNoInput: transferorPhoneNoInput,
              chargesInput: chargesInput,
              transferAmountInput: transferAmountInput,
              dateInput: dateInput,
              timeInput: timeInput,
              userAgentInput: userAgentInput,
              submitButton: submitButton,
              clearButton: clearButton,
            )
          : buildPortraitView(
              commissionInput: commissionInput,
              transferorNameInput: transferorNameInput,
              recipientNameInput: recipientNameInput,
              recipientPhNoInput: recipientPhNoInput,
              transferorPhoneNoInput: transferorPhoneNoInput,
              chargesInput: chargesInput,
              transferAmountInput: transferAmountInput,
              dateInput: dateInput,
              timeInput: timeInput,
              userAgentInput: userAgentInput,
              submitButton: submitButton,
              clearButton: clearButton,
            ),
    );
  }

  buildLandscapeView(
      {commissionInput,
      transferorNameInput,
      recipientNameInput,
      recipientPhNoInput,
      transferorPhoneNoInput,
      chargesInput,
      transferAmountInput,
      dateInput,
      timeInput,
      userAgentInput,
      submitButton,
      clearButton}) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 16),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: transferorNameInput,
              ),
              Expanded(
                child: transferorPhoneNoInput,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: recipientNameInput,
              ),
              Expanded(
                child: recipientPhNoInput,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: transferAmountInput,
              ),
              Expanded(
                child: userAgentInput,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: chargesInput,
              ),
              Expanded(
                child: commissionInput,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: dateInput,
              ),
              Expanded(
                child: timeInput,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: submitButton),
              SizedBox(
                width: 10,
              ),
              Expanded(child: clearButton),
            ],
          ),
        )
      ],
    );
  }

  buildPortraitView(
      {commissionInput,
      transferorNameInput,
      recipientNameInput,
      recipientPhNoInput,
      transferorPhoneNoInput,
      chargesInput,
      transferAmountInput,
      dateInput,
      timeInput,
      userAgentInput,
      submitButton,
      clearButton}) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 16,
          bottom: 16
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            transferorNameInput,
            SizedBox(height: 10,),
            recipientNameInput,
            SizedBox(height: 10,),
            transferorPhoneNoInput,
            SizedBox(height: 10,),
            recipientPhNoInput,
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Expanded(
                  child: transferAmountInput,
                ),
                Expanded(
                  child: chargesInput,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Expanded(
                  child: commissionInput,
                ),
                Expanded(
                  child: userAgentInput,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Expanded(
                  child: dateInput,
                ),
                Expanded(
                  child: timeInput,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: submitButton,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: clearButton,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isValid() {
    bool isRecipientPhoneValid, isTransferorPhoneValid, isAmountValid ,isTransferNameValid;
    bool isFeeValid = true;
    bool isCommissionValid = true;
    String recipientPhoneErrorMsg = '',
        transferPhoneErrorMsg = '',
        amountMsg = '',
        feeMsg = '',
        commissionMsg = '',
        transferNameErrorMsg = '';
    if (recipientPhoneNumberController.text.trim().isNotEmpty) {
      if (Utils.validatePhone(recipientPhoneNumberController.text.trim())) {
        isRecipientPhoneValid = true;
      } else {
        isRecipientPhoneValid = false;
        recipientPhoneErrorMsg = "Invalid Phone";
      }
    } else {
      recipientPhoneErrorMsg = "Required";
      isRecipientPhoneValid = false;
    }
    if (transferorPhoneNumberController.text.trim().isNotEmpty) {
      if (Utils.validatePhone(transferorPhoneNumberController.text.trim())) {
        isTransferorPhoneValid = true;
      } else {
        isTransferorPhoneValid = false;
        transferPhoneErrorMsg = "Invalid Phone";
      }
    } else {
      transferPhoneErrorMsg = "Required";
      isTransferorPhoneValid = false;
    }

    if(transferorNameController.text.trim().isEmpty){
      isTransferNameValid = false;
      transferNameErrorMsg = "Required";
    }else{
      isTransferNameValid = true;
    }

    if (amountController.text.trim().isNotEmpty) {
      double amount = double.parse(amountController.text.trim());
      if (amount > 1) {
        if (balancedata != null) {
          if (amount > balancedata.eMoney) {
            amountMsg = "Exceeded max amount";
            isAmountValid = false;
          } else {
            isAmountValid = true;
          }
        } else {
          amountMsg = "Not enough amount.";
          isAmountValid = false;
        }
      } else {
        amountMsg = "Invalid";
        isAmountValid = false;
      }
    } else {
      amountMsg = "Required";
      isAmountValid = false;
    }
    if (chargesController.text.trim().isNotEmpty) {
      double charges = double.parse(chargesController.text.trim());
      if (charges < 1) {
        isFeeValid = false;
        feeMsg = "Invalid";
      }
    }
    if (commissionController.text.trim().isNotEmpty) {
      double commission = double.parse(commissionController.text.trim());
      if (commission < 1) {
        isCommissionValid = false;
        commissionMsg = "Invalid";
      }
    }

    setState(() {
      _chargesErrMessage.value = feeMsg;
      _commissionErrMessage.value = commissionMsg;
      _recipientPhoneNumberErrMessage.value = recipientPhoneErrorMsg;
      _transferorPhoneNumberErrMessage.value = transferPhoneErrorMsg;
      _amountErrMessage.value = amountMsg;
      _transferorNameErrMessage.value = transferNameErrorMsg;
    });

    return isRecipientPhoneValid &&
        isTransferorPhoneValid &&
        isAmountValid &&
        isFeeValid &&
        isCommissionValid &&
        isTransferNameValid;
  }

  void getBalanceByAgentName() async {
    balancedata =
        await model.getBalanceByAgentName(_selectedAgent.toString(), context);
  }

  void saveTransaction() async {
    double commission = this.commissionController.text.trim().isNotEmpty
        ? double.parse(this.commissionController.text.trim())
        : 0.0;
    double charges = this.chargesController.text.trim().isNotEmpty
        ? double.parse(this.chargesController.text.trim())
        : 0.0;
    var result = await model.saveTransaction(
        context,
        Transaction(
          bank: "",
          partner: "",
          phone: "",
          fromCustomerName: transferorNameController.text,
          toCustomerName: recipientNameController.text,
          fromPhone: transferorPhoneNumberController.text,
          toPhone: recipientPhoneNumberController.text,
          agent: _selectedAgent.toString(),
          transactionsType: Constants.TRANSFER_TYPE,
          date: Utils.formatDate(_date),
          time: Utils.formatTime(_time),
          amount: double.parse(amountController.text.trim()),
          commission: commission,
          transferrorType: Constants.CustomerType,
          charges: charges,
        ));
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

  void updateBalance() {
    //add cash + charges + amount
    //reduce transfer eMoney amount
    //add commission to eMoney
    double commission = this.commissionController.text.trim().isNotEmpty
        ? double.parse(this.commissionController.text.trim())
        : 0.0;
    double charges = this.chargesController.text.trim().isNotEmpty
        ? double.parse(this.chargesController.text.trim())
        : 0.0;
    double cash =
        balancedata.cash + double.parse(amountController.text.trim()) + charges;
    double eMoney =
        (balancedata.eMoney - double.parse(amountController.text.trim())) +
            commission;
    model.updateBalance(BalanceData(
        id: balancedata.id,
        cash: cash,
        eMoney: eMoney,
        date: Utils.getCurrentDate(),
        agent: balancedata.agent));
  }
}
