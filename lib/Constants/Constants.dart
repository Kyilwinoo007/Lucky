import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:lucky/UI/Widgets/ListItem.dart';

class Constants {
  static const String WAVEMONEY = "Wave Money";
  static const String KBZPAY = "KBZ Pay";
  static const String CBPAY = "CB Pay";
  static const String TRUEMONEY = "True Money";

  static const String CASH = "cash";
  static const String EMONEY = "e-money";


  static const List<String> agentList = [WAVEMONEY, KBZPAY, CBPAY, TRUEMONEY];
  static const List<int> agentIdList = [WAVEMONEY_TYPE,KBZPAY_TYPE,CBPAY_TYPE,TRUEMONEY_TYPE];
  static const int WAVEMONEY_TYPE = 0;
  static const int KBZPAY_TYPE = 1;
  static const int CBPAY_TYPE = 2;
  static const int TRUEMONEY_TYPE = 3;


  //transactions type
  static const List<String> transactionTypeList = [DEPOSITE_TYPE,WITHDRAW_TYPE,TRANSFER_TYPE];
  static const String DEPOSITE_TYPE = "Deposit";
  static const String WITHDRAW_TYPE = "Withdraw";
  static const String TRANSFER_TYPE = "Transfer";
  static const String BILL_TOP_UP = "Bill Top Up";
  static const String BANK_TRANSFER_TYPE = "Bank Transfer";
  static const String BANK_RECEIVE_TYPE = "Bank Receive";
  static const String PARTNER_TRANSFER_TYPE = "Partner Transfer";
  static const String PARTNER_RECEIVE_TYPE = "Partner Receive";

  static const List<String> bankTransferTypeList = [BANK_TRANSFER_TYPE,BANK_RECEIVE_TYPE];
  static const List<String> partnerTransferTypeList = [PARTNER_TRANSFER_TYPE,PARTNER_RECEIVE_TYPE];

  //TransferorType
  static const String CustomerType = "Customer";
  static const String BankType = "Bank";
  static const String PartnerType = "Partner";

  static const List<String> bankList = [KBZ,CB,AYARWADY,YOMA,AGD];
  static const String KBZ = "KBZ";
  static const String CB = "CB";
  static const String AYARWADY = "Ayarwady";
  static const String YOMA = "Yoma";
  static const String AGD = "AGD";

  static const String firestore_collection = "lucky_users";

  static String userInfo = "userInfo";

  static int maxUser = 2;
  static String AdminUserType = "admin";
  static String MoneyInputAdd ="Add";
  static String MoneyInputReduce ="Reduce";

  static List<ListItem<BluetoothDevice>> lstDevices = [];


}