

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../UiUtil/customWidgets.dart';
import '../../../../models/response/FDCalculatorResponse.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Themes/colors.dart';




class FDCalculatorPage extends StatelessWidget {
  final FdCalculatorResponse fdCalculatorResponse;
  const FDCalculatorPage({required this.fdCalculatorResponse, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  fdItem(context);
  }

  Widget fdItem(context){
    return SizedBox(
      height: 400,
      child: Column(

        children: [
          gapH(25.h),
          Text("Fixed deposit calculator",   style: GoogleFonts.dmSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
           )
          ),
          gapH(20.h),
          Container(
            height: 260.h,
            color: AppColors.white,
            child: Container(
              padding: const EdgeInsets.all( 20.0),
              margin:  const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                  color: AppColors.whiteF4,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child:  Column(
                children: [
                  gapH(20.h),
                  Row(
                    children: [
                      Text("Amount to invest",   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),),
                      const Spacer(),
                      Text(currencyFormatter.format(double.parse(fdCalculatorResponse.tdAmount ?? "")),   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  gapH(10.h),
                  Row(
                    children: [
                      Text("Duration",   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),),
                      const Spacer(),
                      Text(fdCalculatorResponse.duration ?? "",   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  gapH(10.0),
                  Row(
                    children: [
                      Text("Total interest",   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),),
                      const Spacer(),
                      Text(currencyFormatter.format(double.parse(fdCalculatorResponse.totalInterest ?? "")),   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  gapH(10.0),
                  Row(
                    children: [
                      Text("Tax",   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),),
                      const Spacer(),
                      Text(currencyFormatter.format(double.parse(fdCalculatorResponse.taxAmount ?? "")),   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  gapH(10.0),
                  Row(
                    children: [
                      Text("Mature amount",   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),),
                      const Spacer(),
                      Text(currencyFormatter.format(double.parse(fdCalculatorResponse.matureAmount ?? "")),   style: GoogleFonts.dmSans(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  gapH(30.h),
                ],
              ),
            ),
          ),
          blueBtn(title: "Proceed to invest", tap: (){
            Navigator.pop(context, true);
          })
        ],
      ),
    );
  }
}
