

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/settings/setting_bloc.dart';
import '../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../bloc/profileBloc/profile_bloc.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../../startScreen/login/loginFirstTime.dart';







class CustomerDetailsPage extends StatefulWidget {
  const CustomerDetailsPage({super.key});

  @override
  State<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage> {
  late ProfileBloc bloc;
  TextEditingController fullNameControl = TextEditingController();
  TextEditingController registeredEmailAddress = TextEditingController();
  TextEditingController registeredPhoneNumber = TextEditingController();
  TextEditingController registeredHomeAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameControl.text = (loginResponse?.fullname ?? "").toUpperCase();
    registeredEmailAddress.text = (loginResponse?.email ?? "").toUpperCase();
    registeredPhoneNumber.text = (loginResponse?.phoneNumber ?? "").toUpperCase();
    registeredHomeAddress.text = "";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(const ProfileCustomerDetailsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<ProfileBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is ProfileStateError){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
              // AppUtils.showSnack(state.errorResponse.result?.message ?? "", context);
                bloc.initial();
              });
            });
          }
          if (state is SettingResetTransactionPinState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                nonDismissibleBottomSheet(context,
                    SimpleSuccessAlertBottomSheet(
                        isSuccessful: true, type: "Successful",
                        description: "Pin changed successfully",
                        accountBtn: "Close",
                        returnTap: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }));
                bloc.initial();
              });
            });
          }
          return AppUtils().loadingWidget2(
            context: context,
            isLoading: state is SettingStateLoading,
            child: Scaffold(resizeToAvoidBottomInset: true,
              backgroundColor: AppColors.whiteFA,

              body: Column(children: [
                appBarBackAndTxt(title: "Account details",
                    backTap: (){Navigator.pop(context);}),
                Expanded(child:
                Padding(
                  padding: screenPadding(),
                  child: SingleChildScrollView(child: Column(children: [
                    gapH(30.h),
                    CustomTextFieldWithValidation(
                      controller: fullNameControl,
                      title: "Full name",
                      details: "",
                      enabled: false,
                      inputType:TextInputType.text,
                      onChange: (v){},
                      error:  "",
                    ),
                    gapH(28.h),
                    CustomTextFieldWithValidation(
                      controller: registeredEmailAddress,
                      title: "Registered email address",
                      details: "",
                      enabled: false,
                      inputType:TextInputType.text,
                      onChange: (v){},
                      error:  "",
                    ),
                    gapH(28.h),
                    CustomTextFieldWithValidation(
                      controller: registeredPhoneNumber,
                      title: "Registered phone number",
                      details: "",
                      enabled: false,
                      inputType:TextInputType.text,
                      onChange: (v){},
                      error:  "",
                    ),
                    gapH(28.h),
                    CustomTextFieldWithValidation(
                      controller: registeredHomeAddress,
                      title: "Registered home address",
                      details: "",
                      enabled: false,
                      inputType:TextInputType.text,
                      onChange: (v){},
                      error:  "",
                    ),
                  ],),),)),
              ],),
            ),
          );
        },
      ),
    );
  }
}
