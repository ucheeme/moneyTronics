import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/views/appScreens/cards/card.dart';
import 'package:moneytronic/views/appScreens/profile/profile.dart';
import 'package:moneytronic/views/appScreens/transactionHistory/transactionHistoryScreen.dart';

import '../../utils/constants/Themes/colors.dart';
import 'dashboard/dashboard.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator>  with TickerProviderStateMixin{
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  List<Widget> screens = [
    const DashboardScreen(),
    const UserCardScreen(),
    const TransactionHistoryScreen(),
    const ProfileScreen()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: screens),
        bottomNavigationBar: SafeArea(
          bottom: false,
          child: BottomAppBar(
            color: AppColors.white,
            //color: Colors.red,
            height: 79.h,
            child: TabBar(
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 18.w),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: labelStyle(),
                indicatorWeight: 5.h,
                indicator: UnderlineTabIndicator(
                    insets: EdgeInsets.only(bottom: 79.h,left: 0.w,right: 0.w),
                    borderSide: BorderSide(color: AppColors.moneyTronicsBlue,width: 2.h)),
                labelColor: AppColors.moneyTronicsBlue,
                unselectedLabelColor: AppColors.black33,
                controller: tabController,

                tabs: [
                  Container(width: 72.w,
                    color: selectedIndex == 0? AppColors.moneyTronicsSkyBlue:Colors.transparent,
                    child: Tab(
                      iconMargin: EdgeInsets.only(bottom: 9.h),
                      icon: selectedIndex == 0
                          ? iconAsset("assets/icons/activeHome.png")
                          :  iconAsset("assets/icons/home.png"),
                      child:  const Text(
                        'Home',
                        // style: labelStyle(),
                      ),
                    ),
                  ),
                  Container(width: 72.w,
                    color: selectedIndex == 1? AppColors.moneyTronicsSkyBlue:Colors.transparent,
                    child: Tab(
                      iconMargin: EdgeInsets.only(bottom: 9.h),
                      icon: selectedIndex == 1 ?
                      iconAsset("assets/icons/activeCard.png")
                          :  iconAsset("assets/icons/inactiveCard.png"),
                      child:  const Text(
                        'Card',
                        //style: labelStyle(),
                      ),
                    ),
                  ),
                  Container(
                    width: 72.w,color: selectedIndex == 2? AppColors.moneyTronicsSkyBlue:Colors.transparent,
                    child: Tab(
                      iconMargin: EdgeInsets.only(bottom: 9.h),
                      icon: selectedIndex == 2 ?
                      iconAsset("assets/icons/activeCalendar.png")
                          :  iconAsset("assets/icons/inactiveCalendar.png"),
                      child:  const Text(
                        'History',
                        // style: labelStyle(),
                      ),
                    ),
                  ),
                  Container(
                    width: 72.w,color: selectedIndex == 3? AppColors.moneyTronicsSkyBlue
                      :Colors.transparent,
                    child: Tab(
                      iconMargin: EdgeInsets.only(bottom: 9.h),
                      icon: selectedIndex == 3 ?
                      iconAsset("assets/icons/activeProfile.png")
                          :  iconAsset("assets/icons/inactiveProfile.png"),
                      child:  const Text(
                        'Profile',
                        // style: labelStyle(),
                      ),
                    ),
                  ),


                ]),
          ),
        ));
  }

  TextStyle labelStyle() {
    return  TextStyle(
      fontSize: 16.sp,
      fontFamily: 'HKGroteskMedium',
      fontWeight: FontWeight.w500,
    );
  }
  Image iconAsset(image) {
    return Image.asset(image,
      width: 22.w,height: 22.h,fit:BoxFit.contain,);
  }
}

