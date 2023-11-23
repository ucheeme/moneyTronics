import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/views/appScreens/history/transactionReceipt.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../UiUtil/TransactionHistoryCard.dart';
import '../../../UiUtil/customDateRangePicker.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/infos.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../bloc/Dashboard/dashboard_bloc.dart';
import '../../../models/requests/TransactionHistoryRequest.dart';
import '../../../models/response/TransactionHistory.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../dashboard/dashboard.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final PageController _accPageController = PageController();
  int selectedOption = 0;
  late DashboardBloc bloc;
  void _handleOptionChange(int value) {
    setState(() {
      selectedOption = value;
    });
    if(value == 4){
      _selectFilteredDate(context);
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(DashboardTransactionHistoryEvents(TransactionHistoryRequest(row: "100", accountNumber: userAccounts?[0].accountnumber ?? "")));
    });
  }
  @override
  void dispose() {
    _accPageController .dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<DashboardBloc>();
    return darkStatusBar(
        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.whiteFA,
              body:  Column(children: [
                appBarTxtOnly(title: "Transaction history",),
                Container(
                  padding: screenPadding(),
                  color: AppColors.white,
                  child: Column(children: [
                    gapH(18.h),
                    SizedBox(width: double.infinity,height: 100.h,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _accPageController,
                        onPageChanged: (int page) {
                          bloc.add(DashboardTransactionHistoryEvents(TransactionHistoryRequest(row: "100", accountNumber: userAccounts?[page].accountnumber ?? "")));
                        },
                        itemCount: accountWidget().length,
                        itemBuilder: (context, index) {
                          return accountWidget()[index];
                        },
                      ),
                    ),
                    gapHeight(25.h),
                    SmoothPageIndicator(
                      controller: _accPageController,
                      count: accountWidget().length,
                      effect: customIndicatorEffect(),
                    ),
                    gapH(25.h),
                  ],),
                ),
                // Column(children: [
                //   gapH(20.h),
                //   Container(alignment: Alignment.centerLeft,padding: screenPadding(),
                //       child: ctmTxtGroteskMid("Showing all last transactions today",AppColors.black4D, 18.sp)),
                //   gapH(25.h),
                //   SizedBox(width: double.infinity, child: SingleChildScrollView(
                //
                //     scrollDirection: Axis.horizontal,
                //     child: Row(mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         gapW(7.5.w),
                //         OptionButton(0, 'Today', selectedOption, _handleOptionChange),
                //         OptionButton(1, 'Yesterday', selectedOption, _handleOptionChange),
                //         OptionButton(2, 'Last week', selectedOption, _handleOptionChange),
                //         OptionButton(3, 'Last month', selectedOption, _handleOptionChange),
                //         OptionButton(4, 'Filter', selectedOption, _handleOptionChange),
                //       ],),
                //   ),
                //   ),
                // ],
                // ),
                // Center(
                //   child:  ctmTxtGroteskMid("No transaction history",AppColors.black4D, 20.sp),
                // ),
                gapH(10.0),
                StreamBuilder<List<TransactionHistoryResponse>>(
                    stream: bloc.transactionListStream,
                    builder: (context, snapshot) {
                      return (snapshot.hasData && snapshot.data!.isNotEmpty) ?Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data![index];
                              return TransactionHistoryCard(
                                description: data.narration ?? "",
                                time: data.trandate ?? "",
                                amount: 'NGN ${data.amount}',
                                isCredit: data.amount!.contains("-") ? false : true,
                                tap: () {
                                  dismissibleBottomSheet(context, Receipt(response: data),  MediaQuery.of(context).size.height * 0.9);
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Receipt(response: data)));
                                },);
                            }
                        ),
                      ):  Column(
                        children: [
                          gapH(50.0),
                          Image.asset("assets/png/images/empty_state.png", height: 200, width: 200,),
                          Center(
                            child:  ctmTxtGroteskMid("No transaction history",AppColors.black4D, 20.sp),
                          ),
                        ],
                      );
                    }
                ),
                gapH(5.h),
              ],),
            );
          },
        )
    );
  }
  _selectFilteredDate(BuildContext context) async {
    var date = await showDialog(context: context,
        builder: (BuildContext context) {
          return const Dialog(insetPadding: EdgeInsets.symmetric(horizontal: 10),
              child: CustomDateRangePicker());
        });
    if(date is String){
      if(date.isNotEmpty){
        setState(() {
          //dateControl.text = date;
        });}
    }
    else{

    }
  }
}


class OptionButton extends StatelessWidget {
  final int value;
  final String label;
  final int selectedOption;
  final ValueChanged<int> onChanged;

  const OptionButton(this.value, this.label, this.selectedOption, this.onChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
          height: 39.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          margin: EdgeInsets.symmetric(horizontal: 7.5.w),
          decoration: BoxDecoration(
            color: selectedOption == value ? AppColors.greenEB : AppColors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
                color: selectedOption == value ? AppColors.moneyTronicsSkyBlue : AppColors.moneyTronicsSkyBlue,
                width: selectedOption == value ? 0.5.r : 0.2.r
            ),
          ),
          child:
          Center(child:
          label =="Filter"?
          Image.asset("assets/png/icons/calendar.png",
            color: selectedOption == value ? AppColors.black:
            AppColors.black4D,width: 18.w,height: 18.h,
          )
              :
          ctmTxtGroteskReg(label, selectedOption == value ? AppColors.black:
          AppColors.black4D,16.sp))
      ),
    );
  }
}
