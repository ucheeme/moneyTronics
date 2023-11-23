

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/searchTextField.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../Utils/appUtil.dart';
import '../../../../Utils/constants/Themes/colors.dart';
import '../../../../bloc/BillBloc/bill_bloc.dart';
import '../../../../models/response/BillsResponse/BillerGroupsResponse.dart';
import '../dashboard.dart';
import 'SelectedBiilerScreen.dart';





class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}


class _BillPaymentScreenState extends State<BillPaymentScreen> {
  TextEditingController searchControl = TextEditingController();

  List<BillerGroupsResponse> filteredBillerList =[];

  late BillBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredBillerList = billerGroupList;

    if(filteredBillerList.isEmpty){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        bloc.add(const BillGetBillerGroupsEvents());
        AppUtils.debug("kkfd");
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    bloc = context.read<BillBloc>();
    return  darkStatusBar(
        GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocBuilder<BillBloc, BillState>(
              builder: (context, state) {
                if (state is BillStateError2){
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Future.delayed(Duration.zero, (){
                      AppUtils.showSnack(state.errorResponse.result?.message ?? "", context);
                      bloc.initial();
                    });
                  });
                }
                if (state is BillGetBillerGroupsSuccessState){
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    filteredBillerList =[];
                    billerGroupList = [];
                    billerGroupList = state.response;
                    filteredBillerList = billerGroupList;
                  });
                  bloc.initial();
                }


              return AppUtils().loadingWidget2(
                context: context,
                isLoading: state is BillStateLoading,
                child: Scaffold(backgroundColor: AppColors.whiteFA,
                  body: Column(children: [
                    appBarBackAndTxt(title: "Bills payment",
                        backTap: (){Navigator.pop(context);}),
                    Container(
                      width: double.infinity,height: 100.h,
                      padding: EdgeInsets.fromLTRB(16.w, 0.h,16.w,10.h),
                      color: AppColors.white,
                      child: SearchTextField(
                          labelText: "Search bill",
                          inputType: TextInputType.text,
                          controller: searchControl,
                          onChange: (val){
                            setState(() {
                              filteredBillerList = billerGroupList
                                  .where((item) => item.name?.toLowerCase()
                                  .contains(val.toLowerCase()) ?? false)
                                  .toList();
                            });
                          }),
                    ),
                    filteredBillerList.isNotEmpty?
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: filteredBillerList.length,
                          itemBuilder: (context, index) {
                            return iconAndTextWidget(
                                "assets/png/icons/global.png",
                                filteredBillerList[index].name,
                                "Pay ${filteredBillerList[index].name} bills",
                                    (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                      SelectedBillerScreen(selectedBiller: filteredBillerList[index],)));
                                });
                          }),
                    ) : const SizedBox(),
                  ],),
                ),
              );
            }
          ),
        ));
  }


}
Widget iconAndTextWidget(image,title,description,tap) {
  return GestureDetector(onTap: tap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.5.h),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.white,borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 41.h,height: 41.h,
            decoration: BoxDecoration(
              color: AppColors.moneyTronicsSkyBlue,borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(child: Image.asset(image,
              width: 20.w,height: 20.h,
            ),
            ),
          ),
          gapW(15.w),
          Column(
            children: [
              SizedBox(width: 200.w,
                  child: ctmTxtGroteskMid(title,AppColors.green0C,18.sp,maxLines: 1)),
              SizedBox(width: 200.w,
                  child: ctmTxtGroteskReg(description,AppColors.green0C,16.sp,maxLines: 1)),
            ],
          )
        ],),
    ),
  );
}
