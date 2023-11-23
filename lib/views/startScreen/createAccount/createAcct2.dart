import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/utils/userUtil.dart';

import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/otpScreen.dart';
import '../../../cubits/createAcctCubit/create_acct_cubit.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';

class CreateAccountScreen2 extends StatefulWidget {
  const CreateAccountScreen2({Key? key}) : super(key: key);
  @override
  State<CreateAccountScreen2> createState() => _CreateAccountScreen2State();
}

class _CreateAccountScreen2State extends State<CreateAccountScreen2>  {

  String date = "";
  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  late CreateAcctCubit bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<CreateAcctCubit>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.whiteFA,
        body: BlocBuilder<CreateAcctCubit, CreateAcctState>(
          builder: (context, state) {
            if (state is CreateAcctSuccessfulState){
              //   AppUtils.postWidgetBuild(() => openOtpScreen());
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(Duration.zero, (){
                  // AppUtils.showSnack(msg, context);
                  openOtpScreen();
                });
              });
              bloc.initial();
            }
            if (state is CreateAcctErrorState){
              var msg = (state.errorResponse.result?.error?.validationMessages?.isNotEmpty == true)
                  ? (state.errorResponse.result?.error?.validationMessages?[0])
                  : state.errorResponse.result?.message ??"error occurred";
              // AppUtils.postWidgetBuild(() {
              //   AppUtils.showSnack(msg, context);
              // });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(Duration.zero, (){
                 AppUtils.showSnack(msg, context);
                });
              });
              bloc.initial();
            } //1400000105
            return AppUtils().loadingWidget2(
              child: Column(children: [
                appBarBackAndTxt(title: "Create MoneyTronics MFB account",
                    backTap: (){Navigator.pop(context);}),
                Expanded(child:
                Padding(
                  padding: screenPadding(),
                  child: SingleChildScrollView(child: Column(children: [
                    gapHeight(30.h),
                    StreamBuilder<String>(
                        stream: bloc.validation.username,
                        builder: (context, snapshot) {
                          return CustomTextFieldWithValidation (
                            controller:null, title: "Username",
                            details: "", inputType:TextInputType.text,
                            onChange: bloc.validation.setUsername,
                            error: snapshot.hasError ? snapshot.error.toString() : "",
                          );
                        }
                    ),
                    gapHeight(28.h),
                    StreamBuilder<Object>(
                        stream: bloc.validation.bvn,
                        builder: (context, snapshot) {
                          return CustomTextFieldWithValidation(
                            controller:null, title: "Enter your BVN (Bank verification number)",
                            details: "", inputType:TextInputType.number,
                            onChange: bloc.validation.setBvn,
                            error: snapshot.hasError ? snapshot.error.toString() : "",
                          );
                        }),
                    gapHeight(28.h),
                    StreamBuilder<Object>(
                        stream: bloc.validation.password,
                        builder: (context, snapshot) {
                          return CustomTextFieldWithValidation (
                            controller:null, title: "Password",
                            details: "", inputType:TextInputType.text,
                            onChange: bloc.validation.setPassword,
                            error: snapshot.hasError ? snapshot.error.toString() : "",
                            obsureText: true,
                          );
                        }
                    ),
                    gapHeight(28.h),
                    StreamBuilder<Object>(
                        stream: bloc.validation.retypePassword,
                        builder: (context, snapshot) {
                          return CustomTextFieldWithValidation (
                            controller:null, title: "Retype password",
                            details: "", inputType:TextInputType.text,
                            onChange: bloc.validation.setRetypePassword,
                            error: snapshot.hasError ? snapshot.error.toString() : "",
                            obsureText: true,
                          );
                        }
                    ),
                    gapHeight(28.h),
                    MediaQuery.of(context).viewInsets.bottom > 0.0 ?
                    gapHeight(50.h): gapHeight(150.h),// if keyboard is open
                    StreamBuilder<Object>(
                        stream: bloc.validation.userInfo2FormValid,
                        builder: (context, snapshot) {
                          return blueBtn(title: 'Proceed',isEnabled: snapshot.hasData, tap: () {
                            //logReport("case");
                            !snapshot.hasData ? null :
                            bloc.handleAccountCreateEvent(
                                bloc.validation.createUser(context));
                            // _receiptBottomSheet();
                            // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            // const ForgotPasswordScreen()));
                          });
                        }
                    ),
                    gapHeight(70.h),
                  ],),),
                ))
              ],), isLoading: state is CreateAcctLoadingState, context: context,
            );
          },
        ),
      ),
    );
  }


  void openOtpScreen()async {
    await SharedPref.save(SharedPrefKeys.createAccountUserID, bloc.validation.getUsername());
    await SharedPref.save(SharedPrefKeys.createAccountUserPassword, bloc.validation.getUserPassKey());
    var pin = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        OtpScreen(username: bloc.validation.getUsername(),)));
    if (pin != null){
      AppUtils.debug("pin entered $pin");
    }
  }
}

