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

class CreateBankTransfer extends StatefulWidget{
  final String transferorType;
  final List<String> typeList;
  const CreateBankTransfer({
    Key? key,
    required  this.transferorType,required this.typeList,
  }) : super(key: key);


  @override
  _CreateBankTransferState createState() => _CreateBankTransferState();

}

class _CreateBankTransferState extends State<CreateBankTransfer> {
  final TransactionViewModel model = serviceLocator<TransactionViewModel>();
  late List<DropdownMenuItem<String>> _agentDropDownMenuItems = getAgentDropDownMenuItems();
  String? _selectedAgent = Constants.agentList[0];

  TextEditingController bankController = new TextEditingController();
  TextEditingController partnerController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController commissionController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController chargesController = new TextEditingController();

  Wrapper _phoneNumberErrMessage =  new Wrapper("");
  Wrapper _bankNameErrMessage =  new Wrapper("");
  Wrapper _amountErrMessage =  new Wrapper("");
  Wrapper _partnerErrMessage =  new Wrapper("");
  Wrapper _commissionErrMessage =  new Wrapper("");
  Wrapper _chargesErrMessage =  new Wrapper("");


  late List<DropdownMenuItem<String>> _typeDropDownMenuItems;
  String? _selectedType ;

  late BalanceData balanceData;
  late OpeningClosingData openingClosingData;


  var _date = new DateTime.now();

