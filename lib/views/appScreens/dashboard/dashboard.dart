import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/views/appScreens/dashboard/tranferScreens/otherBanksTransferView.dart';
import 'package:moneytronic/views/appScreens/dashboard/tranferScreens/specialAccountTransferView.dart';
import 'package:moneytronic/views/appScreens/dashboard/tranferScreens/transferFundScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../UiUtil/TransactionHistoryCard.dart';
import '../../../UiUtil/TransactionPin.dart';
import '../../../UiUtil/balance_and_account_details_widget.dart';
import '../../../UiUtil/bank_widget_details.dart';
import '../../../UiUtil/customDateRangePicker.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/protectAccountScreen.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../bloc/Dashboard/dashboard_bloc.dart';
import '../../../models/requests/TransactionHistoryRequest.dart';
import '../../../models/requests/TransactionPinRequest.dart';
import '../../../models/response/BeneficiaryResponse.dart';
import '../../../models/response/BillsResponse/BillerGroupsResponse.dart';
import '../../../models/response/BillsResponse/NetworkPlansResponse.dart';
import '../../../models/response/TransactionHistory.dart';
import '../../../models/response/UserAccountResponse.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Constants.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../../startScreen/login/loginFirstTime.dart';
import '../../startScreen/setSecurityQuestionsPage.dart';
import '../fixedDeposit/FDLandingPage.dart';
import '../history/transactionReceipt.dart';
import 'AirtimeScreen/AirtimePurchaseScreen.dart';
import 'DataScreens/dataPurchaseScreen.dart';
import 'billPaymentScreens/BillPaymentScreen.dart';


var hasSetPin = false;
List<UserAccount>? userAccounts;
List<BillerGroupsResponse> billerGroupList =[];
class DashBoardScreen extends StatefulWidget {

  const DashBoardScreen({super.key});
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();

}
List<SubscribedService>? networkProviders;
List<SubscribedService> airtimeProvidersList = [];
List<SubscribedService> dataProvidersList = [];

