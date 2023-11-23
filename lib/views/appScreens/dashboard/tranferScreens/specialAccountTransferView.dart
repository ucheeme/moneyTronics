

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/bloc/TransactionBloc/transaction_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../UiUtil/amountTextField.dart';
import '../../../../UiUtil/customTextfield.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/infos.dart';
import '../../../../UiUtil/normalTextFieldWithValidation.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../UiUtil/toggleSwitch.dart';
import '../../../../bloc/TransactionBloc/TransactionFormsValidation.dart';


import '../../../../models/requests/AccountVerification.dart';
import '../../../../models/response/BeneficiaryResponse.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Constants.dart';
import '../../../../utils/constants/Themes/colors.dart';
import '../Beneficiary/BeneficiaryScreen.dart';
import '../dashboard.dart';



class SpecialAccountTransferView extends StatefulWidget {
  Beneficiary? beneficiary;
   SpecialAccountTransferView({this.beneficiary, super.key});
  @override
  State<SpecialAccountTransferView> createState() => _SpecialAccountTransferViewState();
}

class _SpecialAccountTransferViewState extends State<SpecialAccountTransferView> {
  TextEditingController accNumberControl = TextEditingController();
  TextEditingController amountControl = TextEditingController();
  TextEditingController narrationControl = TextEditingController();
  TextEditingController beneficiaryControl = TextEditingController();
  final PageController _sendingAccPageController = PageController();
  bool saveBeneficiary = false;
  late TransactionBloc bloc;
  var recipientName = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.formValidation = TransactionFormValidation();
      bloc.formValidation.setBankCode(Constants.cedarBankCode);
      bloc.formValidation.setDebitAccount(userAccounts?[0].accountnumber ?? "");
      bloc.formValidation.setBankName("Cedar");
      bloc.formValidation.setSelectedAccount(userAccounts![0]);
      if (widget.beneficiary != null){
        var value = widget.beneficiary!;
        bloc.add(TransactionAccountVerificationEvent(AccountVerification(accountNumber: value.beneficiaryAccount, bankCode: value.beneficiaryBankcode)));
      }
    });
  }
  @override
  void dispose() {
    _sendingAccPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<TransactionBloc>();
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionPostState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              if (saveBeneficiary){
                bloc.add(TransactionSaveBeneficiaryEvent(bloc.formValidation.createBeneficiaryRequest()));
              }
              bloc.receiptBottomSheet(context);
            });
            bloc.initial();
          });
        }
        if (state is TransactionAccountVerificationState){
          var value = state.response;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              recipientName = state.response.finedgeBankVerification?.acctName ?? "";
              bloc.formValidation.setRecipientAccount(value.finedgeBankVerification?.accountNumber ?? "");
              accNumberControl.text = value.finedgeBankVerification?.accountNumber ?? "";
              bloc.formValidation.setBankCode(Constants.cedarBankCode);
              bloc.formValidation.setRecipientName(value.finedgeBankVerification?.acctName ?? "");
              bloc.formValidation.setBankName("Cedar");
              bloc.initial();
            });
            bloc.initial();
          });
        }
        if (state is TransactionStateError){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack(state.errorResponse.result!.message ?? "error occurred", context);
            });
            bloc.initial();
          }
          );
        }
        return  AppUtils().loadingWidget2(
          context: context,
          isLoading: state is TransactionStateLoading,
          child: Scaffold(
            backgroundColor:AppColors.whiteFA,
            body: SizedBox(
              child: Column(
                children: [
                  widget.beneficiary != null ? appBarBackAndTxt(title: "Fixed deposit",
                      backTap: (){Navigator.pop(context);}): gapH(1.0),
                  Expanded(
                    child: SingleChildScrollView( keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(children: [
                        selectAccountColumn(
                            title: "Select sending account",
                            pageView: SizedBox(width: double.infinity,height: 100.h,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _sendingAccPageController,
                                onPageChanged: (int page) {
                                  bloc.formValidation.setSelectedAccount(userAccounts![page]);
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: GestureDetector(
                              onTap: () async{
                                await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                     BeneficiaryListScreen(isSelectible: true,isFinedge: true,))
                                ).then((value){
                                  if (value is Beneficiary){
                                    bloc.add(TransactionAccountVerificationEvent(AccountVerification(accountNumber: value.beneficiaryAccount, bankCode: value.beneficiaryBankcode)));
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: AppColors.greenEB,
                                ),
                                child: ctmTxtGroteskMid(
                                    "Select beneficiary",
                                    AppColors.moneyTronicsBlue, 15.sp,maxLines: 1,textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                        gapH(10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:16.w),
                          child:   StreamBuilder<Object>(
                              stream: bloc.formValidation.recipientAccount,
                              builder: (context, snapshot) {
                                return CustomTextFieldWithValidation(
                                  controller:accNumberControl, title: "Recipient account",
                                  details: recipientName, inputType:TextInputType.number,
                                  onChange: (v){
                                    bloc.formValidation.setRecipientAccount(v);
                                    if (v.length == 10){
                                      bloc.add(TransactionAccountVerificationEvent(AccountVerification(accountNumber: v, bankCode: "999408")));
                                    }else{
                                      recipientName = "";
                                    }
                                  },
                                  error: snapshot.hasError ? snapshot.error.toString() : "",
                                );
                              }
                          ),
                        ),
                        gapH(30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:16.w),
                          child: StreamBuilder<Object>(
                              stream: bloc.formValidation.amount,
                              builder: (context, snapshot) {
                                return AmountTextField(
                                  labelText: 'Enter amount',
                                  inputType: TextInputType.number,
                                  controller: amountControl,
                                  onChange: bloc.formValidation.setAmount,
                                );
                              }
                          ),
                        ),
                        gapH(30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:16.w),
                          child: StreamBuilder<String>(
                              stream: bloc.formValidation.narration,
                              builder: (context, snapshot) {
                                return NormalTextFieldWithValidation(
                                  labelText: 'Enter narration',
                                  inputType: TextInputType.text,
                                  controller: narrationControl,
                                  onChange: bloc.formValidation.setNarration,
                                );
                              }
                          ),
                        ),
                        gapH(30.h),
                        Container(alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16.w),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Save as beneficiary",AppColors.black,18.sp),
                              gapH(8.h),
                              GestureDetector(onTap: (){
                                setState(() {
                                  saveBeneficiary = !saveBeneficiary;
                                });
                              },
                                  child: CustomToggleSwitch(value: saveBeneficiary,)),
                            ],
                          ),
                        ),
                        gapH(100.h),
                      ],),
                    ),
                  ),
                  gapH(10.h),
                  SizedBox(
                    height: 100.0,
                    child: Center (
                      child: StreamBuilder<Object>(
                          stream: bloc.formValidation.validateTransferForm,
                          builder: (context, snapshot) {
                            return (snapshot.data == true) ? blueBtn(
                                title: 'Proceed',
                                isEnabled: snapshot.hasData,
                                tap: ()  {
                                  bloc.showTransferConfirmation(context, "2");
                                }) : disabledBtn(title: 'Proceed');
                          }
                      ),
                    ),
                  ),
                  gapH(40.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