  List<DropdownMenuItem<String>> getDropDownMenuItems(List<String> typeList) {
    List<DropdownMenuItem<String>> items = [];
    for (String type in typeList) {
      items.add(
        new DropdownMenuItem(
          value: type,
          child: new Text(
            type,
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
  List<DropdownMenuItem<String>> getAgentDropDownMenuItems() {
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
    _selectedType = this.widget.typeList[0];
    _typeDropDownMenuItems = getDropDownMenuItems(this.widget.typeList);
    getBalanceByAgentName();
  }

  @override
  Widget build(BuildContext context) {

    final bankInput = CustomTextInput(
      controller: this.bankController,
      isRequired: this.widget.transferorType == Constants.BankType,
      label: "Bank Name",
      hintText: "Enter Bank Name",
      leadingIcon: Icon(
      Icons.account_balance,
        size: 25.0,
      ), errorMessage: _bankNameErrMessage.value,
    );
    final partnerInput = CustomTextInput(
      controller: this.partnerController,
      isRequired: true,
      errorMessage: _partnerErrMessage.value,
      label: "Partner Name",
      hintText: "Enter Partner Name",
      leadingIcon: Icon(
        LineAwesomeIcons.user,
        size: 25.0,
      ),
    );
    final phNoInput = CustomTextInput(
      inputType: TextInputType.number,
      controller: this.phoneNumberController,
      errorMessage: this._phoneNumberErrMessage.value,
      isRequired: this.widget.transferorType == Constants.PartnerType,
      label: "Phone No.",
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

    final commissionInput = CustomTextInput(
      controller: this.commissionController,
      errorMessage: _commissionErrMessage.value,
      label: "Commission",
      inputType: TextInputType.phone,
      leadingIcon: Icon(
        LineAwesomeIcons.hand_holding_us_dollar,
        size: 25.0,
      ), hintText: 'eg.1000',
    );
    final amountInput = CustomTextInput(
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
    final transactionType = MyCustomInput(
      isRequired: false,
      label: 'Select Type',
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
                value: _selectedType,
                items: _typeDropDownMenuItems,
                onChanged: (selectedItem){
                  setState((){
                    _selectedType = selectedItem;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
    final agentType = MyCustomInput(
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
                onChanged: (selectedItem){
                  setState((){
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
      title:"Create",
      clickHandler: () async{
        if(isValid()){
          updateBalance();
          saveTransaction();

        }
      },
    );
    final cancelButton = OutlineGreenElevatedButton(
      title: "Cancel", clickHandler: () {
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
      appBar: luckyAppbar(title: "Create ${this.widget.transferorType} Transfer", context: context),

      body: orientation == Orientation.landscape
          ? buildLandscapeView(
        bankInput: bankInput,
        partnerInput: partnerInput,
        phNoInput : phNoInput,
        amountInput:amountInput,
        commissionInput:commissionInput,
        agentType : agentType,
        dateInput:dateInput,
        chargeInput:chargesInput,
        transactionType :transactionType,
        submitButton: submitButton,
        cancelButton: cancelButton,
      )
          : buildPortraitView(
        bankInput: bankInput,
        partnerInput: partnerInput,
        phNoInput : phNoInput,
        amountInput:amountInput,
        commissionInput:commissionInput,
        agentType : agentType,
        dateInput:dateInput,
        chargeInput:chargesInput,
        transactionType :transactionType,
        submitButton: submitButton,
        cancelButton: cancelButton,
      ),
    );
  }

  buildLandscapeView(
      {required CustomTextInput bankInput,
      required CustomTextInput partnerInput,
      required CustomTextInput phNoInput,
      required CustomTextInput amountInput,
      required CustomTextInput commissionInput,
        required MyCustomInput agentType,
        required InkWell dateInput,
      required MyCustomInput transactionType,
      required SolidGreenButton submitButton,
      required OutlineGreenElevatedButton cancelButton, required CustomTextInput chargeInput}) {

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 16),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              this.widget.transferorType == Constants.BankType ? Expanded(
                child: bankInput,
              ) :
              Expanded(
                child: partnerInput,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[

              Expanded(
                child: phNoInput,
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[

              Expanded(
                child: amountInput,
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[

              Expanded(
                child: chargeInput,
              ),

            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: commissionInput,
              ),
              Expanded(
                child: agentType,
              ),

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
                child: transactionType,
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
      {required CustomTextInput bankInput,
      required CustomTextInput partnerInput,
      required CustomTextInput phNoInput,
      required CustomTextInput amountInput,
      required CustomTextInput commissionInput,
        required MyCustomInput agentType,
        required InkWell dateInput,
      required MyCustomInput transactionType,
      required SolidGreenButton submitButton,
      required OutlineGreenElevatedButton cancelButton, required CustomTextInput chargeInput}) {

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 16,
          bottom: 16
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           this.widget.transferorType == Constants.BankType ? bankInput : partnerInput,
            SizedBox(height: 10,),
            phNoInput,
            SizedBox(height: 10,),
            amountInput,
            SizedBox(height: 10,),
            chargeInput,
            SizedBox(height: 10,),
            Row(
              children: <Widget>[

                Expanded(
                  child: agentType,
                ),
                Expanded(
                  child: commissionInput,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Expanded(
                  child: transactionType,
                ),
                Expanded(
                  child: dateInput,
                ),

              ],
            ),
            SizedBox(height: 24,),
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

  bool isValid() {
    bool isPhoneValid = true,isAmountValid = false,isBankNameValid = true;
    bool isPartNameValid = true;
    bool isCommissionValid = true;
    bool isChargeValid = true;
    String phoneErrorMsg = '' , amountMsg = '',bankNameErrorMsg = '' , commissionMsg = '' ,partnerErrorMsg = '',chargeErrorMsg = '';
    if(this.widget.transferorType == Constants.BankType){    // if current widget is for bank transfer bank name is required and phoneNo is not required
      isPhoneValid = true;
      if(bankController.text.trim().isNotEmpty){
        isBankNameValid = true;
      }else{
        isBankNameValid = false;
        bankNameErrorMsg = "Required";
      }
      if(phoneNumberController.text.trim().isNotEmpty){
        if(!Utils.validatePhone(phoneNumberController.text.trim())){
          isPhoneValid = false;
          phoneErrorMsg = "Invalid Phone";
        }
      }
    }else{                                          //current widget is for partner transfer phone No is required
      isBankNameValid = true;
      if(phoneNumberController.text.trim().isNotEmpty){
        if(Utils.validatePhone(phoneNumberController.text.trim())){
          isPhoneValid = true;
        }else{
          isPhoneValid = false;
          phoneErrorMsg = "Invalid Phone";
        }
      }else{
        phoneErrorMsg = "Required";
        isPhoneValid = false;
      }
      if(partnerController.text.trim().isEmpty){
        isPartNameValid = false;
        partnerErrorMsg = "Required";
      }else{
        isPartNameValid = true;
      }
    }

    if(amountController.text.trim().isNotEmpty){
      double amount = double.parse(amountController.text.trim());
      if(amount > 1) {
        if (_selectedType == Constants.BANK_TRANSFER_TYPE ||
            _selectedType == Constants.PARTNER_TRANSFER_TYPE) {
          if (balanceData != null) {
            if (amount > balanceData.eMoney) {
              amountMsg = "Exceeded max amount";
              isAmountValid = false;
            } else {
              isAmountValid = true;
            }
          } else {
            amountMsg = "Not enough amount.";
            isAmountValid = false;
          }
        } else { //receive eMoney not need to check max amount
          isAmountValid = true;
        }
      }else{
        amountMsg = "Invalid";
        isAmountValid = false;

      }
    }else{
      amountMsg = "Required";
      isAmountValid = false;
    }
    if(commissionController.text.trim().isNotEmpty){
      double commission = double.parse(commissionController.text.trim());
      if(commission < 1){
        isCommissionValid = false;
        commissionMsg = "Invalid";
      }
    }
    if(chargesController.text.trim().isNotEmpty){
      double charge = double.parse(chargesController.text.trim());
      if(charge < 1){
        isChargeValid = false;
        chargeErrorMsg = "Invalid";
      }
    }

    setState(() {
      _commissionErrMessage.value = commissionMsg;
      _phoneNumberErrMessage.value = phoneErrorMsg;
      _bankNameErrMessage.value = bankNameErrorMsg;
      _amountErrMessage.value = amountMsg;
      _partnerErrMessage.value = partnerErrorMsg;
      _chargesErrMessage.value = chargeErrorMsg;
    });

    return isPhoneValid && isBankNameValid && isAmountValid && isCommissionValid && isPartNameValid && isChargeValid;

  }

  void getBalanceByAgentName() async{
    balanceData = await  model.getBalanceByAgentName(_selectedAgent.toString(),context);
  }

  void updateBalance() async{
    double  commission =  this.commissionController.text.trim().isNotEmpty ? double.parse(this.commissionController.text.trim()) : 0.0;
    double charges = this.chargesController.text.trim().isNotEmpty
        ? double.parse(this.chargesController.text.trim())
        : 0.0;
    if(_selectedType == Constants.BANK_TRANSFER_TYPE || _selectedType == Constants.PARTNER_TRANSFER_TYPE){
      //if transfer reduce amount from eMoney
      //add commission to eMoney
      double eMoney =(balanceData.eMoney - double.parse(amountController.text.trim())) + commission;
      model.updateBalance(
          BalanceData(id:balanceData.id,cash: balanceData.cash + charges, eMoney: eMoney, date: Utils.getCurrentDate(), agent: balanceData.agent)
      );

    }else{
      //if receive add amount to eMoney
      //add commission to eMoney

      if(balanceData != null){
        double eMoney =(balanceData.eMoney + double.parse(amountController.text.trim())) + commission - charges;
        model.updateBalance(
            BalanceData(id:balanceData.id,cash: balanceData.cash, eMoney: eMoney, date: Utils.getCurrentDate(), agent: balanceData.agent)
        );
      }else{
        double eMoney =(double.parse(amountController.text.trim()) - charges) + commission;
        model.insertBalance(
          BalanceData(cash: 0.0, eMoney: eMoney, date: Utils.getCurrentDate(), agent: _selectedAgent.toString())
        );
      }
      openingClosingData = await model.getOpeningClosingByAgentAndDate(_selectedAgent.toString(),Utils.getCurrentDate(),context);

      // ignore: unnecessary_null_comparison
      if(openingClosingData != null){
        double  openingEMoney = openingClosingData.openingEMoney + double.parse(amountController.text.trim()) + commission;
        model.updateOpeningClosing(OpeningClosingData(
            id: openingClosingData.id,
            openingCash: openingClosingData.openingCash,
            openingEMoney: openingEMoney,
            closingCash: openingClosingData.closingCash,
            closingEMoney: openingClosingData.closingEMoney,
            date: openingClosingData.date,
            agent: openingClosingData.agent));
      }else{
        double  openingEMoney = double.parse(amountController.text.trim()) + commission;
        model.insertOpeningClosing(
          OpeningClosingData(openingCash: 0.0, openingEMoney: openingEMoney, date: Utils.getCurrentDate(), agent: _selectedAgent.toString())
        );
      }
    }
  }

  void saveTransaction() async{
    double  commission =  this.commissionController.text.trim().isNotEmpty ? double.parse(this.commissionController.text.trim()) : 0.0;
    String bank = "";
    String partner = "" ;
    String phone = phoneNumberController.text.trim().isNotEmpty ? phoneNumberController.text.trim() : "";

    if(this.widget.transferorType == Constants.BankType){
      bank = bankController.text.trim();
    }else{
      partner = partnerController.text.trim().isNotEmpty ? partnerController.text.trim() : "";
    }
    var result = await model.saveTransaction(
        context,
        Transaction(
          bank: bank,
          partner: partner,
          phone: phone,
          fromCustomerName: "",
          toCustomerName: "",
          fromPhone: "",
          toPhone: "",
          agent: _selectedAgent.toString(),
          transactionsType: _selectedType.toString(),
          date: Utils.formatDate(_date),
          time: Utils.formatTime(DateTime.now()),
          amount: double.parse(amountController.text.trim()),
          commission: commission,
          transferrorType: this.widget.transferorType,
          charges: chargesController.text.trim().isNotEmpty ? double.parse(chargesController.text) : 0.0,)

    );
    if(result){
      Utils.successDialog(context, "Success!", "Successfully Added").then((value){
        if(value != null){
          Navigator.of(context).pop(true);
        }
      });
    }else{
      Utils.errorDialog(context, "Something went wrong!");
    }

  }

}