class _DashBoardScreenState extends State<DashBoardScreen> {
  final PageController pageController = PageController();
  late DashboardBloc bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(DashboardLoginEvents(loginRequest!));
      bloc.add(const DashboardBeneficiaryEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<DashboardBloc>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness:  Brightness.light
      ),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoginSuccessfulState){
            loginResponse = state.response;
            if (loginResponse?.registrationStatus == "02" && !hasSetPin) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Future.delayed(Duration.zero, () {
                  openBottomSheet(context, ProtectAccountScreen(
                      title: "Protect your account",
                      body: "You can now use your facial recognition to sign-in and complete transactions",
                      proceedTap: () {
                        Navigator.pop(context);
                        openPinScreen();
                      }), isDismissible: false);
                });
              });
            }
            if (loginResponse?.registrationStatus == "03" && !hasSetPin) {
              openBottomSheet(context, ProtectAccountScreen(title: "Protect your account", body:"Set your transaction pin",proceedTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder:  (context) => const SetSecurityQuestionsPage()));
              }), isDismissible: false);
            }
            bloc.add(const DashboardGetAccountsEvent());
          }
          if (state is DashboardAccountsState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              userAccounts = state.response;
              Future.delayed(Duration.zero, (){
                bloc.add(DashboardTransactionHistoryEvents(TransactionHistoryRequest(row: "5", accountNumber: userAccounts?[0].accountnumber ?? "")));
              });
            });
          }
          if(state is DashboardSetTransactionPinState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                Navigator.push(context, MaterialPageRoute(builder:  (context) => const SetSecurityQuestionsPage()));
                bloc.initial();
              });
            });
          }
          return AppUtils().loadingWidget2(
            context: context,
            isLoading: state is DashboardStateLoading,
            child: Scaffold(
              backgroundColor: AppColors.whiteFA,
              body: Column(children: [
                StreamBuilder<List<Beneficiary>>(
                    stream: bloc.beneficiaryListStream,
                    builder: (context, snapshot) {
                      return Container(
                        width: double.infinity,height:   (snapshot.hasData && snapshot.data!.isNotEmpty) ? 415.h : 315,
                        color: AppColors.moneyTronicsBlue,
                        child: Column(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 203.h,
                              child: StreamBuilder<List<UserAccount>>(
                                  stream: bloc.userAccountListSubject,
                                  builder: (context, snapshot) {
                                    return  snapshot.hasData ? PageView.builder(
                                      controller: pageController,
                                      padEnds: true,
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return BalanceAndAccountDetailsWidget(
                                          accountTitle: snapshot.data?[index].productName ?? "",
                                          accountNumber: snapshot.data?[index].accountnumber ?? "",
                                          balance: snapshot.data?[index].balance.toString() ?? "",
                                        );
                                      },
                                    ) : gapHeight(1.0);
                                  }
                              ),
                            ),
                            gapHeight(10.h),
                            (userAccounts ?? []).isNotEmpty ?
                            SmoothPageIndicator(
                              controller: pageController,
                              count: userAccounts?.length ?? 0,
                              effect: ExpandingDotsEffect(
                                dotWidth: 25.w,
                                dotHeight: 11.5.h,
                                radius: 10.h,
                                activeDotColor: AppColors.greenB1,
                                dotColor: AppColors.mistF4,
                                expansionFactor: 2,
                              ),
                            ): gapHeight(20.0),
                            gapHeight(20.h),
                            (snapshot.hasData && snapshot.data!.isNotEmpty) ?
                            Column(
                              children: [
                                Container(alignment: Alignment.centerLeft,padding: EdgeInsets.only(left: 16.w),
                                    child: ctmTxtGroteskMid("Quick transfers",AppColors.white,18.sp)),
                                gapHeight(20.h),

                                SizedBox(height: 57.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshot.data![index];
                                      return  GestureDetector(
                                        onTap: (){
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(builder: (context) =>
                                          //     const TransferFundScreen()));
                                          if (data.beneficiaryBankcode == Constants.cedarBankCode) {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) =>
                                                    SpecialAccountTransferView(beneficiary: data,)));

                                          }else{
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) =>
                                                    OtherBanksTransferView(beneficiary: data,)));

                                          }
                                        },
                                        child: BankWidgetWithDetails(
                                          name: data.beneficiaryFullName,
                                          bank: data.beneficiaryBank,
                                          accountNumber: data.beneficiaryAccount,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ) : gapHeight(1.0),
                            gapHeight(30.h),
                          ],),
                      );
                    }
                ),
                Expanded(child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(child: Column(children: [
                    gapHeight(24.h),
                    Align(alignment: Alignment.centerLeft,child:
                    ctmTxtGroteskMid("Quick actions",AppColors.black4D,18.sp)),
                    gapHeight(20.h),
                    Column(children: [
                      optionRow(
                        optionWidget("Transfer","assets/png/icons/transfer.png",(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                              const TransferFundScreen()));
                        }),
                        optionWidget("Bill payment","assets/png/icons/bills.png",(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                              const BillPaymentScreen()));
                        }),
                      ),
                      optionRow(
                        optionWidget("Airtime","assets/png/icons/mobile.png",(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                              const AirtimePurchaseScreen()));
                        }),
                        optionWidget("Data","assets/png/icons/global.png",(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                              const DataPurchaseScreen()));
                        }),
                      ),
                      // optionRow(
                      //   optionWidget("Scheduled transactions","assets/png/icons/card.png",(){
                      //   }),
                      //   optionWidget("Loan","assets/png/icons/empty-wallet.png",(){
                      //   }),
                      // ),
                      optionRow(
                        optionWidget("Account statement","assets/png/icons/bill.png",(){
                          openRequestAccountStatementCalendar(context, (result) {

                          });
                        }),
                        optionWidget("Fixed deposit","assets/png/icons/fixed_deposit.png",(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                              const FixedDepositLandingPage()));
                        }),
                      ),
                    ],),
                    gapHeight(20.h),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ctmTxtGroteskMid("Recent transactions",AppColors.black4D,18.sp),
                        ctmTxtGroteskReg("View all",AppColors.black4D,16.sp)
                      ],
                    ),
                    gapHeight(15.0),
                    StreamBuilder<List<TransactionHistoryResponse>>(
                        stream: bloc.transactionListStream,
                        builder: (context, snapshot) {
                          return (snapshot.hasData && snapshot.data!.isNotEmpty) ?SizedBox(
                            height: 200,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data![index];
                                  return TransactionHistoryCard (
                                    description: data.narration ?? "",
                                    time: data.trandate ?? "",
                                    amount: 'NGN ${data.amount}',
                                    isCredit: data.amount!.contains("-") ? false : true,
                                    tap: () {
                                      dismissibleBottomSheet(context, Receipt(response: data),  MediaQuery.of(context).size.height * 0.9);
                                    },
                                  );
                                }
                            ),
                          ):  Column(
                            children: [
                              gapH(20.0),
                              Center(
                                child:  ctmTxtGroteskMid("No transaction history",AppColors.black4D, 20.sp),
                              ),
                            ],
                          );
                        }
                    ),
                  ],),),
                )
                ),
              ],
              ),
            ),
          );
        },
      ),
    );
  }
  Padding optionRow(widget1,widget2) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget1,
          widget2
        ],),
    );
  }
  Widget optionWidget(title,image,tap) {
    return GestureDetector(
      onTap: tap,behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: 150.w,height: 42.h,
        child: Row(children: [
          Container(
            width: 38.h,height: 38.h,
            decoration: BoxDecoration(
                color: AppColors.moneyTronicsSkyBlue,
                borderRadius: BorderRadius.circular(15.r)
            ),
            child: Center(child: Image.asset(image,width: 18.w,height: 18.h,),),
          ),
          gapW(10.w),
          Expanded(child:
          ctmTxtGroteskMid(title,AppColors.black,15.sp,maxLines: 2))
        ],),
      ),
    );
  }
  void openPinScreen()async {
    var pin = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        TransactionPinScreen()));
    if (pin != null){
      hasSetPin = true;
      AppUtils.debug("pin entered $pin");
      bloc.add(DashboardSetTransactionPinEvent(TransactionPinRequest(
          accountnumber: userAccounts?[0].accountnumber ?? "",
          transactionpin: pin,
          renterTransactionpin: pin))
      );
    }
  }
  void openRequestAccountStatementCalendar(BuildContext context,
      Function(StartDateEndDate) completionHandler)async {
    StartDateEndDate? result = await showDialog(context: context,
        builder: (BuildContext context) {
          return const Dialog(insetPadding: EdgeInsets.symmetric(horizontal: 0),
              child: CustomDateRangePicker());
        });
    if (result != null){
      completionHandler(result);
      AppUtils.debug("start Date ${result.startDate}");
      AppUtils.debug("End Date ${result.endDate}");
    }
  }
}




