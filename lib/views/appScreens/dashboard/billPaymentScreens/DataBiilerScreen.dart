

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../UiUtil/amountTextField.dart';
import '../../../../UiUtil/bottomsheet/selectTextBottomSheet.dart';
import '../../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/infos.dart';
import '../../../../UiUtil/normalTextFieldWithValidation.dart';
import '../../../../UiUtil/selectTextField.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../models/requests/BillMakeBillsPaymentRequest.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Themes/colors.dart';
import '../../../../bloc/BillBloc/bill_bloc.dart';
import '../../../../models/response/BillsResponse/BillerGroupsDetailsResponse.dart';
import '../../../../models/response/BillsResponse/BillerPackageResponse.dart';
import '../../../../models/response/BillsResponse/BillsCustomerLookUpResponse.dart';
import '../../../../utils/appUtil.dart';
import '../../../startScreen/login/loginFirstTime.dart';
import '../dashboard.dart';



class DataBillerScreen extends StatefulWidget {
  const DataBillerScreen({super.key});

  @override
  State<DataBillerScreen> createState() => _DataBillerScreenState();
}

class _DataBillerScreenState extends State<DataBillerScreen> {
  TextEditingController amountControl = TextEditingController();
  TextEditingController categoryControl = TextEditingController();
  TextEditingController packageControl = TextEditingController();
  TextEditingController customerIDControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  final PageController _sendingAccPageController = PageController();
  bool enableManualAmountInput = false;

