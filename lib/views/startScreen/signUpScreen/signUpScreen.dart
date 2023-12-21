import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:moneytronic/controllers/Controller/signupController.dart';
import 'package:moneytronic/views/startScreen/login/loginFirstTime.dart';

import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/otpScreen.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../bloc/AuthBloc/auth_bloc.dart';
import '../../../models/response/ApiResponse.dart';
import '../../../models/response/validateExistingUserAccountResponsse.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../../../utils/constants/text.dart';
import '../../CreatExistingUserScreen.dart';
import '../CollectOtpScreen.dart';
import '../loginOrSignUpScreen.dart';
ValidateExistingUserAccountResponse? collectedExistingUserInfo;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController referralCodeControl = TextEditingController();
  late AuthBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.read<AuthBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.whiteFA,
        body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthStateValidateExistingBVN){
                collectedExistingUserInfo = state.response;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(Duration.zero, (){
                    openCollectOtpScreen();
                  });
                });
                bloc.initial();
              }

              if (state is AuthStateError){
                var vMsg = apiErrorFromJson(json.encode(state.errorResponse.result?.error));
                var msg = vMsg.validationMessages?.isEmpty == true ? state.errorResponse.result?.message ?? "error occurred" : vMsg.validationMessages?[0];
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(Duration.zero, (){
                    AppUtils.showSnack(msg ?? "Error occurred", context);
                  });
                });
                bloc.initial();
              }

              return AppUtils().loadingWidget2(
                child: Column(children: [
                  appBarBackAndTxt(title: "Mobile banking registration",
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
                            ctmTxtGroteskMid("Join MoneyTronics MFB Today",
                                weight: FontWeight.w800,
                                AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.start),
                            gapH(20.h),
                            ctmTxtGroteskMid("Sign up now to experience seamless banking, manage your finances, and explore a world of possibilities.",
                                AppColors.black33, 16.sp,maxLines: 2,textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      gapH(30.h),
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
                      StreamBuilder<Object>(
                          stream: bloc.validation.accountNumber,
                          builder: (context, snapshot) {
                            return CustomTextFieldWithValidation(
                              controller:null, title: "Enter account number",
                              details: "", inputType:TextInputType.number,
                              onChange: bloc.validation.setAccNumber,
                              error: snapshot.hasError ? snapshot.error.toString() : "",
                            );
                          }
                      ),
                      CustomTextFieldWithValidation(
                        controller: referralCodeControl, title: "Referral code (Optional)",
                        details: "", inputType:TextInputType.text,
                        onChange: (value){},
                      ),

                      MediaQuery.of(context).viewInsets.bottom > 0.0 ?
                      gapH(50.h): gapH(200.h),// if keyboard is open
                      StreamBuilder<Object>(
                          stream: bloc.validation.bvnValidationFormValid,
                          builder: (context, snapshot) {
                            return  snapshot.hasData && snapshot.data == true ? blueBtn(title: 'Proceed', tap: () {
                              !snapshot.hasData ? null :
                              bloc.add(AuthEventValidateExistingBVN(
                                  bloc.validation.validateExistingUser(context)));
                            }): disabledBtn(title: "Proceed");

                          }
                      ),
                      gapH(50.h),
                      alreadyHaveAccount(tap:(){
                        Navigator.pop(context);
                      }),
                      gapH(70.h),


                    ],),),
                  ))


                ],),
                isLoading: state is AuthStateLoading, context: context,
              );
            }
        ),
      ),
    );
  }
  void openCollectOtpScreen() async {
    var pin = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        CollectOtpScreen()));
    if (pin != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          CreateExistingUserScreen(userData: collectedExistingUserInfo, otp:pin)));
      collectedExistingUserInfo = null;


    }
  }
}


