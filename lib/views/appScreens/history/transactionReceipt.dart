import 'dart:typed_data';



import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import '../../../models/response/TransactionHistory.dart';

class Receipt extends StatelessWidget {
  final GlobalKey _globalKey =  GlobalKey();
  final TransactionHistoryResponse response;
  Receipt({required this.response, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


