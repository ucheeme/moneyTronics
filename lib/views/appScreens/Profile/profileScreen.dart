import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/infos.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../UiUtil/toggleSwitch.dart';
import '../../../bloc/settings/setting_bloc.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../../startScreen/login/loginFirstTime.dart';
import '../../startScreen/loginOrSignUpScreen.dart';
import '../settings/ChangePassword.dart';
import '../settings/ResetTransactionPinPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AccountUpgradeScreen.dart';
import 'CreateAdditionalAccountScreen.dart';
import 'CustomerDetailsPage.dart';
import 'WebViewScreen.dart';
import 'accountUpgrade/accountUpgradeScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PageController _sendingAccPageController = PageController();
  int _currentSendingAccPageIndex = 0;
  bool _fingerEnabled = false;
  bool _faceEnabled = false;
  late SettingBloc bloc;

  @override
  void dispose() {
    _sendingAccPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<SettingBloc>();
    return  darkStatusBar(
        BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            if (state is SettingBvnInfoState){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Future.delayed(Duration.zero, (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                      const UpgradeAccount()));
                  _launchURL(state.response.url);
                  bloc.initial();
                });
              });
            }
            return AppUtils().loadingWidget2(
              context: context,
              isLoading: state is SettingStateLoading,
              child: Scaffold(
                backgroundColor: AppColors.whiteFA,
                body: Column(children: [
                  appBarTxtOnly(title: "Profile",),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          selectAccountColumn(
                              title: "Select account",
                              pageView: SizedBox(width: double.infinity,height: 100.h,
                                child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  controller: _sendingAccPageController,
                                  onPageChanged: (int page) {
                                    setState(() {_currentSendingAccPageIndex = page;});
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
                          gapH(20.h),
                          header("Account information"),
                          gapH(20.h),
                          optionWidgetText(title: 'Account details', tap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const CustomerDetailsPage()));
                          }),
                      optionWidgetTextAndStatus(title: 'Account upgrade', tap: (){
                        // if (loginResponse?.registrationStatus == "00") {
                        // }else{
                        // bloc.add(const SettingBvnInfoEvent());
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AccountUpgradeScreen()));
                        //   }
                      },
                          widget: pendingWidget(loginResponse?.registrationStatus == "00" ? "completed" : "pending", loginResponse?.registrationStatus == "00" ?  true : false)),

                          optionWidgetText(title: 'Create new account', tap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateAdditionalAccount()));
                          }),
                          gapH(10.h),
                          header("Biometrics"),
                          gapH(20.h),
                          optionWidgetSwitch(title: 'Enable biometric for login',
                            widget:GestureDetector(onTap: () {
                              setState(() {
                                _fingerEnabled = !_fingerEnabled;
                              });
                            },
                                child: CustomToggleSwitch(value:_fingerEnabled,)),
                            icon: 'assets/png/icons/finger_scan.png',),
                          gapH(10.h),
                          header("Transaction settings"),
                          gapH(20.h),
                          optionWidgetText(title: 'Reset transaction pin', tap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const ResetTransactionPinScreen() ));
                          },
                              image: "assets/png/icons/lock_two.png"
                          ),
                          optionWidgetText(title: 'Change password', tap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChangePasswordScreen() ));
                          },
                              image: "assets/png/icons/key.png"
                          ),
                          optionWidgetText(title: 'Change transaction limit', tap: (){},
                              image: "assets/png/icons/limit.png"
                          ),
                          gapH(10.h),
                          // header("Contact us"),
                          // gapH(20.h),
                          // optionWidgetText(title: 'Enquiries and feedback', tap: (){},
                          //     image: "assets/png/icons/lock_two.png"
                          // ),
                          // optionWidgetText(title: 'Frequently asked questions (Faqs)', tap: (){},
                          //     image: "assets/png/icons/key.png"
                          // ),
                          gapH(10.h),
                          signOutTab(
                              signOut: () {
                                Navigator.pushAndRemoveUntil( context,
                                  MaterialPageRoute(builder: (context) =>
                                  const LoginOrSignUpScreen()),
                                      (Route<dynamic> route) => false,
                                );
                              }),
                          gapH(100.h),
                        ],
                      ),
                    ),
                  ),
                ],),
              ),
            );
          },
        ));
  }

  GestureDetector signOutTab({required void Function()signOut}) {
    return GestureDetector(onTap:signOut,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.w),
        width: 398.w,height: 71.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
            color: AppColors.redF1,
            borderRadius: BorderRadius.circular(19.r),
            border: Border.all(
                color: AppColors.red00,
                width: 0.5.r
            )
        ),
        child: Row(children: [
          Container(
            width: 41.h,height: 38.h,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15.r)
            ),
            child: Center(child:
            Image.asset("assets/png/icons/sign_out.png",
              width: 19.h,height: 19.h,),
            ),
          ),
          gapW(10.w),
          ctmTxtGroteskMid("Sign out",AppColors.black1A,16.sp,maxLines: 1),
          const Spacer(),
          Image.asset("assets/png/icons/arrow_forward.png",
            width: 24.w,height: 24.h,color: AppColors.black,)

        ],),
      ),
    );
  }
  Container pendingWidget(text, bool status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 2.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: status ? AppColors.greenB1 : AppColors.yellow89 .withOpacity(0.42),
          border: Border.all(
              color: status ? AppColors.green24 : AppColors.yellow85
          )
      ),
      child: ctmTxtGroteskReg(text,AppColors.black1A,14.sp),
    );
  }

  GestureDetector optionWidgetText({required String title,
    required void Function() tap, image = "assets/png/icons/global.png"
  }) {
    return GestureDetector(onTap: tap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.w),
        width: 398.w,height: 71.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: AppColors.white,borderRadius: BorderRadius.circular(19.r),
        ),
        child: Row(children: [
          Container(
            width: 41.h,height: 38.h,
            decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(15.r)
            ),
            child: Center(child:
            Image.asset(image,width: 19.h,height: 19.h,),
            ),
          ),
          gapW(10.w),
          ctmTxtGroteskMid(title,AppColors.black1A,16.sp,maxLines: 1),
          const Spacer(),
          Image.asset("assets/png/icons/arrow_forward.png",
            width: 24.w,height: 24.h,color: AppColors.black,)

        ],),
      ),
    );
  }
  Widget optionWidgetSwitch({required String title, required Widget widget,required String icon}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.w),
      width: 398.w,height: 71.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: AppColors.white,borderRadius: BorderRadius.circular(19.r),
      ),
      child: Row(children: [
        Container(
          width: 41.h,height: 38.h,
          decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(15.r)
          ),
          child: Center(child:
          Image.asset(icon,width: 19.h,height: 19.h,),
          ),
        ),
        gapW(10.w),
        ctmTxtGroteskMid(title,AppColors.black1A,16.sp,maxLines: 1),
        const Spacer(),
        widget

      ],),
    );
  }
  GestureDetector optionWidgetTextAndStatus(
      {required String title, required void Function() tap,required Widget widget}) {
    return GestureDetector(onTap: tap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.w),
        width: 398.w,height: 71.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: AppColors.white,borderRadius: BorderRadius.circular(19.r),
        ),
        child: Row(children: [
          Container(
            width: 41.h,height: 38.h,
            decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(15.r)
            ),
            child: Center(child:
            Image.asset("assets/png/icons/global.png",width: 19.h,height: 19.h,),
            ),
          ),
          gapW(10.w),
          ctmTxtGroteskMid(title,AppColors.black1A,16.sp,maxLines: 1),
          const Spacer(),
          widget,
          const Spacer(),
          Image.asset("assets/png/icons/arrow_forward.png",
            width: 24.w,height: 24.h,color: AppColors.black,)

        ],),
      ),
    );
  }
  Container header(title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ctmTxtGroteskMid(title,AppColors.black4D,18.sp),
    );
  }
  _launchURL(address) async {
    AppUtils.debug("the url: $address");
    var url = Uri.parse(address);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      //   var result = await  Navigator.push(
      //       context, MaterialPageRoute(builder: (context) =>
      //       WebViewScreen(address, "https://cedar.com")));
      //   if (result == true){
      //     Navigator.pop(context);
      //   }
    } else {
      throw 'Could not launch $url';
    }
  }
}
