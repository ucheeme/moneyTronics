

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/passwordTextField.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../utils/constants/Themes/colors.dart';





class WelcomeBackLoginScreen extends StatefulWidget {
  const WelcomeBackLoginScreen({super.key});

  @override
  State<WelcomeBackLoginScreen> createState() => _WelcomeBackLoginScreenState();
}

class _WelcomeBackLoginScreenState extends State<WelcomeBackLoginScreen> {

  TextEditingController passwordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.whiteFA,
        body: Column(children: [
          appBarBackAndTxt(title: "Login",
              backTap: (){Navigator.pop(context);}),
          Expanded(child:
          Padding(
            padding: screenPadding(),
            child: SingleChildScrollView(child: Column(children: [
              gapH(30.h),
             Align(alignment:Alignment.centerLeft,child:
             ctmTxtGroteskMid("Welcome back Waaz!", AppColors.primary, 24.sp)),

              gapH(28.h),
              PasswordTextField(
                controller: passwordControl,
                title: "Enter password",
                onChange: (value){},),
              gapH(28.h),
              // MediaQuery.of(context).viewInsets.bottom > 0.0 ?
              // gapH(50.h): gapH(300.h),// if keyboard is open









            ],),),
          )),
          blueBtn(title: 'Proceed', tap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) =>
            // const OtpScreen()));
          }),
          gapH(50.h),
          doNotHaveAccount(tap:(){

          }),
          gapH(70.h),


        ],),
      ),
    );
  }
}
