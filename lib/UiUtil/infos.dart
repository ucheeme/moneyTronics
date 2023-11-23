

import 'package:flutter/cupertino.dart';

import '../utils/appUtil.dart';
import '../views/appScreens/dashboard/dashboard.dart';
import 'accountAndBalanceWidgetTwo.dart';

List<Widget> accountWidget(){
  List<Widget> returnValue = [];
  userAccounts?.forEach((element) { 
    returnValue.add(  AccountAndBalanceWidgetTwo(
      accountTitle: element.productName ?? "",
      accountNumber: element.accountnumber ?? "",
      accountBalance: currencyFormatter.format(element.balance),),);
  });
  return returnValue;
}