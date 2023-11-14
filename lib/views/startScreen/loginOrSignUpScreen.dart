import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/views/startScreen/signUpScreen/signUpScreen.dart';

import '../../UiUtil/customWidgets.dart';
import '../../utils/constants/Themes/colors.dart';
import '../../utils/constants/text.dart';
import 'createAccount/createAccountScreen.dart';
import 'login/loginFirstTime.dart';


class LoginOrSignUpScreen extends StatefulWidget {
  const LoginOrSignUpScreen({Key? key}) : super(key: key);

  @override
  State<LoginOrSignUpScreen> createState() => _LoginOrSignUpScreenState();
}

class _LoginOrSignUpScreenState extends State<LoginOrSignUpScreen> {
  //final _appRouter = AppRouter();
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteFA,
      body: SafeArea(
        bottom: true,top: false,
        child: Padding(
          padding: screenPadding(),
          child: Column(
            children: [
              const Spacer(),
              gapHeight(100.h),
              Image.asset("assets/pictures/MFG.png",width: 350.w,height: 88.h,),
              const Spacer(),
              pageButton("assets/icons/user.png",title:AppStrings.loginText,
                  tap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    const LoginFirstTime()));
                  }),
              gapHeight(15.h),
              pageButton("assets/icons/user_add.png",title:AppStrings.signUpText,
                  tap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    const SignUpScreen()));
                  }),
              gapHeight(15.h),
              pageButton("assets/icons/create_icon.png",title:AppStrings.createAcctText,
                  tap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                   const CreateAccountScreen()));
                  }),
              gapHeight(22.h),
            ],),
        ),
      ),
    );
  }

}

