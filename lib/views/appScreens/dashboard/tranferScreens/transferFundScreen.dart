
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/views/appScreens/dashboard/tranferScreens/specialAccountTransferView.dart';



import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../utils/constants/Themes/colors.dart';
import 'OwnAccountTransferView.dart';
import 'otherBanksTransferView.dart';


class TransferFundScreen extends StatefulWidget {
  const TransferFundScreen({super.key});

  @override
  State<TransferFundScreen> createState() => _TransferFundScreenState();
}

class _TransferFundScreenState extends State<TransferFundScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;


  // Add a variable to track the selected tab index
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  darkStatusBar(
        GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
      body: Column(children: [
          appBarBackAndTxt(title: "Transfer funds",
              backTap: (){Navigator.pop(context);}),
           (MediaQuery.of(context).viewInsets.bottom != 0)?// if keybpard is open
            const SizedBox():
          tabIndicator(),
        Expanded(
            child: TabBarView(
              controller: _tabController,
              children:  [
                const OwnAccountTransferView(),
                SpecialAccountTransferView(),
                OtherBanksTransferView()
              ],
            ),
          ),
       ],
      ),
    ),
        ));
  }

  Container tabIndicator() {
    return Container(
        padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w,10.h),
        width: double.infinity,
        color: AppColors.white,
        child: TabBar(
          labelPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.symmetric(vertical:5.h),
          controller: _tabController,
          indicator: BoxDecoration(
            color:AppColors.moneyTronicsSkyBlue,// Customize the color of the indicator
            borderRadius: BorderRadius.circular(15.r), // Customize the border radius
          ),
          isScrollable: false,
          tabs:  [
            Tab(
            child: customTab("Own Account",
                _tabController.index == 0?
                Colors.transparent:AppColors.whiteFA
            ),
            ),
            Tab(
              child: customTab("MoneyTronics",
                  _tabController.index == 1?
                  Colors.transparent:AppColors.whiteFA
              ),
            ),
            Tab(
              child: customTab("Other banks",
                  _tabController.index == 2?
                  Colors.transparent:AppColors.whiteFA
              ),
            ),
            // Tab(text: 'Cedar acct',),
            // Tab(text: 'Other banks'),
          ],
        ),
      );
  }
  Container customTab(String title,color) {
    return Container(
      height: 54.h,width: 119.w,
      //padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Center(child: ctmTxtGroteskMid(title, AppColors.black, 16.sp)),
    );
  }
}

