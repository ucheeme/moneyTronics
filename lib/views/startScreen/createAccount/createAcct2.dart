import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/utils/userUtil.dart';

import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/otpScreen.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../bloc/AuthBloc/auth_bloc.dart';
import '../../../models/response/ApiResponse.dart';
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

  //late CreateAcctCubit bloc;
  late AuthBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }
  @override
  Widget build(BuildContext context) {
   // bloc = context.read<CreateAcctCubit>();
    bloc = context.read<AuthBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.whiteFA,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthStateUserCreated){
              //   AppUtils.postWidgetBuild(() => openOtpScreen());
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(Duration.zero, (){
                  // AppUtils.showSnack(msg, context);
                  openOtpScreen();
                });
              });
              bloc.initial();
            }
            if (state is AuthStateError){

              print("I am here");
              var vMsg = apiErrorFromJson(json.encode(state.errorResponse.result?.error));
              var msg = vMsg.validationMessages?.isEmpty == true ?
              state.errorResponse.result?.message ??
                  "error occurred" : vMsg.validationMessages?[0];
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(Duration.zero, (){
                  AppUtils.showSnack(msg ?? "Error occurred", context);
                });
              });
              // AppUtils.postWidgetBuild(() {
              //   AppUtils.showSnack(msg, context);
              // });
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ctmTxtGroteskMid("Complete registration",
                              weight: FontWeight.w800,
                              AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.start),
                          gapH(20.0),
                          ctmTxtGroteskMid("Set up your username, password and bvn to complete registration",
                              AppColors.black33, 16.sp,maxLines: 2,textAlign: TextAlign.start),
                        ],
                      ),
                    ),
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
                   // gapHeight(28.h),
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
                   // gapHeight(28.h),
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
                   // gapHeight(28.h),
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
                          return  snapshot.hasData && snapshot.data == true ?
                          blueBtn(title: 'Proceed',isEnabled: snapshot.hasData, tap: () {
                            //logReport("case");
                            !snapshot.hasData ? null :
                            bloc.add(AuthEventCreateUser(bloc.validation.createUser(context)));


                          }) : disabledBtn(title: "Proceed");
                        }
                    ),
                    gapHeight(70.h),
                  ],),),
                ))
              ],), isLoading: state is AuthStateLoading, context: context,
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

