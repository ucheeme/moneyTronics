import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/views/appScreens/cards/debitCards.dart';
import 'package:moneytronic/views/appScreens/cards/requestNewCard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/infos.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../Utils/constants/Themes/colors.dart';


class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> with SingleTickerProviderStateMixin{

  final PageController _accPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteFA,
      body:  Column(children: [
        appBarTxtOnly(title: "My debit cards",),
        Container(
          padding: screenPadding(),
          color: AppColors.white,
          child: Column(children: [
            gapH(18.h),
            SizedBox(width: double.infinity,height: 100.h,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _accPageController,
                onPageChanged: (int page) {
                },
                itemCount: accountWidget().length,
                itemBuilder: (context, index) {
                  return accountWidget()[index];
                },
              ),
            ),
            gapH(25.h),
            SmoothPageIndicator(
              controller: _accPageController,
              count: accountWidget().length,
              effect: customIndicatorEffect(),
            ),
            gapH(25.h),
          ],),
        ),
        gapH(10.0),
        Column(
          children: [
            gapH(50.0),
            Image.asset("assets/png/images/empty_state.png", height: 200, width: 200,),
            Center(
              child:  ctmTxtGroteskMid("You do not have a card yet",AppColors.black4D, 20.sp),
            ),
          ],
        ),
        gapH(5.h),
      ],),
    );
  }
}
//   late TabController _tabController;
//
//
//   // Add a variable to track the selected tab index
//   int _selectedTabIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(_handleTabChange);
//   }
//
//   void _handleTabChange() {
//     setState(() {
//       _selectedTabIndex = _tabController.index;
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  darkStatusBar(
//         Scaffold(
//           backgroundColor: AppColors.whiteFA,
//           body: Column(children: [
//             appBarTxtOnly(title: "All debit cards",),
//             tabIndicator(),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children:  [
//                   DebitCard(),
//                   RequestNewCard()
//                 ],
//               ),
//             ),
//           ],),
//         ));
//   }
//
//   Container tabIndicator() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w,10.h),
//       width: double.infinity,
//       color: AppColors.white,
//       child: TabBar(
//         labelPadding: EdgeInsets.zero,
//         indicatorSize: TabBarIndicatorSize.label,
//         indicatorPadding: EdgeInsets.symmetric(vertical:5.h),
//         controller: _tabController,
//         indicator: BoxDecoration(
//           color:AppColors.moneyTronicsSkyBlue,// Customize the color of the indicator
//           borderRadius: BorderRadius.circular(15.r), // Customize the border radius
//         ),
//         isScrollable: false,
//         tabs:  [
//           Tab(
//             child: customTab("All debit cards",
//                 _tabController.index == 0?
//                 Colors.transparent:AppColors.whiteFA
//             ),
//           ),
//           Tab(
//             child: customTab("Request new card",
//                 _tabController.index == 1?
//                 Colors.transparent:AppColors.whiteFA
//             ),
//           ),
//           // Tab(text: 'Cedar acct',),
//           // Tab(text: 'Other banks'),
//         ],
//       ),
//     );
//   }
//   Container customTab(String title,color) {
//     return Container(
//       height: 54.h,width: 194.w,
//       //padding: EdgeInsets.symmetric(horizontal: 16.w),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(15.r),
//       ),
//       child: Center(child: ctmTxtGroteskMid(title, AppColors.black, 16.sp)),
//     );
//   }
// }
