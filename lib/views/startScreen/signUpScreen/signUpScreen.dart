import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:moneytronic/controllers/Controller/signupController.dart';
import 'package:moneytronic/views/startScreen/login/loginFirstTime.dart';

import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/otpScreen.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../../../utils/constants/text.dart';
import '../loginOrSignUpScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.whiteFA,
        body: Column(children: [
         // Gap(20),
         appBarBackSignUp(title: AppStrings.signUpHeaderText,subText: AppStrings.signUpSubText,
              backTap: (){ Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                  const LoginOrSignUpScreen()
                    //  const Login()
                  ));
         }),
          Expanded(child:
          Padding(
            padding: screenPadding(),
            child: SingleChildScrollView(child: Column(children: [
              gapHeight(30.h),
              CustomTextFieldWithValidation(
                controller: controller.bvnControl, title:AppStrings.enterBVN,
                details: "", inputType:TextInputType.number,
                onChange: (value){},
              ),
             // gapHeight(28.h),
              CustomTextFieldWithValidation(
                controller: controller.accountNumberControl, title: AppStrings.enterAcctNum,
                details: "", inputType:TextInputType.number,
                onChange: (value){},
              ),
             // gapHeight(28.h),
              CustomTextFieldWithValidation(
                controller:controller.referralCodeControl, title: AppStrings.enterReferralCode,
                details: "", inputType:TextInputType.text,
                onChange: (value){},
              ),
              MediaQuery.of(context).viewInsets.bottom > 0.0 ?
              gapHeight(50.h): gapHeight(300.h),// if keyboard is open
              blueBtn(title: AppStrings.proceedText, tap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    OtpScreen(username: "Sam",)));
              }),
             gapHeight(50.h),
              alreadyHaveAccount(tap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    const LoginFirstTime()));
              }),
              gapHeight(70.h),


            ],),),
          ))


        ],),
      ),
    );
  }

}
