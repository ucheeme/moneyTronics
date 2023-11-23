import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/Themes/colors.dart';
import '../customWidgets.dart';
import '../textWidgets.dart';


class CustomAlertDialog extends StatelessWidget {
  final String body;
  final String proceedText;
  final String declineText;
  final Function() proceed;
  final Function() decline;
  bool showIcon;
  CustomAlertDialog({
    required this.showIcon, 
    required this.body, 
    required this. proceedText, 
    required this.declineText, 
    required this.proceed, 
    required this.decline, 
    Key? key
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: showIcon ? 250 : 200,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          showIcon ? SizedBox(
            width: 50,
            height: 55,
            child: Center(child: Image.asset("assets/png/icons/face_scan.png", width: 50, height: 50, color: AppColors.moneyTronicsBlue,)),
          ) : gapH(1.0),
          gapH(20.0),
          ctmTxtGroteskMid(body,
              AppColors.black33, 18.sp,maxLines: 2,textAlign: TextAlign.center, weight: FontWeight.w600),
          gapH(20.0),
          Row(
            children: [
              Expanded(
                child: blueBtn(title: proceedText, tap: proceed)
              ),
              gapW(10.0),
              Expanded(
                child: outlineBtn(title: declineText, tap: decline)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
