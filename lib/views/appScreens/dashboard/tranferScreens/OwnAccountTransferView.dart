

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_page_lifecycle/flutter_page_lifecycle.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../UiUtil/amountTextField.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/infos.dart';
import '../../../../UiUtil/normalTextFieldWithValidation.dart';
import '../../../../bloc/TransactionBloc/TransactionFormsValidation.dart';
import '../../../../bloc/TransactionBloc/transaction_bloc.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Constants.dart';
import '../../../../utils/constants/Themes/colors.dart';
import '../../../startScreen/login/loginFirstTime.dart';
import '../dashboard.dart';



class OwnAccountTransferView extends StatefulWidget {
  const OwnAccountTransferView({super.key});
  @override
  State<OwnAccountTransferView> createState() => _OwnAccountTransferViewState();
}

class _OwnAccountTransferViewState extends State<OwnAccountTransferView> {
  TextEditingController amountControl = TextEditingController();
  TextEditingController narrationControl = TextEditingController();
  final PageController _sendingAccPageController = PageController();

  final PageController _receiveAccPageController = PageController();


  late TransactionBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.formValidation = TransactionFormValidation();
      bloc.formValidation.setSelectedAccount(userAccounts![0]);
      bloc.formValidation.setBankCode(Constants.cedarBankCode);
      bloc.formValidation.setDebitAccount(userAccounts?[0].accountnumber ?? "");
      bloc.formValidation.setBankName("Cedar");
      bloc.formValidation.setRecipientName(loginResponse?.fullname ?? "");
      bloc.formValidation.setRecipientAccount(userAccounts![0].accountnumber ?? "");
     }
    );
  }
  @override
  void dispose() {
    _sendingAccPageController.dispose();
    _receiveAccPageController.dispose();
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
              bloc.receiptBottomSheet(context);
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
        return PageLifecycle(
          stateChanged: (bool appeared) {},
          child:
          AppUtils().loadingWidget2(
          context: context,
          isLoading: state is TransactionStateLoading,
            child: Scaffold(
              backgroundColor:AppColors.whiteFA,
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                        selectAccountColumn(
                            title: "Select receiving account",
                            pageView: SizedBox(width: double.infinity,height: 100.h,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _receiveAccPageController,
                                onPageChanged: (int page) {
                                 bloc.formValidation.setRecipientAccount(userAccounts![page].accountnumber ?? "");
                                },
                                itemCount: accountWidget().length,
                                itemBuilder: (context, index) {
                                  return accountWidget()[index];
                                },
                              ),
                            ),
                            pageIndicator: SmoothPageIndicator(
                              controller: _receiveAccPageController,
                              count: accountWidget().length,
                              effect: customIndicatorEffect(),
                            )
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
                          child: StreamBuilder<Object>(
                            stream: bloc.formValidation.narration,
                            builder: (context, snapshot) {
                              return NormalTextFieldWithValidation(
                                labelText: 'Enter narration account',
                                inputType: TextInputType.text,
                                controller: narrationControl,
                                onChange: bloc.formValidation.setNarration,
                              );
                            }
                          ),
                        ),
                        gapH(200.h),
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
                                tap: () {
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
