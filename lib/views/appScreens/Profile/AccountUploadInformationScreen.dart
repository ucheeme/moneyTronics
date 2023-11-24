



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../bloc/settings/setting_bloc.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/infos.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountUploadInformation extends StatefulWidget {

  const AccountUploadInformation({super.key});
  @override
  State<AccountUploadInformation> createState() => _AccountUploadInformationState();

}

class _AccountUploadInformationState extends State<AccountUploadInformation> {
  final PageController _sendingAccPageController = PageController();
  int _currentSendingAccPageIndex = 0;
  late SettingBloc bloc;
  @override
  void dispose() {
    _sendingAccPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<SettingBloc>();
    return  darkStatusBar(BlocBuilder<SettingBloc, SettingState>(
  builder: (context, state) {
    if (state is SettingBvnInfoState){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(Duration.zero, (){
          _launchURL(state.response.url);
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
                      gapH(100.h),
                    ],
                  ),
                ), ),],),),);
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
  Container pendingWidget(text) {
    return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 2.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: AppColors.yellow89.withOpacity(0.42),
                          border: Border.all(
                            color: AppColors.yellow85
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
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }
}
