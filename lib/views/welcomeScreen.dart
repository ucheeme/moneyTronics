import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:moneytronic/controllers/Controller/welcomeController.dart';
import 'package:moneytronic/utils/constants/text.dart';
import 'package:moneytronic/views/startScreen/loginOrSignUpScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../UiUtil/customWidgets.dart';
import '../UiUtil/textWidgets.dart';
import '../utils/constants/Themes/colors.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _controller =Get.put(WelcomeController());

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    // controller2.dispose();
    // Dispose the PageController when the widget is removed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                //alignment: AlignmentDirectional.bottomEnd,
                children: [
                  SizedBox(height: 780.h,
                    child: PageView(controller: _controller.controller2,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Image.asset("assets/pictures/newWelcome_one.png",
                          width: double.infinity,
                          height: 780.h, fit: BoxFit.fill,),
                        Image.asset("assets/pictures/newWelcome_two.png",
                          width: double.infinity,
                          height: 780.h, fit: BoxFit.fill,),
                        Image.asset("assets/pictures/newWelcome_three.png",
                          width: double.infinity,
                          height: 780.h, fit: BoxFit.fill,),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 40.h),
                      width: double.infinity,
                      height: 300.h,
                      color: AppColors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView(controller: _controller.controller,
                              children: [
                                pageOne(),
                                pageTwo(),
                                pageThree(),
                              ],
                            ),
                          ),
                          //Spacer(),
                          Row(children: [
                            SmoothPageIndicator(
                              controller: _controller.controller,
                              count: 3,
                              effect: ExpandingDotsEffect(
                                  dotWidth: 25.w,
                                  dotHeight: 11.5.h,
                                  radius: 10.h,
                                  activeDotColor: AppColors.moneyTronicsBlue,
                                  dotColor: AppColors.moneyTronicsSkyBlue,
                                  expansionFactor: 2
                              ),
                              // effect: const WormEffect(
                              //   dotHeight: 16,
                              //   dotWidth: 16,
                              //   type: WormType.thinUnderground,
                              // ),
                            ),
                            const Spacer(),
                            forwardBtn(() {
                              if (_controller.newPageIndex == 2) {
                                setState(() {
                                  _controller.newPageIndex = 0;
                                });
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                    const LoginOrSignUpScreen()
                                  //  const Login()
                                    ));
                              } else {
                                _controller.nextPage();
                              }
                            })
                          ],)


                        ],),

                    ),
                  )


                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  Column pageOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ctmTxtGroteskSB(AppStrings.welcomePageOneHeaderText, AppColors.black, 24.sp,
            weight: FontWeight.w600),
        SizedBox(height: 15.h,),
        ctmTxtGroteskReg(AppStrings.welcomePageOneSubText,
            AppColors.black4D, 18.sp, maxLines: 4),
      ],);
  }

  Column pageTwo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ctmTxtGroteskSB(AppStrings.welcomePageTwoHeaderText, AppColors.black, 24.sp,
            weight: FontWeight.w600),
        SizedBox(height: 15.h,),
        ctmTxtGroteskReg(AppStrings.welcomePageTwoSubText, AppColors.black4D, 18.sp, maxLines: 4),
      ],);
  }

  Column pageThree() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ctmTxtGroteskSB(AppStrings.welcomePageThreeHeaderText, AppColors.black, 22.sp,
            weight: FontWeight.w600,maxLines: 2),
        SizedBox(height: 15.h,),
        ctmTxtGroteskReg(AppStrings.welcomePageThreeSubText, AppColors.black4D, 18.sp, maxLines: 4),
      ],);
  }
}


