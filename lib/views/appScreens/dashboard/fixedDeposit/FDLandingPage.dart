

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import '../../../../UiUtil/customWidgets.dart';
import '../../../../utils/constants/Themes/colors.dart';
import 'FDBooking.dart';
import 'FDListScreen.dart';

class FixedDepositLandingPage extends  StatefulWidget {
  const FixedDepositLandingPage({Key? key}) : super(key: key);
  @override
  State<FixedDepositLandingPage> createState() => _FixedDepositLandingPageState();
}

class _FixedDepositLandingPageState extends State<FixedDepositLandingPage> with SingleTickerProviderStateMixin{

  late TabController tabController;
  var tabColors = [AppColors.moneyTronicsSkyBlue, AppColors.mistF4];
  int activeTabIndex = 0;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    tabController.addListener(() {
      setState(() {
        activeTabIndex = tabController.index;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            appBarBackAndTxt(title: "Fixed deposit",
                backTap: (){Navigator.pop(context);}),
            Container(
              margin: const EdgeInsets.only(left: 0, right: 0),
              height: 50,
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ) ,
              child: TabBar(
                  controller: tabController,
                  indicator:  const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:  BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  labelColor:  AppColors.black,
                  unselectedLabelColor:  AppColors.black,
                  tabs:  [
                    Tab(child: _buildTab(text: "Booking", color: activeTabIndex == 0 ? tabColors[0] : tabColors[1] ),),
                    Tab(child: _buildTab(text: "Fixed deposit", color: activeTabIndex == 1 ? tabColors[0] : tabColors[1] ),),
                  ]
              ),),
            Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    FDBookingPage(),
                    FDListPage(),
                  ],
                )
            ),]), );
  }
  _buildTab({required String text, required Color color}) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: ShapeDecoration(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10),
          ),
        ),
        color: color,
      ),
      child: Text(text),
    );
  }
}
