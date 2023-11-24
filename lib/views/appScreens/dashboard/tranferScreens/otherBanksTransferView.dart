

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../../../../UiUtil/amountTextField.dart';
import '../../../../UiUtil/bottomsheet/selectBankBottomSheet.dart';
import '../../../../UiUtil/customTextfield.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/infos.dart';
import '../../../../UiUtil/normalTextFieldWithValidation.dart';
import '../../../../UiUtil/selectTextField.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../UiUtil/toggleSwitch.dart';
import '../../../../bloc/TransactionBloc/TransactionFormsValidation.dart';
import '../../../../bloc/TransactionBloc/transaction_bloc.dart';
import '../../../../models/requests/AccountVerification.dart';
import '../../../../models/response/Bank.dart';
import '../../../../models/response/BeneficiaryResponse.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Themes/colors.dart';
import '../Beneficiary/BeneficiaryScreen.dart';
import '../dashboard.dart';



class OtherBanksTransferView extends StatefulWidget {
  Beneficiary? beneficiary;
   OtherBanksTransferView({this.beneficiary, super.key});
  @override
  State<OtherBanksTransferView> createState() => _OtherBanksTransferViewState();
}

class _OtherBanksTransferViewState extends State<OtherBanksTransferView> {
  TextEditingController accNumberControl = TextEditingController();
  TextEditingController amountControl = TextEditingController();
  TextEditingController narrationControl = TextEditingController();
  TextEditingController beneficiaryControl = TextEditingController();
  TextEditingController receivingBankControl = TextEditingController();
  final PageController _sendingAccPageController = PageController();
  late TransactionBloc bloc;
  var recipientName = "";
  Bank? selectedBank;
  bool saveBeneficiary = false;

  @override
  void dispose() {
    _sendingAccPageController.dispose();
    super.dispose();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(const TransactionBankEvent());
      bloc.formValidation = TransactionFormValidation();
      bloc.formValidation.setSelectedAccount(userAccounts![0]);
      if (widget.beneficiary != null){
        var value = widget.beneficiary!;
        selectedBank = Bank(bankname: value.beneficiaryBank, bankCode: value.beneficiaryBankcode);
        receivingBankControl.text = selectedBank?.bankname ?? "";
        bloc.formValidation.setBankCode(selectedBank?.bankCode ?? "");
        bloc.formValidation.setBankName(selectedBank?.bankname ?? "");
        bloc.add(TransactionAccountVerificationEvent(AccountVerification(accountNumber: value.beneficiaryAccount, bankCode: value.beneficiaryBankcode)));

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<TransactionBloc>();
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionPostState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              bloc.receiptBottomSheet(context);
              if (saveBeneficiary){
                bloc.add(TransactionSaveBeneficiaryEvent(bloc.formValidation.createBeneficiaryRequest()));
              }else {
                bloc.initial();
              }
            });
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
        if (state is TransactionClearBankState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              recipientName = "";
              bloc.formValidation.setBankCode(selectedBank?.bankCode ?? "");
              bloc.formValidation.setRecipientName("");
              bloc.formValidation.setBankName(selectedBank?.bankname ?? "");
              bloc.initial();
            });
            bloc.initial();
           }
          );
        }
        if (state is TransactionAccountVerificationState){
          var value = state.response;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              recipientName = state.response.otherBankVerification?.accountName ?? "";
              bloc.formValidation.setRecipientAccount(value.otherBankVerification?.accountNumber ?? "");
              accNumberControl.text = value.otherBankVerification?.accountNumber ?? "";

              bloc.formValidation.setRecipientName(value.otherBankVerification?.accountName ?? "");
              bloc.formValidation.setBankCode(selectedBank?.bankCode ?? "");
              bloc.formValidation.setBankName(selectedBank?.bankname ?? "");
              bloc.initial();
            });
            bloc.initial();
          });
        }
        return  AppUtils().loadingWidget2(
          context: context,
          isLoading: state is TransactionStateLoading,
          child: Scaffold(
            backgroundColor: AppColors.whiteFA,
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
                        gapH(10.h),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: GestureDetector(
                              onTap: () async{
                                await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                     BeneficiaryListScreen(isSelectible: true, isFinedge: false))
                                ).then((value){
                                  if (value is Beneficiary){
                                    selectedBank = Bank(bankname: value.beneficiaryBank, bankCode: value.beneficiaryBankcode);
                                    receivingBankControl.text = selectedBank?.bankname ?? "";
                                    bloc.formValidation.setBankCode(selectedBank?.bankCode ?? "");
                                    bloc.formValidation.setBankName(selectedBank?.bankname ?? "");
                                    bloc.add(TransactionAccountVerificationEvent(AccountVerification(accountNumber: value.beneficiaryAccount, bankCode: value.beneficiaryBankcode)));
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: AppColors.moneyTronicsSkyBlue,
                                ),
                                child: ctmTxtGroteskMid(
                                    "Select beneficiary",
                                    AppColors.moneyTronicsBlue, 15.sp,maxLines: 1,textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                        gapH(20.h),
                        GestureDetector(
                          onTap: (){
                            _selectBank();
                          },
                          child: Padding( padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SelectTextField(
                                labelText: "Select receiving bank",
                                controller: receivingBankControl,
                                onChange: (val){
                                }),
                          ),
                        ),
                       gapH(20.h),
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
                                      if (selectedBank != null) {
                                        bloc.add(
                                            TransactionAccountVerificationEvent(
                                                AccountVerification(
                                                    accountNumber: v,
                                                    bankCode: selectedBank?.bankCode ?? "")));
                                      }
                                    }else{
                                      recipientName = "";
                                    }
                                  },
                                  error: snapshot.hasError ? snapshot.error.toString() : "",
                                );
                              }
                          ),
                        ),
                      //  gapH(30.h),
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
                        gapH(20.h),
                        Container(alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16.w),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid(
                                  "Save as beneficiary", AppColors.black, 18.sp),
                              gapH(8.h),
                              GestureDetector(onTap: () {
                                setState(() {
                                  saveBeneficiary = !saveBeneficiary;
                                });
                              }, child: CustomToggleSwitch(value: saveBeneficiary,)),
                            ],
                          ),
                        ),
                        gapH(50.h),
                      ],),
                    ),
                  ),
                  gapH(10.h),
                  SizedBox(
                    height: 80.0,
                    child: Center (
                      child: StreamBuilder<Object>(
                          stream: bloc.formValidation.validateTransferForm,
                          builder: (context, snapshot) {
                            return (snapshot.data == true) ? blueBtn(
                                title: 'Proceed',
                                isEnabled: snapshot.hasData,
                                tap: ()  {
                                  bloc.showTransferConfirmation(context, "1");
                                }) : disabledBtn(title: 'Proceed');
                          }
                      ),
                    ),
                  ),
                  gapH(30.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  _selectBank()async{
    var result =  await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child:  SelectBankBottomSheet(banks: bloc.bankList,),
        )
    );
    if(result is Bank){
      setState(() {
        selectedBank = result;
        receivingBankControl.text = selectedBank?.bankname ?? "";
        if (accNumberControl.text.length == 10){
          bloc.add(
              TransactionAccountVerificationEvent(
                  AccountVerification(
                      accountNumber: accNumberControl.text,
                      bankCode: selectedBank?.bankCode ?? ""))
           );
          }
      });
    }
  }
}
