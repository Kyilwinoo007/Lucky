class Constants {
  static const String WAVEMONEY = "Wave Money";
  static const String KBZPAY = "KBZ Pay";
  static const String CBPAY = "CB Pay";
  static const String TRUEMONEY = "True Money";
  static const TRANSFER = "TRANSFER";
  static const WITHDRAW = "WITHDRAW";

  static const String CASH = "cash";
  static const String EMONEY = "e-money";

  static const int InsertSuccessCode = 4;

  static const List<String> agentList = [WAVEMONEY, KBZPAY, CBPAY, TRUEMONEY];
  static const List<int> agentIdList = [WAVEMONEY_TYPE,KBZPAY_TYPE,CBPAY_TYPE,TRUEMONEY_TYPE];
  static const int WAVEMONEY_TYPE = 0;
  static const int KBZPAY_TYPE = 1;
  static const int CBPAY_TYPE = 2;
  static const int TRUEMONEY_TYPE = 3;


  static const List<int> transactionTypeList = [DEPOSITE_TYPE,WITHDRAW_TYPE,TRANSFER_TYPE];
  static const int DEPOSITE_TYPE = 0;
  static const int WITHDRAW_TYPE = 1;
  static const int TRANSFER_TYPE = 2;

  static const List<int> bankTransferList = [BANK_TRANSFER,BANK_RECEIVE];
  static const int BANK_TRANSFER = 0;
  static const int BANK_RECEIVE = 1;

  static const List<int> bankIdList = [KBZ,CB,AYARWADY,YOMA,AGD];
  static const int KBZ = 0;
  static const int CB = 1;
  static const int AYARWADY = 2;
  static const int YOMA = 3;
  static const int AGD = 4;


}