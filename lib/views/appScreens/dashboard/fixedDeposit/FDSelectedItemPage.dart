


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../Utils/appUtil.dart';
import '../../../../bloc/FixedDepositCalculator/fixed_deposit_calculator_bloc.dart';
import '../../../../models/requests/FixedDepositLiquidationRequest.dart';
import '../../../../models/response/FixedDepositListResponse.dart';
import '../../../../utils/constants/Themes/colors.dart';



class FDSelectedItemPage extends StatefulWidget {
  final FixedDepositListResponse fd;
  const FDSelectedItemPage({required this.fd, Key? key}) : super(key: key);

  @override
  State<FDSelectedItemPage> createState() => _FDSelectedItemPageState();
}

class _FDSelectedItemPageState extends State<FDSelectedItemPage> {
  late FixedDepositListResponse fd;
  late FixedDepositCalculatorBloc bloc;
  @override
  void initState() {
    fd = widget.fd;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<FixedDepositCalculatorBloc>();
    return BlocBuilder<FixedDepositCalculatorBloc, FixedDepositCalculatorState>(
      builder: (context, state) {
        if (state is FDSummaryResponseState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              bloc.showLiquidationConfirmation(context, state.response, FixedDepositLiquidationRequest(accountnumber: fd.tdAccountNo, settlementAccount: fd.settlementAcctNo));
              bloc.initial();
            });
          });
        }
        if (state is FDSummaryLiquidationState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              nonDismissibleBottomSheet(context,
                  SimpleSuccessAlertBottomSheet(
                      isSuccessful: true, type: "Request Successful",
                      description: "Fixed deposit liquidation in progress",
                      accountBtn: "Close",
                      returnTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }));
            });
            bloc.initial();
          });
        }
        return AppUtils().loadingWidget2(
          context: context,
          isLoading: state is FDLoadingState,
          child: Scaffold(
              backgroundColor: AppColors.whiteF4,
              body: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: appBarBackAndTxt(
                          title: "Fixed deposit",
                          backTap: (){
                            Navigator.pop(context);
                          }),
                    ),
                    gapH(20.h),
                    fdItem()
                  ]
              )
          ),
        );
      },
    );
  }
  Widget fdItem(){
    return Container(
      padding: const EdgeInsets.all( 20.0),
      margin:  const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child:  Column (
        children: [
          Row(
            children: [
              Text("Fixed deposit",   style: GoogleFonts.dmSans(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              const Spacer(),
            ],
          ),
          gapH(10.h),
          Row(
            children: [
              Text("Product",   style: GoogleFonts.dmSans(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
              const Spacer(),
              Text(fd.product,   style: GoogleFonts.dmSans(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
            ],
          ),
          gapH(10.h),
          Row(
            children: [
              Text("Amount",   style: GoogleFonts.dmSans(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
              const Spacer(),
              Text(currencyFormatter.format(fd.tdAmount),   style: GoogleFonts.dmSans(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
            ],
          ),
          gapH(10.h),
          Row(
            children: [
              Text("Expected date",   style: GoogleFonts.dmSans(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
              const Spacer(),
              Text(fd.maturityDate,   style: GoogleFonts.dmSans(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
            ],
          ),
          gapH(10.h),
          Row(
            children: [
              Text("Request date",   style: GoogleFonts.dmSans(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
              const Spacer(),
              Text(fd.startDate,   style: GoogleFonts.dmSans(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal,
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
              Text(fd.tdDuration,   style: GoogleFonts.dmSans(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
            ],
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: const BoxDecoration(
                color: AppColors.greenB1,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              children: [
                Text("Expected mature amount",   style: GoogleFonts.dmSans(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
                const Spacer(),
                Text("NGN ${fd.matureAmount}",   style: GoogleFonts.dmSans(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
        //  greenBtn(title: 'Liquidate funds',isEnabled: true, tap: () {})
        ],
      ),
    );
  }
}
