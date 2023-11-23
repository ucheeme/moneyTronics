import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:moneytronic/cubits/loginCubit/login_user_cubit.dart';
import 'package:moneytronic/models/requests/LoginRequest.dart';
import 'package:moneytronic/utils/constants/Themes/colors.dart';
import 'package:moneytronic/utils/constants/text.dart';
import 'package:uuid/uuid.dart';

import '../../utils/DeviceUtil.dart';
import '../../utils/appUtil.dart';
import '../../utils/userUtil.dart';
import '../../views/startScreen/setSecurityQuestionsPage.dart';
import '../customWidgets.dart';
import '../textWidgets.dart';

class AccountCreated extends StatefulWidget {
 final String accountNumber;
   const AccountCreated({super.key, required this.accountNumber});

  @override
  State<AccountCreated> createState() => _AccountCreatedState();
}

class _AccountCreatedState extends State<AccountCreated> {
  late LoginUserCubit cubit;
  late String clientId;
  late String clientPass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  _getuserInfo()async{
   String e=await SharedPref.read2(SharedPrefKeys.createAccountUserID);
   String s=await SharedPref.read2(SharedPrefKeys.createAccountUserPassword);

   clientId = e.substring(1,e.length-1);
    clientPass= s.substring(1, s.length-1);
  }
  @override
  Widget build(BuildContext context) {
    cubit = context.read<LoginUserCubit>();
    return BlocBuilder<LoginUserCubit, LoginUserState>(
  builder: (context, state) {
    if(state is LoginUserErrorState){
      var msg = (state.errorResponse.result?.error?.validationMessages?.isNotEmpty == true)
          ? (state.errorResponse.result?.error?.validationMessages?[0])
          : state.errorResponse.result?.message ??"error occurred";
      // AppUtils.postWidgetBuild(() {
      //   AppUtils.showSnack(msg, context);
      // });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          AppUtils.showSnack(msg, context);
        });
      });
      cubit.resetState();
    }
    if(state is LoginUserSuccessState){
      WidgetsBinding.instance.addPostFrameCallback((_) {

        Future.delayed(Duration.zero, (){
          Navigator.push(context, MaterialPageRoute(builder:
              (context) => const SetSecurityQuestionsPage()));
          cubit.resetState();
        });
      });
    }
    return AppUtils.loadingWidget(
      child: Container(
        height: 600.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gapHeight(40.h),
            Lottie.asset('assets/lotties/sucessful.json', height: 250.h,
                width: 250.w),
            ctmTxtGroteskMid(AppStrings.acctCongratulation,AppColors.black,24.sp),
            gapHeight(14.h),
            ctmTxtGroteskMid(AppStrings.heresYourAcctNum, AppColors.black, 16.sp),
            gapHeight(20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical:5.h ),
              height: 42.h,
             width: 343.w,
              decoration: BoxDecoration(
                color: AppColors.moneyTronicsSkyBlue,
                borderRadius: BorderRadius.circular(20.r)
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ctmTxtGroteskMid(AppStrings.acctNumPreText,AppColors.black, 13.sp),
                  ctmTxtGroteskMid(widget.accountNumber,AppColors.moneyTronicsBlue, 15.sp),
                 GestureDetector(
                   onTap: ()async{
                     await Clipboard.setData(ClipboardData(text: '${AppStrings.moneyTronicBankAcctText } '
                         '${widget.accountNumber}')).then(
                             (value) => AppUtils.showSuccessSnack(AppStrings.acctNumCopiedText, context));
                   },
                   child: SizedBox(
                     child:  Row(
                       children: [
                         Image.asset("assets/icons/copyBlack.png",height: 12.h,
                             width: 12.w,),
                         const Gap(4),
                         ctmTxtGroteskMid("Copy", AppColors.black, 13.sp)
                       ],
                     )
                   ),
                 ),


                ],
              ) ,
            ),
            gapHeight(40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: blueBtn(title: "Proceed", tap:(){
                _getuserInfo();
           cubit.handleLoginEvent(LoginRequest(
                 clientId: clientId, clientSecret: clientPass,
               deviceId: const Uuid().v1(),
               deviceModel: deviceModel,
               deviceOs: platformOS, deviceName: deviceName,
               deviceType: 'mobile'));
              }),
            )
          ],
        ),
      ), isLoading: state is LoginUserLoadingState,
    );
  },
);
  }
}