  List<BillerGroupsDetailsResponse> billerGroupDetailsList = [];
  List<BillerPackageResponse> billerPackageList = [];
  BillerGroupsDetailsResponse? selectedCategory;
  BillerPackageResponse? selectedPackage;
  BillsCustomerLookUpResponse? receivedCustomerLookUp;
  bool customerLookedUp = false;
  int _currentSendingAccPageIndex = 0;
  late BillBloc bloc;
  @override
  void dispose() {
    _sendingAccPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<BillBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<BillBloc, BillState>(
          builder: (context, state) {
            if (state is BillStateError2){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Future.delayed(Duration.zero, (){
                  AppUtils.showSnack(state.errorResponse.result?.message ?? "", context);
                  bloc.initial();
                });
              });
            }
            if (state is BillStateError){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Future.delayed(Duration.zero, (){
                  AppUtils.showSnack(state.errorResponse.result?.message ?? "", context);
                  bloc.initial();
                });
              });
            }
            if (state is BillGetBillerGroupsDetailsSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                billerGroupDetailsList = [];
                billerGroupDetailsList = state.response;
                Future.delayed(Duration.zero, () {
                  _selectCategory(billerGroupDetailsList);
                });
              });
              bloc.initial();
            }
            if (state is BillGetBillerPackageSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                billerPackageList = state.response.where((element) => element.amount != null).toList();
                Future.delayed(Duration.zero, () {
                  _selectPackage(billerPackageList);
                });
              });
              bloc.initial();
            }
            if (state is BillGetBillerCustomerLookUPSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                receivedCustomerLookUp = state.response;
                customerLookedUp = true;
              });
              bloc.initial();
            }
            if (state is BillMakeBillsPaymentSuccessState){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Future.delayed(Duration.zero, (){
                  nonDismissibleBottomSheet(context,
                      SimpleSuccessAlertBottomSheet(
                          isSuccessful: true,
                          type: "Data Payment Successful",
                          description: "We’ve completed your transfer, You will be notified shortly",
                          accountBtn: "Close",
                          returnTap: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }));
                  bloc.initial();
                });
              });
            }
          return AppUtils().loadingWidget2(
            context: context,
            isLoading: state is BillStateLoading,
            child: Scaffold(
              backgroundColor:AppColors.whiteFA,
                bottomSheet: SizedBox(
                  height: 100.0,
                  child: Center (
                    child: customerIDControl.text.isNotEmpty && selectedPackage != null ?
                    blueBtn(
                        title: 'Proceed',
                        isEnabled: true,
                        tap: () {

                            openPinScreen(context, (pin) {
                              AppUtils.debug("my pin $pin");
                              bloc.add(BillMakeBillsPaymentEvents(request: BillMakeBillsPaymentRequest(
                                  customerId: customerIDControl.text,
                                  packageSlug: selectedPackage?.slug??'',
                                  channel: "Mobile",
                                  customerName: "",
                                  phoneNumber: customerIDControl.text??'',
                                  email: loginResponse?.email??"",
                                  accountNumber:  userAccounts![_currentSendingAccPageIndex].accountnumber ??'',
                                  amount: double.parse(amountControl.text.replaceAll(",", "")),
                                  transactionPin: pin,
                                  otpCode: ""))
                              );
                            });

                        }):disabledBtn(title: "Proceed"),),
                ),
              body: Column(
                children: [
                  appBarBackAndTxt(title: "Data payment",
                      backTap: (){Navigator.pop(context);}),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                      selectAccountColumn(
                          title: "Select sending account",
                          pageView: SizedBox(width: double.infinity,height: 100.h,
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: _sendingAccPageController,
                              onPageChanged: (int page) {
                                setState(() {
                                  _currentSendingAccPageIndex =  page;}
                                );
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
                      GestureDetector(
                        onTap: (){
                          if(billerGroupDetailsList.isNotEmpty){
                            _selectCategory(billerGroupDetailsList);
                          }else{
                            bloc.add(BillGetBillerGroupsDetailsEvents(billerId: 3));
                          }

                        },
                        child: Padding( padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SelectTextField(
                              labelText: "Select Category",
                              controller: categoryControl,
                              onChange: (val){}),
                        ),
                      ),
                      gapH(20.h),
                      GestureDetector(
                        onTap: (){
                          if(selectedCategory!= null){
                            if(billerPackageList.isNotEmpty){
                            _selectPackage(billerPackageList);
                            }else{
                              bloc.add(BillGetBillerPackageEvents(categorySlug: selectedCategory?.slug ??''));
                            }
                          }else{
                            AppUtils.showSnack("Select category", context);
                          }
                        },
                        child: Padding( padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SelectTextField(
                              labelText: "Select package",
                              controller: packageControl,
                              onChange: (val){}),
                        ),
                      ),
                      gapH(20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:16.w),
                        child: AmountTextField(
                          enabled: enableManualAmountInput,
                          labelText: 'Enter amount',
                          inputType: TextInputType.number,
                          controller: amountControl,
                          onChange: (val) { setState(() {});  },
                        ),
                      ),
                      Visibility(visible: selectedPackage!=null?true:false,
                          child:
                          Column(children: [
                            gapH(20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal:16.w),
                              child: NormalTextFieldWithValidation(
                                labelText: 'Enter phone number',
                                inputType: TextInputType.text,
                                controller: customerIDControl,
                                onChange: (val){
                                  setState(() {});
                                },
                              ),
                            ),
                          ],) ),
                      gapH(200.h),
                    ],),
                  ),
                  gapH(40.h),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  _selectCategory(List<BillerGroupsDetailsResponse> categoryList)async{
    var result =  await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child:  SelectBillGategoryBottomSheet(
            titleText: "Select data plan",
            items: categoryList,
            height: 750.h,),
        )
    );
    if(result != null){
      setState(() {
        billerPackageList = [];
        selectedPackage = null;
        enableManualAmountInput = false;
        amountControl.clear();
        packageControl.clear();
        customerLookedUp = false;
        receivedCustomerLookUp = null;
        customerIDControl.clear();


        selectedCategory = result;
        categoryControl.text = selectedCategory?.name ??'';
      });
    }
  }
  _selectPackage(List<BillerPackageResponse> packageList)async{
    var result =  await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child:  SelectBillPackageBottomSheet(
            titleText: "Select ${selectedCategory?.name??''} package",
            items: packageList,
            height: 800.h,),
        )
    );
    if(result != null){
      setState(() {
        receivedCustomerLookUp = null;
        amountControl.clear();
        customerIDControl.clear();
        customerLookedUp = false;

        selectedPackage = result;
        packageControl.text = selectedPackage?.name ??'';
        if(selectedPackage?.amount != null){
          amountControl.text = selectedPackage?.amount.toString()?? '';
          enableManualAmountInput = false;
        }else{
          amountControl.text = "";
          enableManualAmountInput = true;
        }
      });
    }
  }

}
Row twoTxt({required String firstTask,required String secondTask}) {
  return Row(crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ctmTxtGroteskReg(firstTask,AppColors.black66,16.sp,maxLines: 2),
      const Spacer(),
      ctmTxtGroteskMid(secondTask,AppColors.black,16.sp,weight: FontWeight.w600,maxLines: 2),
    ],);
}

