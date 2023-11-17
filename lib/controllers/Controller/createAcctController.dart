import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../cubits/createAcctCubit/create_acct_cubit.dart';

class CreateAcctController extends GetxController{
  String date = "";
  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  TextEditingController genderController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late CreateAcctCubit cubit;

}