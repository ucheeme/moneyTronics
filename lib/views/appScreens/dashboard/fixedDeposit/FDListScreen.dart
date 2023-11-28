

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/infos.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../bloc/FixedDepositCalculator/fixed_deposit_calculator_bloc.dart';
import '../../../../models/response/FixedDepositListResponse.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Themes/colors.dart';
import 'FDSelectedItemPage.dart';



class FDListPage extends StatefulWidget {
  const FDListPage({Key? key}) : super(key: key);

  @override
  State<FDListPage> createState() => _FDListPageState();
}

class _FDListPageState extends State<FDListPage> {
  late FixedDepositCalculatorBloc bloc;
  final PageController _sendingAccPageController = PageController();
  int _currentSendingAccPageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(const FDListEvents());
    });

  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<FixedDepositCalculatorBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<FixedDepositCalculatorBloc, FixedDepositCalculatorState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor:AppColors.whiteFA,
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  selectAccountColumn(
                      title: "Select sending account",
                      pageView: SizedBox(width: double.infinity,height: 100.h,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _sendingAccPageController,
                          onPageChanged: (int page) {
                            setState(() {_currentSendingAccPageIndex = page;});
                          },
                          itemCount: accountWidget().length,
                          itemBuilder: (context, index) {
                            return accountWidget()[index];
                          },
                        ),
                      ),
                      pageIndicator: SmoothPageIndicator(
                        controller: _sendingAccPageController,
                        count: accountWidget().length,
                        effect: customIndicatorEffect(),
                      )
                  ),
                  gapH(30.h),
                  StreamBuilder<List<FixedDepositListResponse>>(
                      stream: bloc.fdListSubject,
                      builder: (context, snapshot) {
                        return (snapshot.hasData && snapshot.data!.isNotEmpty) ? SizedBox(
                          height: 400.h,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data![index];
                                return fdItem(() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  FDSelectedItemPage(fd: data,)));
                                }, data,);
                              }
                          ),
                        ):  Column(
                          children: [
                            gapH(10.0),
                            Image.asset("assets/png/images/empty_state.png", height: 200, width: 200,),
                            Center(
                              child:  ctmTxtGroteskMid("No fixed deposit",AppColors.black4D, 20.sp),
                            ),
                          ],
                        );
                      }
                  ),
                ],
              ),
            ),
          );},),
    );
  }

  Widget fdItem(onTap, FixedDepositListResponse fd){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all( 20.0),
        margin:  const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child:  Column(
          children: [
            Row(
              children: [
                Text(fd.product,   style: GoogleFonts.dmSans(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,

                ),),
                const Spacer(),
                const Icon(Icons.arrow_forward)
              ],
            ),
            gapH(10.h),
            Row(
              children: [
                Text("Amount invested",   style: GoogleFonts.dmSans(
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
            // Container(
            //   height: 50,
            //   margin: const EdgeInsets.symmetric(vertical: 20),
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //   decoration: const BoxDecoration(
            //       color: AppColors.greenB1,
            //       borderRadius: BorderRadius.all(Radius.circular(10))
            //   ),
            //   child: Row(
            //     children: [
            //       Text("Duration",   style: GoogleFonts.dmSans(
            //         color: Colors.black,
            //         fontSize: 15,
            //         fontWeight: FontWeight.normal,
            //       ),),
            //       const Spacer(),
            //       Text("31 Months",   style: GoogleFonts.dmSans(
            //         color: Colors.black,
            //         fontSize: 15,
            //         fontWeight: FontWeight.normal,
            //       ),),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
